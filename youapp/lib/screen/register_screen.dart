import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> register() async {
    final response = await http.post(
      Uri.parse('http://techtest.youapp.ai/api/register'),
      body: jsonEncode({
        "email": emailController.text,
        "username": usernameController.text,
        "password": passwordController.text,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      if (responseData["message"] == "User has been registered") {
        Navigator.pop(context); // Kembali ke halaman login
      } else {
        showError("Failed to register");
      }
    } else {
      showError("Error during registration");
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
        middle: Text("Register"),
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
                controller: usernameController,
                placeholder: "Username",
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
                onPressed: register,
                child: const Text("Register"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}