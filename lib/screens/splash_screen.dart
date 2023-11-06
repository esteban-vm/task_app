import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:task_app/screens/home_screen.dart';
import 'package:task_app/screens/sign_in_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _openNextPage();
  }

  @override
  Widget build(context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void _openNextPage() {
    Timer(const Duration(seconds: 2), () {
      final token = GetStorage().read('token');
      if (token == null || token == '') {
        Navigator.pushReplacementNamed(context, SignInScreen.id);
      } else {
        Navigator.pushReplacementNamed(context, HomeScreen.id);
      }
    });
  }
}
