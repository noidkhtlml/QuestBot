import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<String> aiResponses = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      aiResponses = prefs.getStringList('ai_history') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Istoric conversații AI'),
        backgroundColor: Colors.deepPurple,
      ),
      body: aiResponses.isEmpty
          ? const Center(child: Text('Niciun răspuns salvat.'))
          : ListView.builder(
        itemCount: aiResponses.length,
        itemBuilder: (context, index) {
          final msg = aiResponses[index];
          return ListTile(
            leading: const Icon(Icons.chat_bubble_outline),
            title: Text(msg),
          );
        },
      ),
    );
  }
}
