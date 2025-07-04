import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
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
      home: const HomePage(),
    );
  }
}
