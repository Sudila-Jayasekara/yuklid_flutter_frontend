import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:yuklid_flutter_frontend/services/user_service.dart';

class AuthProvider extends ChangeNotifier {
  String? _token;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> register(String firstName, String lastName, String email, String password) async {
    final data = await UserService.register(firstName, lastName, email, password);
    _token = data['token'];
    await _storage.write(key: 'token', value: _token);
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    final data = await UserService.authenticate(email, password);
    _token = data['token'];
    await _storage.write(key: 'token', value: _token);
    notifyListeners();
  }

  Future<void> logout() async {
    _token = null;
    await _storage.delete(key: 'token');
    notifyListeners();
  }

  Future<String?> getToken() async {
    if (_token != null) return _token;
    return _token = await _storage.read(key: 'token');
  }

  String? get token => _token;
}