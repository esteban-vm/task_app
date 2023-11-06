import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_app/screens/sign_in_screen.dart';
import 'package:task_app/services/app_utils.dart';

class PasswordRecoveryScreen extends StatefulWidget {
  const PasswordRecoveryScreen({super.key});
  static const id = 'password_recovery';

  @override
  State<PasswordRecoveryScreen> createState() => _PasswordRecoveryScreenState();
}

class _PasswordRecoveryScreenState extends State<PasswordRecoveryScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Password Recovery'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter your email',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            ElevatedButton(
              onPressed: _handlePasswordRecovery,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(100.0, 40.0),
                maximumSize: const Size(200.0, 40.0),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.mail_outline),
                  SizedBox(width: 10.0),
                  Text('Reset Password'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handlePasswordRecovery() {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      _auth.sendPasswordResetEmail(email: _emailController.text.trim()).then(
        (_) {
          Navigator.of(context).pushReplacementNamed(SignInScreen.id);
          AppUtils.showNotification(
            context,
            text: 'Check your email',
            bgColor: Colors.green,
          );
        },
      ).onError(
        (_, __) {
          AppUtils.showNotification(
            context,
            text: 'An Error has occurred',
          );
        },
      );
    }
  }
}
