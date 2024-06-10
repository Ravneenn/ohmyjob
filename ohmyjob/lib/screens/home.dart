import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bloc/client/client_cubit.dart';
import '../core/localizations.dart';
import '../core/storage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? dosya;

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
    } on Exception catch (e) {}
  }

  late ClientCubit clientCubit;

  @override
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              const Gap(15),
              CircleAvatar(
                backgroundImage: dosya == null ? null : FileImage(dosya!),
                maxRadius: 150,
              ),
              const Gap(15),
              OutlinedButton(
                  onPressed: () {
                    profilePhotoUpdate();
                  },
                  child: Text(
                      AppLocalizations.of(context).getTranslate("addPhoto"))),
              const Gap(15),
              const Text("Home Screen"),
              Text("lang: ${clientCubit.state.language}"),
              Text("darkMode: ${clientCubit.state.darkMode}"),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () {
                    final storage = Storage();
                    clientCubit.changeDarkMode(
                        newDarkMode: clientCubit.state.darkMode ? false : true);
                    storage.setConfig(
                        darkMode: clientCubit.state.darkMode,
                        language: clientCubit.state.language);
                    setState(() {});
                  },
                  child: const Text("Change Dark Mode")),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  onPressed: () {
                    final storage = Storage();
                    clientCubit.changeLanguage(
                        newLanguage:
                            clientCubit.state.language == "en" ? "tr" : "en");
                    storage.setConfig(
                        darkMode: clientCubit.state.darkMode,
                        language: clientCubit.state.language);
                    setState(() {});
                  },
                  child: const Text("Change Language")),
              Text(AppLocalizations.of(context).getTranslate("home_title")),
            ],
          ),
        ),
      ),
    );
  }
}
