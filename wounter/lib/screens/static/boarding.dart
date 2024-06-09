import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BoardingScreen extends StatefulWidget {
  const BoardingScreen({super.key});

  @override
  State<BoardingScreen> createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
                child: InkWell(
                    onTap: () {
                      GoRouter.of(context).replace("/home");
                    },
                    child: Text("Welcome")))));
  }
}
