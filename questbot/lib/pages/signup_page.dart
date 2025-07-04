import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Simulăm o bază de date locală temporară
  static final List<Map<String, String>> _fakeUsers = [];

  void _signUp() {
    final String userId = _userIdController.text.trim();
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    final alreadyExists = _fakeUsers.any((user) => user['email'] == email);

    if (alreadyExists) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Eroare'),
          content: const Text('Există deja un cont cu acest email.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    _fakeUsers.add({
      'userId': userId,
      'email': email,
      'password': password,
    });

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Cont creat'),
        content: const Text('Contul a fost creat cu succes.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // închide dialogul
              Navigator.pushReplacementNamed(context, '/login');
            },
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
        title: const Text("Sign Up"),
        backgroundColor: Colors.pinkAccent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            TextField(
              controller: _userIdController,
              decoration: const InputDecoration(
                labelText: 'User ID',
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
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
                labelText: 'Password',
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signUp,
              child: const Text('Sign Up'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("← Înapoi"),
            )
          ],
        ),
      ),
    );
  }
}
