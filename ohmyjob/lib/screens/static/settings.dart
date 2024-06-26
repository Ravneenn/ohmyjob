import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/client/client_cubit.dart';
import '../../core/storage.dart';
import '../../widgets/tranlator.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Map<String, dynamic>? configs;

  late ClientCubit clientCubit;

  @override
  void initState() {
    super.initState();

    clientCubit = context.read<ClientCubit>();
  }

  Storage storage = Storage();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(tranlator(context, "settings")),
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        tranlator(context, "darkMode"),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      Switch(
                        value: clientCubit.state.darkMode,
                        onChanged: (value) {
                          final storage = Storage();
                          clientCubit.changeDarkMode(
                              newDarkMode:
                                  clientCubit.state.darkMode ? false : true);
                          storage.setConfig(
                              darkMode: clientCubit.state.darkMode,
                              language: clientCubit.state.language);
                          setState(() {});
                        },
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        tranlator(context, "language"),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      DropdownButton<String>(
                        value: clientCubit.state.language,
                        items: const [
                          DropdownMenuItem(value: "tr", child: Text("Türkçe")),
                          DropdownMenuItem(value: "en", child: Text("English"))
                        ],
                        onChanged: (String? value) {
                          if (value == null) {
                            return;
                          } else {
                            clientCubit.changeLanguage(newLanguage: value);
                            storage.setConfig(
                                darkMode: clientCubit.state.darkMode,
                                language: clientCubit.state.language);
                            setState(() {});
                          }
                          ;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
