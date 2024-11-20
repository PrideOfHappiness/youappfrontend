import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'profile_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    final response = await http.post(
      Uri.parse('http://techtest.youapp.ai/api/login'),
      body: jsonEncode({
        "email": emailController.text,
        "password": passwordController.text,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData["message"] == "User has been logged in") {
        Navigator.push(
          context,
          CupertinoPageRoute(builder: (context) => const ProfileScreen()),
        );
      } else {
        showError("Invalid login credentials");
      }
    } else {
      showError("Error logging in");
    }
  }

  void showError(String message) {
    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: const Text("Error"),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Login"),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CupertinoTextField(
                controller: emailController,
                placeholder: "Email",
                padding: const EdgeInsets.all(16),
              ),
              const SizedBox(height: 20),
              CupertinoTextField(
                controller: passwordController,
                placeholder: "Password",
                obscureText: true,
                padding: const EdgeInsets.all(16),
              ),
              const SizedBox(height: 20),
              CupertinoButton.filled(
                onPressed: login,
                child: const Text("Login"),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (context) => const RegisterScreen()),
                  );
                },
                child: const Text("No account? Register here"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}