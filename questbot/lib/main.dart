import 'package:flutter/material.dart';
import 'pages/home_screen.dart';
import 'pages/login_page.dart';
import 'pages/signup_page.dart';
import 'utils/firebase_options.dart';

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
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
      },
    );
  }
}


