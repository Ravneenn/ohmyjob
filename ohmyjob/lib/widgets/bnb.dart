import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
    );
  }
}
