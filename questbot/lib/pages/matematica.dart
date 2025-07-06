import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:questbot/utils/main_layout.dart';
import '../models/Lectie.dart';
import '../utils/chenare.dart';

class NeurostiintaPage extends StatefulWidget {
  const NeurostiintaPage({super.key});

  @override
  State<NeurostiintaPage> createState() => _NeurostiintaPageState();
}

class _NeurostiintaPageState extends State<NeurostiintaPage> {
  List<CapitolBox> capitole = [];

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  Future<void> loadJsonData() async {
    final String jsonString = await rootBundle.loadString('assets/lectii.json');
    final Map<String, dynamic> data = json.decode(jsonString);

    List<CapitolBox> incarcate = data.entries.map((entry) {
      final int id = int.tryParse(entry.key) ?? 0;
      final String titlu = entry.value['titlu'] ?? 'Fără titlu';
      return CapitolBox(id: id, titlu: titlu);
    }).toList();

    incarcate.sort((a, b) => a.id.compareTo(b.id));

    setState(() {
      capitole = incarcate;
    });
  }

  void onChenarAles(BuildContext context, int id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LectiePage(chenarId: id.toString()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      selectedIndex: 1,
      child: Row(
        children: [
          Expanded(
            child: capitole.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
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
                      'Neuroștiința',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'monospace',
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  CapitolBoxList(
                    capitole: capitole,
                    onTap: (id) => onChenarAles(context, id),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
