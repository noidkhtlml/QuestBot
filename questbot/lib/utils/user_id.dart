import 'package:shared_preferences/shared_preferences.dart';

/// Returnează UID-ul utilizatorului stocat local.
/// Dacă nu există, întoarce `null`.
Future<String?> getUserId() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('uid');
}

/// Setează UID-ul utilizatorului în local storage (ex: după login sau înregistrare).
Future<void> setUserId(String uid) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('uid', uid);
}

/// Șterge UID-ul utilizatorului (ex: la logout).
Future<void> clearUserId() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('uid');
}
