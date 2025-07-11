import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import '../core/constants.dart';
import '../models/user.dart';

class AuthService {
  static Future<String?> login(String email, String password) async {
    final res = await http.post(
      Uri.parse('$baseUrl/api/v1/auth/authenticate'),
      body: jsonEncode({'email': email, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );
    if (res.statusCode == 200) {
      return jsonDecode(res.body)['token'];
    }
    return null;
  }

  static Future<bool> register(String fn, String ln, String email, String pw) async {
    final res = await http.post(
      Uri.parse('$baseUrl/api/v1/auth/register'),
      body: jsonEncode({
        'firstname': fn,
        'lastname': ln,
        'email': email,
        'password': pw,
      }),
      headers: {'Content-Type': 'application/json'},
    );
    return res.statusCode == 200;
  }

  static User getUserFromToken(String token) {
    final decoded = JwtDecoder.decode(token);
    return User.fromToken(decoded);
  }
}
