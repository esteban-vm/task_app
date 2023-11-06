import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:task_app/screens/home_screen.dart';
import 'package:task_app/screens/password_recovery_screen.dart';
import 'package:task_app/screens/sign_up_screen.dart';
import 'package:task_app/services/app_utils.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});
  static const id = 'sign_in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
        title: const Text('Sign In'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _emailController,
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
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: const InputDecoration(
                    labelText: 'Insert password',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    } else if (value.length < 6) {
                      return 'Password should be at least 6 characters';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              ElevatedButton(
                onPressed: _handleSignIn,
                child: const Text('Sign In'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(SignUpScreen.id);
                },
                child: const Text("Don't have an account?"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(PasswordRecoveryScreen.id);
                },
                child: const Text('Forget Password?'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSignIn() {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      _auth
          .signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      )
          .then((value) {
        GetStorage().write('token', value.user!.uid);
        Navigator.pushReplacementNamed(context, HomeScreen.id);
      }).onError((_, __) {
        AppUtils.showNotification(context, text: 'An Error has occurred');
      });
    }
  }
}
