
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(controller: _firstNameController, label: 'First Name'),
            const SizedBox(height: 16),
            CustomTextField(controller: _lastNameController, label: 'Last Name'),
            const SizedBox(height: 16),
            CustomTextField(controller: _emailController, label: 'Email'),
            const SizedBox(height: 16),
            CustomTextField(controller: _passwordController, label: 'Password', isPassword: true),
            const SizedBox(height: 20),
            if (_isLoading)
              const CircularProgressIndicator()
            else
              CustomButton(
                label: 'Register',
                onPressed: () async {
                  setState(() => _isLoading = true);
                  try {
                    await authProvider.register(
                      _firstNameController.text,
                      _lastNameController.text,
                      _emailController.text,
                      _passwordController.text,
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(e.toString().replaceFirst('Exception: ', ''))),
                    );
                  }
                  setState(() => _isLoading = false);
                },
              ),
          ],
        ),
      ),
    );
  }
}
