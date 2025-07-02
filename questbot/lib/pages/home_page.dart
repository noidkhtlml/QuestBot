import 'package:flutter/material.dart';
import 'pages/matematica.dart';
import 'pages/astronomie.dart';
import 'pages/electronica.dart';
import 'pages/ai.dart';
import 'pages/statistici.dart';
import 'pages/chatbot.dart';

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
    AIPage(),
    StatisticiPage(),
    ChatBotPage(),
  ];

  final List<NavigationRailDestination> destinations = const [
    NavigationRailDestination(icon: Icon(Icons.home), label: Text('Acasă')),
    NavigationRailDestination(icon: Icon(Icons.bar_chart), label: Text('Statistici')),
    NavigationRailDestination(icon: Icon(Icons.public), label: Text('Astronomie')),
    NavigationRailDestination(icon: Icon(Icons.memory), label: Text('Electronică')),
    NavigationRailDestination(icon: Icon(Icons.history), label: Text('Istoric')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: selectedIndex,
            onDestinationSelected: (index) => setState(() => selectedIndex = index),
            labelType: NavigationRailLabelType.all,
            destinations: destinations,
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Text(
                      'Salut! Ce vrei să înveți azi?',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    alignment: WrapAlignment.center,
                    children: [
                      buildButton(context, 'Matematică', Icons.square_root_alt, 0),
                      buildButton(context, 'Astronomie', Icons.public, 1),
                      buildButton(context, 'Electronică', Icons.memory, 2),
                      buildButton(context, 'AI', Icons.hub, 3),
                      buildButton(context, 'Statistici', Icons.bar_chart, 4),
                      buildButton(context, 'Chat Bot', Icons.tag_faces, 5),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildButton(BuildContext context, String title, IconData icon, int pageIndex) {
    return ElevatedButton.icon(
      icon: Icon(icon),
      label: Text(title),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
        textStyle: const TextStyle(fontSize: 18),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => pages[pageIndex]),
        );
      },
    );
  }
}
