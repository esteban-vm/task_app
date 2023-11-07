import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        obscureText: true,
        obscuringCharacter: '*',
        keyboardType: TextInputType.visiblePassword,
        decoration: const InputDecoration(labelText: 'Insert password'),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Password is required';
          } else if (value.length < 6) {
            return 'Password should be at least 6 characters long';
          } else {
            return null;
          }
        },
      ),
    );
  }
}
