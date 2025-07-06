import 'package:flutter/material.dart';
import '../utils/main_layout.dart';

class StatisticiPage extends StatelessWidget {
  const StatisticiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      selectedIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Statistici'),
          backgroundColor: Colors.pinkAccent,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Progres utilizator',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              _buildStatTile('Matematică', 75),
              _buildStatTile('Astronomie', 40),
              _buildStatTile('Electronică', 60),
              _buildStatTile('AI', 30),
              const SizedBox(height: 40),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Înapoi la Home'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatTile(String title, int percent) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$title: $percent%'),
        LinearProgressIndicator(
          value: percent / 100,
          color: Colors.pink,
          backgroundColor: Colors.pink.shade100,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
