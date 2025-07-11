import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

class ProfilePage extends StatelessWidget {
  final String token;

  ProfilePage({required this.token});

  @override
  Widget build(BuildContext context) {
    final user = AuthService.getUserFromToken(token);

    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Email: ${user.email}"),
            Text("Issued At: ${user.issuedAt}"),
            Text("Expires At: ${user.expiresAt}"),
          ],
        ),
      ),
    );
  }
}
