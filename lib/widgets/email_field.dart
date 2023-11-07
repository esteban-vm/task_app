import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {
  const EmailField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(labelText: 'Insert email'),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Email is required';
          } else {
            return null;
          }
        },
      ),
    );
  }
}
