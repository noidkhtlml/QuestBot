import 'package:flutter/material.dart';
import '../utils/chat_service.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];

  bool _loading = false;

  void _sendMessage() async {
    final question = _controller.text.trim();
    if (question.isEmpty) return;

    setState(() {
      _messages.add({'role': 'user', 'text': question});
      _controller.clear();
      _loading = true;
    });

    final answer = await ChatService.getResponse(question);

    setState(() {
      _messages.add({'role': 'ai', 'text': answer});
      _loading = false;
    });
  }

  Widget _buildMessage(Map<String, String> msg) {
    final isUser = msg['role'] == 'user';
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isUser ? Colors.lightBlue[100] : Colors.purple[100],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isUser ? Colors.blue : Colors.purple),
        ),
        child: Text(msg['text'] ?? ""),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("💬 Chat AI Educațional")),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(8),
              children: _messages.map(_buildMessage).toList(),
            ),
          ),
          if (_loading) const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircularProgressIndicator(),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: "Scrie întrebarea ta...",
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget buildNavigationRail(BuildContext context) {
    return NavigationRail(
      selectedIndex: 2,
      onDestinationSelected: (int index) {
        // Logica de navigare aici
      },
      labelType: NavigationRailLabelType.all,
      destinations: const [
        NavigationRailDestination(
          icon: Icon(Icons.home),
          label: Text('Acasă'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.chat),
          label: Text('Chat AI'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.bar_chart),
          label: Text('Statistici'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.calculate),
          label: Text('Matematică'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.public),
          label: Text('Astronomie'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.memory),
          label: Text('Electronică'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.info),
          label: Text('Istoric'),
        ),
      ],
    );
  }
}
