import 'package:flutter/material.dart';
import 'package:task_app/screens/home_screen.dart';
import 'package:task_app/screens/recycle_bin_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeScreen.id:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case RecycleBinScreen.id:
        return MaterialPageRoute(builder: (_) => const RecycleBinScreen());

      default:
        return null;
    }
  }
}
