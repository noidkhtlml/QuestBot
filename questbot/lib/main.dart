import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:questbot/pages/ai.dart';
import 'package:questbot/pages/astronomie.dart';
import 'package:questbot/pages/chatbot.dart';
import 'package:questbot/pages/electronica.dart';
import 'package:questbot/pages/home_screen.dart';
import 'package:questbot/pages/login_page.dart';
import 'package:questbot/pages/neurostiinte.dart';
import 'package:questbot/pages/signup_page.dart';
import 'package:questbot/pages/statistici.dart';
import 'package:questbot/pages/parinte_ui.dart';
import 'pages/home_page.dart';

void main() async {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
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
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
        '/chatbot': (context) => ChatPage(),
        '/ai': (context) => const AiPage(),
        '/electronica': (context) => const ElectronicaPage(),
        '/astro': (context) => const AstronomiePage(),
        '/neuro': (context) => const NeurostiintaPage(),
        '/statistici': (context) => StatisticiPage(),
        '/parinti': (context) => const ParinteUiPage(),
      },
    );
  }
}
