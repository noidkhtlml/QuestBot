import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

    try {
      // Creează contul în Firebase Auth
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = FirebaseAuth.instance.currentUser;
      final uid = user?.uid;

      // Generează cod familie dacă e elev și nu a introdus unul
      if (isStudent && _familyCode.isEmpty) {
        _familyCode = uid!.substring(0, 6); // simplu, din UID
      }

      // Salvează în Firestore
      if (uid != null) {
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'username': userId,
          'email': email,
          'userType': _userType,
          'familyCode': _familyCode,
        });
      }

      // Navighează mai departe
      if (isParent) {
        Navigator.pushReplacementNamed(context, '/parinte');
      } else {
        Navigator.pushReplacementNamed(context, '/home');
      }
    } on FirebaseAuthException catch (e) {
      String message = 'A apărut o eroare.';
      if (e.code == 'email-already-in-use') {
        message = 'Există deja un cont cu acest email.';
      } else if (e.code == 'weak-password') {
        message = 'Parola este prea slabă. Alege una mai puternică.';
      }

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Eroare'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Înregistrare"),
        backgroundColor: Colors.pinkAccent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            TextField(
              controller: _userIdController,
              decoration: const InputDecoration(
                labelText: 'Nume de utilizator',
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
                labelText: 'Parolă',
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 16),

            // Dropdown pentru tip utilizator
            DropdownButtonFormField<String>(
              value: _userType,
              decoration: const InputDecoration(
                labelText: 'Tip utilizator',
                filled: true,
                fillColor: Colors.white,
              ),
              items: ['Elev', 'Părinte'].map((type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _userType = value!;
                });
              },
            ),

            const SizedBox(height: 16),

            // Câmp cod familie
            if (isStudent || isParent)
              TextField(
                onChanged: (value) => _familyCode = value.trim(),
                decoration: InputDecoration(
                  labelText: isStudent
                      ? 'Cod familie (va fi folosit de părinte)'
                      : 'Introdu codul elevului',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),

            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _signUp,
              child: const Text('Înregistrare'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Înapoi"),
            ),
          ],
        ),
      ),
    );
  }
}
