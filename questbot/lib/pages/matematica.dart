import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../models/Lectie.dart'; // asigură-te că fișierul cu LectiePage e corect importat

class MatematicaPage extends StatefulWidget {
  const MatematicaPage({super.key});

  @override
  State<MatematicaPage> createState() => _MatematicaPageState();
}

class _MatematicaPageState extends State<MatematicaPage> {
  Map<String, dynamic> toateLectiile = {};

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  Future<void> loadJsonData() async {
    final String jsonString = await rootBundle.loadString('assets/lectii.json');
    final data = json.decode(jsonString);
    setState(() {
      toateLectiile = Map<String, dynamic>.from(data);
    });
  }

  void onChenarAles(BuildContext context, String id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LectiePage(chenarId: id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Text(
                  'Matematică',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'monospace',
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: GridView.builder(
                  itemCount: 20,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    final id = (index + 1).toString();
                    return GestureDetector(
                      onTap: () => onChenarAles(context, id),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 3)],
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          id,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
