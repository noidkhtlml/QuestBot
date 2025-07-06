import 'package:flutter/material.dart';
import '../utils/route_change.dart';
import '../utils/main_layout.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<_SubjectData> subjects = const [
      _SubjectData('Matematică', Icons.calculate, '/neuro'),
      _SubjectData('Astronomie', Icons.public, '/astro'),
      _SubjectData('Electronică', Icons.memory, '/electronica'),
      _SubjectData('AI', Icons.hub, '/ai'),
      _SubjectData('Statistici', Icons.bar_chart, '/statistici'),
      _SubjectData('Chat Bot', Icons.chat, '/chatbot'),
    ];

    return MainLayout(
      selectedIndex: 0,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'questbot',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Ce vrei să înveți azi?',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 24),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: subjects.map((subject) {
                  return GestureDetector(
                    onTap: () => routeChangeNamed(context, subject.route),
                    child: Chip(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(subject.icon, size: 20, color: Colors.black87),
                          const SizedBox(width: 6),
                          Text(subject.title, style: const TextStyle(color: Colors.black87)),
                        ],
                      ),
                      backgroundColor: Colors.grey.shade200,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 40),
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Scrie aici idei, gânduri, notițe...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  filled: true,
                  fillColor: Color(0xFFF5F5F5),
                ),
                maxLines: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SubjectData {
  final String title;
  final IconData icon;
  final String route;

  const _SubjectData(this.title, this.icon, this.route);
}
