import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yuklid_flutter_frontend/models/question.dart';

class UserService {
  static const String baseUrl = 'https://yuklid.com';

  static Future<Map<String, dynamic>> register(String firstName, String lastName, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/v1/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data.containsKey('token')) {
        return data;
      } else {
        throw Exception(data['message'] ?? 'Registration failed');
      }
    } else {
      throw Exception('Failed to register: ${response.statusCode}');
    }
  }

  static Future<Map<String, dynamic>> authenticate(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/v1/auth/authenticate'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data.containsKey('token')) {
        return data;
      } else {
        throw Exception('Authentication failed');
      }
    } else if (response.statusCode == 401) {
      throw Exception('Invalid credentials');
    } else {
      throw Exception('Failed to authenticate: ${response.statusCode}');
    }
  }



  static Future<Question> getRandomQuestion(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/v1/questions/random'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return Question.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 401) {
      throw Exception('Unauthorized');
    } else {
      throw Exception('Failed to fetch question: ${response.statusCode}');
    }
  }
}