import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/client/client_cubit.dart';
import '../core/storage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ClientCubit clientCubit;

  @override
  void initState() {
    super.initState();
    clientCubit = context.read<ClientCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
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
            SizedBox(
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
                child: const Text("Change Language"))
          ],
        ),
      ),
    );
  }
}
