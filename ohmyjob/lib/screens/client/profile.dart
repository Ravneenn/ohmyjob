import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wounter/widgets/bnb.dart';
import '../../bloc/client/client_cubit.dart';
import '../../core/storage.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController nameController =
      TextEditingController(text: "Keyvan Arastes");
  TextEditingController mailController =
      TextEditingController(text: "keyvan.arasteh@ohmyjob.com");
  TextEditingController bioController = TextEditingController(
      text:
          "12 yaşında yazılıma merak salarak başlayan ve o günden bugüne kendini sürekli geliştiren biriyim. 18 farklı yazılım dilinde projeler geliştirdim ve 11 yıl boyunca siber güvenlik alanında çalıştım. Şu anda bir akademisyen olarak, yazılım geliştirme ve güvenliğini sağlama konularında yeni yayınlar yapmaya odaklanıyor ve dünya problemlerine çözüm üretme heyecanı taşıyorum.");

  File? dosya;

  late ClientCubit clientCubit;

  void initState() {
    super.initState();

    clientCubit = context.read<ClientCubit>();
    _loadProfile();
  }

  Storage storage = Storage();

  Future<void> _loadProfile() async {
    String? path = await storage.getProfile();
    setState(() {
      if (path == null) {
        dosya = null;
      } else {
        dosya = File(path);
      }
    });
  }

  profilePhotoUpdate() async {
    final SharedPreferences storage = await SharedPreferences.getInstance();
    try {
      //dosya secimi
      ImagePicker picker = ImagePicker();
      var secilenDosya = await picker.pickImage(
        source: ImageSource.gallery,
        requestFullMetadata: false,
      );

      if (secilenDosya == null) {
        return null;
      } else {
        final File file = File(secilenDosya.path);
        storage.setString("profile", secilenDosya.path);

        setState(() {
          dosya = file;
        });
      }
      // ignore: unused_catch_clause
    } on Exception catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          scrollable: true,
                          title: const Text("Edit Profie"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                controller: nameController,
                              ),
                              Gap(10),
                              TextField(
                                controller: mailController,
                              ),
                              Gap(10),
                              TextField(
                                controller: bioController,
                              )
                            ],
                          ),
                          actions: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    context.pop();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        "Cancel",
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      nameController = TextEditingController(
                                          text: nameController.text);
                                      mailController = TextEditingController(
                                          text: mailController.text);
                                      bioController = TextEditingController(
                                          text: bioController.text);
                                    });
                                    context.pop();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        "Confirm",
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ));
              },
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: dosya == null ? null : FileImage(dosya!),
                  maxRadius: 85,
                ),
              ),
              Gap(15),
              Center(
                child: OutlinedButton(
                    onPressed: () {
                      profilePhotoUpdate();
                    },
                    child: Text("Edit Profile Photo")),
              ),
              const SizedBox(height: 16),
              const Text(
                'Username:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                nameController.text,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              const Divider(height: 1, color: Colors.grey), // Ayırıcı ekleniyor
              const SizedBox(height: 8),
              const Text(
                'Email:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                mailController.text,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              const Divider(height: 1, color: Colors.grey), // Ayırıcı ekleniyor
              const SizedBox(height: 8),
              const Text(
                'Bio:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                bioController.text,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
        bottomNavigationBar: bnb(
          index: 1,
        ));
  }
}
