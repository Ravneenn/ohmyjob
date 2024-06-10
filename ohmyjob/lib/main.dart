import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bloc/client/client_cubit.dart';
import 'core/localizations.dart';
import 'core/routes.dart';
import 'core/storage.dart';
import 'core/themes.dart';
import 'screens/core/loader.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences storage = await SharedPreferences.getInstance();

  runApp(MainApp(
    storage: storage,
  ));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key, required this.storage});
  final SharedPreferences storage;

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool? isFirst;

  getIsFirst() async {
    Storage srtg = Storage();
    bool awaitresult = await srtg.isFirstLaunch();
    setState(() {
      isFirst = awaitresult;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getIsFirst();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        switch (isFirst) {
          case true:
            return ClientCubit(ClientState(
                language: getDeviceLanguage(),
                darkMode: ThemeMode.system == ThemeMode.dark));
          case false:
            return ClientCubit(ClientState(
                language: widget.storage.getString("language")!,
                darkMode: widget.storage.getBool("darkMode")!));
          case null:
            return ClientCubit(ClientState(language: "en", darkMode: false));
        }
      },
      child: BlocBuilder<ClientCubit, ClientState>(builder: (context, state) {
        return MaterialApp.router(
          title: 'Oh My Job',
          debugShowCheckedModeBanner: false,
          routerConfig: routes,
          themeMode: state.darkMode ? ThemeMode.dark : ThemeMode.light,
          theme: lightTheme,
          darkTheme: darkTheme,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', 'US'),
            Locale('tr', 'TR'),
          ],
          locale: Locale(state.language),
        );
      }),
    );
  }
}
