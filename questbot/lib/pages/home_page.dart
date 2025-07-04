import 'package:flutter/material.dart';
import 'matematica.dart';
import 'astronomie.dart';
import 'electronica.dart';
import 'ai.dart';
import 'statistici.dart';
import 'chatbot.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  final List<Widget> pages = const [
    MatematicaPage(),
    AstronomiePage(),
    ElectronicaPage(),
    AiPage(),
    StatisticiPage(),
    ChatPage(),
  ];

  final List<String> titles = [
    'Matematică',
    'Astronomie',
    'Electronică',
    'AI',
    'Statistici',
    'Chat Bot',
  ];

  final List<IconData> icons = [
    Icons.functions,
    Icons.public,
    Icons.memory,
    Icons.hub,
    Icons.bar_chart,
    Icons.tag_faces,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // fundal alb
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Salut! Ce vrei să înveți azi?',
          style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: pages.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // două coloane
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1.2,
          ),
          itemBuilder: (context, index) {
            return buildSpotifyCard(index);
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() => selectedIndex = index);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => pages[index]),
          );
        },
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.functions), label: 'Matematică'),
          BottomNavigationBarItem(icon: Icon(Icons.public), label: 'Astronomie'),
          BottomNavigationBarItem(icon: Icon(Icons.memory), label: 'Electronică'),
          BottomNavigationBarItem(icon: Icon(Icons.hub), label: 'AI'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Statistici'),
          BottomNavigationBarItem(icon: Icon(Icons.tag_faces), label: 'Chat'),
        ],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  Widget buildSpotifyCard(int index) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => pages[index]),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icons[index], size: 40, color: Colors.black),
            const SizedBox(height: 10),
            Text(
              titles[index],
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
