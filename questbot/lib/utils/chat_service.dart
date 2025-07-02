import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatService {
  static const _apiKey = 'AIzaSyBOJFkhhQrQG8x6s6AIzqTDa8uncVEwNmU'; // Înlocuiește cu cheia ta
  static const _model = 'models/gemini-1.5-flash';
  static const _url = 'https://generativelanguage.googleapis.com/v1beta/$_model:generateContent?key=$_apiKey';

  static List<Map<String, String>> chatMemory = [];

  static Future<String> getResponse(String prompt) async {
    final messages = [
      {'role': 'user', 'parts': '[conversatia anterioara dintre noi]: ${chatMemory.toString()}, intrebare: $prompt'}
    ];

    final body = jsonEncode({
      'contents': messages,
    });

    try {
      final response = await http.post(
        Uri.parse(_url),
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final text = data['candidates']?[0]?['content']?['parts']?[0]?['text'];
        if (text != null) {
          chatMemory.add({'Q': prompt, 'A': text});
          return text;
        }
      }
      return "Nu am putut obține un răspuns de la AI.";
    } catch (e) {
      return "Eroare: $e";
    }
  }
}
