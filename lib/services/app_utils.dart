import 'package:flutter/material.dart';

class AppUtils {
  static void showNotification(
    BuildContext context, {
    required String text,
    Color bgColor = Colors.red,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: bgColor,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
