import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_app/screens/sign_in_screen.dart';
import 'package:task_app/services/app_utils.dart';
import 'package:task_app/widgets/email_field.dart';
import 'package:task_app/widgets/password_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static const id = 'sign_up';

  @override
  State<SignUpScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignUpScreen> {
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
        title: const Text('Sign Up'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            EmailField(controller: _emailController),
            PasswordField(controller: _passwordController),
            ElevatedButton(
              onPressed: _handleSignUp,
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSignUp() {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      _auth
          .createUserWithEmailAndPassword(
            email: _emailController.text,
            password: _passwordController.text,
          )
          .then(
            (_) => Navigator.pushReplacementNamed(
              context,
              SignInScreen.id,
            ),
          )
          .onError(
            (_, __) => AppUtils.showNotification(
              context,
              text: 'An Error has occurred',
            ),
          );
    }
  }
}
