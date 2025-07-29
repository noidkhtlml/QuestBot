import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import '../database.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    try {
      final user = await LocalDatabase.instance.authenticateUser(email, password);

      if (user == null) {
        _showError('Email sau parolă incorectă.');
        return;
      }

      final role = user['userType'];

      if (!mounted) return;

      if (role == 'Părinte') {
        Navigator.pushReplacementNamed(context, '/parinti');
      } else {
        Navigator.pushReplacementNamed(context, '/home');
      }
    } catch (e) {
      _showError('A apărut o eroare: $e');
    }
  }

  void _showError(String msg) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Logare eșuată'),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Logare"),
        backgroundColor: Colors.pinkAccent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Parolă',
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Logare'),
            ),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/signup'),
              child: const Text('Creează cont nou'),
            ),
          ],
        ),
      ),
    );
  }
}
