import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = 'http://localhost:4000/bmpr/users'; // Cambié la URL base

  static Future<Map> getUsers() async {
    final response = await http.get(Uri.parse('$baseUrl')); // Cambié la URL
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load users');
    }
  }

  static Future<void> addUser(Map<String, String> newUser) async {
    final response = await http.post(
      Uri.parse('$baseUrl/create'), // Cambié la URL para que apunte al endpoint correcto
      headers: {"Content-Type": "application/json"},
      body: json.encode(newUser),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add user');
    }
  }
}
