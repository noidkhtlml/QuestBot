import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:questbot/pages/ai.dart';
import 'package:questbot/pages/astronomie.dart';
import 'package:questbot/pages/chatbot.dart';
import 'package:questbot/pages/electronica.dart';
import 'package:questbot/pages/home_screen.dart';
import 'package:questbot/pages/login_page.dart';
import 'package:questbot/pages/neurostiinte.dart';
import 'package:questbot/pages/signup_page.dart';
import 'package:questbot/pages/statistici.dart';
import 'firebase_options.dart';
import 'pages/home_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const QuestBotApp());
}

class QuestBotApp extends StatelessWidget {
  const QuestBotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QuestBot',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFF8A9A),
      ),
      initialRoute: '/screen',
      routes: {
        '/screen': (context) => const HomeScreen(),
        '/home': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/chatbot': (context) => ChatPage(),
        '/ai': (context) => const AiPage(),
        '/electronica': (context) => const ElectronicaPage(),
        '/astro': (context) => const AstronomiePage(),
        '/neuro': (context) => const NeurostiintaPage(),
        '/statistici': (context) => StatisticiPage(),
      },
    );
  }
}
