import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'profile_page.dart';
import 'register_page.dart';

class LoginPage extends StatelessWidget {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(children: [
          TextField(controller: emailCtrl, decoration: InputDecoration(labelText: "Email")),
          TextField(controller: passCtrl, decoration: InputDecoration(labelText: "Password"), obscureText: true),
          ElevatedButton(
            onPressed: () async {
              final token = await AuthService.login(emailCtrl.text, passCtrl.text);
              if (token != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ProfilePage(token: token)),
                );
              }
            },
            child: Text("Login"),
          ),
          TextButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RegisterPage())),
            child: Text("Go to Register"),
          )
        ]),
      ),
    );
  }
}
