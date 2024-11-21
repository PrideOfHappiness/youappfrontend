import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isSubmitting = false;

  // Function untuk melakukan register
  Future<void> _register() async {
    final email = _emailController.text.trim();
    final username = _usernameController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (password != confirmPassword) {
      _showAlert("Password dan Confirm Password tidak cocok");
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      final response = await http.post(
        Uri.parse('https://techtest.youapp.ai/api/register'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 201) {
        _showAlert("User berhasil didaftarkan!");
        // Reset input fields
        _emailController.clear();
        _usernameController.clear();
        _passwordController.clear();
        _confirmPasswordController.clear();
      } else {
        final responseData = jsonDecode(response.body);
        _showAlert(responseData['message'] ?? 'Gagal mendaftarkan user');
      }
    } catch (e) {
      _showAlert("Terjadi kesalahan: ${e.toString()}");
    } finally {
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  // Function untuk menampilkan alert
  void _showAlert(String message) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text("Informasi"),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
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
        leading: Icon(CupertinoIcons.back),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CupertinoTextField(
                  controller: _emailController,
                  placeholder: "Enter Email",
                  padding: const EdgeInsets.all(16),
                  prefix: const Icon(CupertinoIcons.mail,
                      color: CupertinoColors.systemGrey),
                  decoration: BoxDecoration(
                    color: CupertinoColors.systemGrey5,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(height: 20),
                CupertinoTextField(
                  controller: _usernameController,
                  placeholder: "Create Username",
                  padding: const EdgeInsets.all(16),
                  prefix: const Icon(CupertinoIcons.person,
                      color: CupertinoColors.systemGrey),
                  decoration: BoxDecoration(
                    color: CupertinoColors.systemGrey5,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(height: 20),
                CupertinoTextField(
                  controller: _passwordController,
                  placeholder: "Create Password",
                  obscureText: true,
                  padding: const EdgeInsets.all(16),
                  prefix: const Icon(CupertinoIcons.lock,
                      color: CupertinoColors.systemGrey),
                  suffix: const Icon(CupertinoIcons.eye,
                      color: CupertinoColors.systemGrey),
                  decoration: BoxDecoration(
                    color: CupertinoColors.systemGrey5,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(height: 20),
                CupertinoTextField(
                  controller: _confirmPasswordController,
                  placeholder: "Confirm Password",
                  obscureText: true,
                  padding: const EdgeInsets.all(16),
                  prefix: const Icon(CupertinoIcons.lock_shield,
                      color: CupertinoColors.systemGrey),
                  suffix: const Icon(CupertinoIcons.eye,
                      color: CupertinoColors.systemGrey),
                  decoration: BoxDecoration(
                    color: CupertinoColors.systemGrey5,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF4CAF50), Color(0xFF81C784)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: CupertinoButton(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    onPressed: _isSubmitting ? null : _register,
                    child: _isSubmitting
                        ? const CupertinoActivityIndicator()
                        : const Text(
                      "Register",
                      style: TextStyle(color: CupertinoColors.white),
                    ),
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