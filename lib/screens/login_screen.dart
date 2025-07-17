import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yuklid_flutter_frontend/providers/auth_provider.dart';
import 'package:yuklid_flutter_frontend/screens/register_screen.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(controller: _emailController, label: 'Email'),
            const SizedBox(height: 16),
            CustomTextField(controller: _passwordController, label: 'Password', isPassword: true),
            const SizedBox(height: 20),
            if (_isLoading)
              const CircularProgressIndicator()
            else
              CustomButton(
                label: 'Login',
                onPressed: () async {
                  setState(() => _isLoading = true);
                  try {
                    await authProvider.login(_emailController.text, _passwordController.text);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(e.toString().replaceFirst('Exception: ', ''))),
                    );
                  }
                  setState(() => _isLoading = false);
                },
              ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterScreen())),
              child: const Text('Don’t have an account? Register'),
            ),
          ],
        ),
      ),
    );
  }
}
