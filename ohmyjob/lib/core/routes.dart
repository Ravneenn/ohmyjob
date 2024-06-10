import 'package:go_router/go_router.dart';
import '../models/Job.dart';
import '../screens/client/profile.dart';
import '../screens/core/error.dart';
import '../screens/core/loader.dart';
import '../screens/static/settings.dart';
import '../screens/home.dart';
import '../screens/static/advert.dart';
import '../screens/static/boarding.dart';

final routes =
    GoRouter(errorBuilder: (context, state) => const ErrorScreen(), routes: [
  GoRoute(
    path: "/",
    builder: (context, state) => const LoaderScreen(),
  ),
  GoRoute(
    path: "/boarding",
    builder: (context, state) => const BoardingScreen(),
  ),
  GoRoute(
    path: "/settings",
    builder: (context, state) => const SettingsScreen(),
  ),
  GoRoute(
    path: "/home",
    builder: (context, state) => HomeScreen(),
  ),
  GoRoute(
    path: "/jobDetail",
    builder: (context, state) {
      final job = state.extra as Job;
      return AdvertScreen(job: job);
    },
  ),
  GoRoute(
    path: "/profile",
    builder: (context, state) => ProfilePage(),
  ),
]);
