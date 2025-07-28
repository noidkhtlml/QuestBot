import 'dart:convert';
import 'package:flutter/services.dart';

Future<Map<String, dynamic>> loadLectiiJson() async {
  final String response = await rootBundle.loadString('assets/lectii.json');
  return jsonDecode(response);
}
