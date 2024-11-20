import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://techtest.youapp.ai/api";
  static const Map<String, String> headers = {
    "Content-Type": "application/json",
  };

  static Future<bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/login"),
      headers: headers,
      body: jsonEncode({"email": email, "password": password}),
    );
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  static Future<bool> register(String email, String username, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/register"),
      headers: headers,
      body: jsonEncode({
        "email": email,
        "username": username,
        "password": password,
      }),
    );
    if (response.statusCode == 201) {
      return true;
    }
    return false;
  }

  static Future<Map<String, dynamic>?> getProfile(String token) async {
    final response = await http.get(
      Uri.parse("$baseUrl/getProfile"),
      headers: {"x-access-token": token},
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }

  static Future<bool> createProfile(String token, Map<String, dynamic> profileData) async {
    final response = await http.post(
      Uri.parse("$baseUrl/createProfile"),
      headers: {"x-access-token": token},
      body: jsonEncode(profileData),
    );
    return response.statusCode == 201;
  }

  static Future<bool> updateProfile(String token, Map<String, dynamic> profileData) async {
    final response = await http.put(
      Uri.parse("$baseUrl/updateProfile"),
      headers: {"x-access-token": token},
      body: jsonEncode(profileData),
    );
    return response.statusCode == 200;
  }
}