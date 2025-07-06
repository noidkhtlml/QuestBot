import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/main_layout.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatAIPageState();
}

class _ChatAIPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> aiResponses = [];
  bool _isSending = false;

  final _model = GenerativeModel(
    model: 'gemini-1.5-flash',
    apiKey: 'AIzaSyBOJFkhhQrQG8x6s6AIzqTDa8uncVEwNmU',
  );

  Future<void> _addToHistory(String aiText) async {
    final prefs = await SharedPreferences.getInstance();
    final history = prefs.getStringList('ai_history') ?? [];
    history.add(aiText);
    await prefs.setStringList('ai_history', history);
  }

  Future<void> _getAIResponse(String question) async {
    setState(() {
      _isSending = true;
      aiResponses.add({'role': 'user', 'text': question});
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      final history = prefs.getStringList('ai_history') ?? [];

      final contextText = history.join('\n');

      final content = [
        Content.text('Context anterior:\n$contextText\n\nÎntrebare: $question'),
      ];

      final response = await _model.generateContent(content);
      final aiText = response.text ?? "Fără răspuns.";

      setState(() {
        aiResponses.add({'role': 'ai', 'text': aiText});
      });

      await _addToHistory(aiText);
    } catch (e) {
      setState(() {
        aiResponses.add(
            {'role': 'ai', 'text': 'Nu am putut obține un răspuns de la AI.'});
      });
    } finally {
      setState(() {
        _isSending = false;
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery
        .of(context)
        .size;

    return MainLayout(
      selectedIndex: 1,
      child: Column(
        children: [
          const SizedBox(height: 10), // redus de la 50

          Expanded(
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 20,
                  child: Image.asset(
                    'assets/questbot.png',
                    width: 120,
                    height: 120,
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 140,
                  right: 10,
                  bottom: 60,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5,
                          offset: Offset(4, 4),
                        ),
                      ],
                    ),
                    child: ListView.builder(
                      itemCount: aiResponses.length,
                      itemBuilder: (context, index) {
                        final item = aiResponses[index];
                        final isUser = item['role'] == 'user';
                        return Align(
                          alignment: isUser
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: isUser
                                  ? Colors.deepPurple[100]
                                  : Colors.grey[200],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              item['text'],
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.only(bottom: 30),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.blue, width: 2),
            ),
            child: Row(
              children: [
                const Icon(Icons.search, color: Colors.blue),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onSubmitted: (value) => _getAIResponse(value),
                    decoration: const InputDecoration(
                      hintText: 'Întrebarea ta...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.blue),
                  onPressed: _isSending
                      ? null
                      : () => _getAIResponse(_controller.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}