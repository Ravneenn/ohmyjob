import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'tranlator.dart';

// ignore: must_be_immutable
class bnb extends StatelessWidget {
  bnb({
    super.key,
    required this.index,
  });

  int index;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: index,
      onTap: (index) {
        if (index == 0) {
          GoRouter.of(context).push("/home");
        } else if (index == 1) {
          GoRouter.of(context).push("/profile");
        } else if (index == 2) {
          GoRouter.of(context).push("/settings");
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: tranlator(context, "home"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: tranlator(context, "profile"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: tranlator(context, "settings"),
        ),
      ],
    );
  }
}
