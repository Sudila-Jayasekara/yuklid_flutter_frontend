import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class RegisterPage extends StatelessWidget {
  final fn = TextEditingController();
  final ln = TextEditingController();
  final email = TextEditingController();
  final pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(children: [
          TextField(controller: fn, decoration: InputDecoration(labelText: "First Name")),
          TextField(controller: ln, decoration: InputDecoration(labelText: "Last Name")),
          TextField(controller: email, decoration: InputDecoration(labelText: "Email")),
          TextField(controller: pass, decoration: InputDecoration(labelText: "Password"), obscureText: true),
          ElevatedButton(
            onPressed: () async {
              final success = await AuthService.register(fn.text, ln.text, email.text, pass.text);
              if (success) Navigator.pop(context);
            },
            child: Text("Register"),
          ),
        ]),
      ),
    );
  }
}
