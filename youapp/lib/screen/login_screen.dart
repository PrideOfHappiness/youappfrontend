import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailUsernameController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> login(String emailUsername, String password) async {
    final url = Uri.parse('https://techtest.youapp.ai/api/login');
    final bool isEmail = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
        .hasMatch(emailUsername);

    try {
      final requestBody = isEmail
          ? {'email': emailUsername, 'password': password}
          : {'username': emailUsername, 'password': password};

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json', 'accept': '*/*'},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        print('User has been logged in');
      } else {
        print('Login failed: ${response.body}');
      }
    } catch (e) {
      print('Oops, There is an error: $e');
    }
  }

  void _validateAndLogin() {
    final emailUsername = _emailUsernameController.text.trim();
    final password = _passwordController.text.trim();

    if (emailUsername.isEmpty || password.isEmpty) {
      print('Invalid Login: All columns must be filled!');
      return;
    }
    login(emailUsername, password);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Login"),
      ),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF000428), Color(0xFF004e92)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Username/Email Field
                Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF434343), Color(0xFF858585)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: CupertinoTextField(
                    controller: _emailUsernameController,
                    placeholder: "Enter Username/Email",
                    decoration: null,
                    padding: const EdgeInsets.all(16),
                    style: const TextStyle(color: Colors.white),
                    placeholderStyle: const TextStyle(color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 20),
                // Password Field
                Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF434343), Color(0xFF858585)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: CupertinoTextField(
                    controller: _passwordController,
                    placeholder: "Enter Password",
                    obscureText: true,
                    decoration: null,
                    padding: const EdgeInsets.all(16),
                    style: const TextStyle(color: Colors.white),
                    placeholderStyle: const TextStyle(color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 20),
                // Login Button
                GestureDetector(
                  onTap: _validateAndLogin,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF6A82FB), Color(0xFFFC5C7D)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => const RegisterScreen()),
                    );
                  },
                  child: const Text(
                    "No account? Register here",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}