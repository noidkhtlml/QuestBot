import 'package:flutter/material.dart';
import '../database.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _userType = 'Elev'; // default
  String _familyCode = '';

  bool get isParent => _userType == 'Părinte';
  bool get isStudent => _userType == 'Elev';

  Future<void> _signUp() async {
    final String userId = _userIdController.text.trim();
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    if (userId.isEmpty || email.isEmpty || password.isEmpty) {
      _showError('Completează toate câmpurile.');
      return;
    }

    // Verificare email duplicat
    final existing = await LocalDatabase.instance.getUserByEmail(email);
    if (existing != null) {
      _showError('Există deja un cont cu acest email.');
      return;
    }


    if (isStudent && _familyCode.isEmpty) {
      _familyCode = DateTime.now().millisecondsSinceEpoch.toString().substring(5, 11);
    }

    if (isParent) {
      final copii = await LocalDatabase.instance.getEleviForParinte(_familyCode);
      if (copii.isEmpty) {
        _showError('Codul introdus nu este asociat cu niciun elev.');
        return;
      }
    }

    await LocalDatabase.instance.createUser({
      'username': userId,
      'email': email,
      'password': password,
      'userType': _userType,
      'familyCode': _familyCode,
    });

    if (!mounted) return;

    if (isParent) {
      Navigator.pushReplacementNamed(context, '/parinti');
    } else {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  void _showError(String msg) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Eroare'),
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
        title: const Text("Creare cont"),
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
              decoration: const InputDecoration(labelText: 'Nume utilizator'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Parolă'),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _userType,
              items: const [
                DropdownMenuItem(value: 'Elev', child: Text('Elev')),
                DropdownMenuItem(value: 'Părinte', child: Text('Părinte')),
              ],
              onChanged: (value) {
                setState(() {
                  _userType = value ?? 'Elev';
                });
              },
              decoration: const InputDecoration(labelText: 'Tip utilizator'),
            ),
            const SizedBox(height: 16),
            if (isParent)
              TextField(
                onChanged: (value) => _familyCode = value,
                decoration: const InputDecoration(
                  labelText: 'Cod familie (de la copil)',
                ),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signUp,
              child: const Text('Înregistrare'),
            ),
          ],
        ),
      ),
    );
  }
}
