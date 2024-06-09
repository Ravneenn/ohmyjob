import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bloc/client/client_cubit.dart';
import 'core/routes.dart';
import 'core/storage.dart';
import 'core/themes.dart';
import 'screens/core/loader.dart';

void main() async {
  final SharedPreferences storage = await SharedPreferences.getInstance();
  Storage strg = Storage();
  bool isFirst = await strg.isFirstLaunch();
  runApp(MainApp(
    storage: storage,
    isFirst: isFirst,
  ));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key, required this.storage, required this.isFirst});
  final SharedPreferences storage;
  final bool isFirst;

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ClientCubit(widget.isFirst == true
          ? ClientState(
              language: getDeviceLanguage(),
              darkMode: ThemeMode.system == ThemeMode.dark)
          : ClientState(
              language: widget.storage.getString("language")!,
              darkMode: widget.storage.getBool("darkMode")!)),
      child: BlocBuilder<ClientCubit, ClientState>(builder: (context, state) {
        return MaterialApp.router(
          title: 'Wounter',
          debugShowCheckedModeBanner: false,
          routerConfig: routes,
          themeMode: state.darkMode ? ThemeMode.dark : ThemeMode.light,
          theme: lightTheme,
          darkTheme: darkTheme,
        );
      }),
    );
  }
}
