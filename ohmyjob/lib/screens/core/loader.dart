// ignore_for_file: use_build_context_synchronously
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/storage.dart';

class LoaderScreen extends StatefulWidget {
  const LoaderScreen({super.key});

  @override
  State<LoaderScreen> createState() => _LoaderScreenState();
}

class _LoaderScreenState extends State<LoaderScreen> {
  loadApp() async {
    final storage = Storage();
    final firstLaunch = await storage.isFirstLaunch();
    if (firstLaunch) {
      storage.firstLauched();
      GoRouter.of(context).replace("/boarding");
    } else {
      GoRouter.of(context).replace("/home");
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2500), () {
      loadApp();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 100,
          height: 100,
          child: const CircularProgressIndicator(
            strokeWidth: 2,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

getDeviceLanguage() {
  final String defaultLocale;
  if (!kIsWeb) {
    defaultLocale = Platform.localeName;
  } else {
    defaultLocale = "en";
  }
  final langParts = defaultLocale.split("_");
  final supportedLanguages = ["en", "tr", "fr", "es"];

  final String finalLang;

  if (supportedLanguages.contains(langParts[0])) {
    finalLang = langParts[0];
  } else {
    finalLang = "en";
  }

  return finalLang;
}
