import 'package:flutter/material.dart';
import 'package:task_app/screens/home_screen.dart';
import 'package:task_app/screens/password_recovery_screen.dart';
import 'package:task_app/screens/recycle_bin_screen.dart';
import 'package:task_app/screens/sign_in_screen.dart';
import 'package:task_app/screens/sign_up_screen.dart';

class AppRouter {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeScreen.id:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );

      case RecycleBinScreen.id:
        return MaterialPageRoute(
          builder: (_) => const RecycleBinScreen(),
        );

      case SignUpScreen.id:
        return MaterialPageRoute(
          builder: (_) => const SignUpScreen(),
        );

      case SignInScreen.id:
        return MaterialPageRoute(
          builder: (_) => const SignInScreen(),
        );

      case PasswordRecoveryScreen.id:
        return MaterialPageRoute(
          builder: (_) => const PasswordRecoveryScreen(),
        );

      default:
        return null;
    }
  }
}
