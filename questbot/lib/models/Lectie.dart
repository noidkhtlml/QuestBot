import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../utils/main_layout.dart';

class LectiePage extends StatefulWidget {
  final String chenarId;
  const LectiePage({Key? key, required this.chenarId}) : super(key: key);

  @override
  State<LectiePage> createState() => _LectiePageState();
}

class _LectiePageState extends State<LectiePage> {
  Map<String, dynamic> lectii = {};
  Map<String, dynamic> teste = {};
  String? selectedValue;
  String rezultatText = '';
  Color rezultatColor = Colors.black;
  int scor = 0;
  Set<String> completedQuestions = {};

  final List<Color> colorPalette = [
    Color(0xFFF78FB3),
    Color(0xFF63CDDA),
    Color(0xFFF5CD79),
    Color(0xFFCF6A87),
    Color(0xFF786FA6),
    Color(0xFFEA8685),
    Color(0xFF574B90),
    Color(0xFF9AECDB),
    Color(0xFFE77F67),
    Color(0xFFC44569),
  ];

  // Map: index întrebare -> valoarea selectată
  Map<int, String> selectedValues = {};

  // Map: index întrebare -> corectitudine (true/false)
  Map<int, bool> results = {};

  bool testVerificat = false;

  // Exemplu simplu de widget pentru subtitlu cu paragraf (poți adapta)
  Widget buildSubtitluCuParagraf(String subtitlu, List<String> paragrafe, Color culoare) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: culoare.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(subtitlu, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: culoare)),
          const SizedBox(height: 8),
          ...paragrafe.map((p) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(p, style: const TextStyle(fontSize: 16)),
          )),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    String lectiiData = await rootBundle.loadString('assets/lectii.json');
    String testeData = await rootBundle.loadString('assets/teste.json');

    setState(() {
      lectii = json.decode(lectiiData);
      teste = json.decode(testeData);
    });
  }

  void verificaRaspuns() {
    final testData = teste[widget.chenarId];
    if (testData == null) {
      setState(() {
        rezultatText = "⚠️ Nu există întrebare pentru această lecție.";
        rezultatColor = Colors.orange;
      });
      return;
    }

    final raspunsCorect = testData["raspuns_corect"];
    if (raspunsCorect == null) {
      setState(() {
        rezultatText = "⚠️ Nu este definit un răspuns corect.";
        rezultatColor = Colors.orange;
      });
      return;
    }

    if (selectedValue == raspunsCorect) {
      if (!completedQuestions.contains(widget.chenarId)) {
        scor++;
        completedQuestions.add(widget.chenarId);
        rezultatText = "✅ Răspuns corect!";
        rezultatColor = Colors.green;
      } else {
        rezultatText = "✔️ Ai răspuns deja corect.";
        rezultatColor = Colors.blue;
      }
    } else {
      rezultatText = "❌ Răspuns greșit.";
      rezultatColor = Colors.red;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final lectieData = lectii[widget.chenarId];
    final testData = teste[widget.chenarId];

    if (lectieData == null) {
      return Scaffold(
        body: Center(
            child: Text('⚠️ Lecția nu a fost găsită.',
                style: TextStyle(color: Colors.red, fontSize: 20))),
      );
    }

    List<Widget> continutControls = [];

// Titlu cu fundal verde
    continutControls.add(
      Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 24),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color(0xFF2BBBAD),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(
          lectieData['titlul'] ?? '',
          style: const TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );


    // Conținut
    for (var item in lectieData['continut'] ?? []) {
      // DEFINITIE
      for (var definitie in item['definitie'] ?? []) {
        Color culoare = colorPalette[Random().nextInt(colorPalette.length)];
        String subtitlu = definitie['subtitlu'] ?? '';
        List<String> paragrafe = List<String>.from(definitie['paragraf'] ?? []);
        if (subtitlu.isNotEmpty && paragrafe.isNotEmpty) {
          continutControls.add(
              buildSubtitluCuParagraf(subtitlu, paragrafe, culoare));
        }
      }

      // TEORIE
      for (var teorie in item['teorie'] ?? []) {
        Color culoare = colorPalette[Random().nextInt(colorPalette.length)];
        String subtitlu = teorie['subtitlu'] ?? '';
        List<String> paragrafe = List<String>.from(teorie['paragraf'] ?? []);
        if (subtitlu.isNotEmpty && paragrafe.isNotEmpty) {
          continutControls.add(
              buildSubtitluCuParagraf(subtitlu, paragrafe, culoare));
        }
      }

      // TABEL (opțional)
      var tabel = item['tabel'];
      if (tabel != null) {
        continutControls.add(
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 12, bottom: 24),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.blueGrey, width: 1),
            ),
            child: Text("Tabel: $tabel", style: TextStyle(
                fontSize: 16, fontStyle: FontStyle.italic, color: Colors.blue)),
          ),
        );
      }
    }

    List<Widget> testControls = [];

    if (testData != null && testData['intrebari'] != null) {
      List<dynamic> intrebari = testData['intrebari'];

      testControls.addAll([
        const Divider(height: 30),
        Text("Test interactiv:",
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue)),
      ]);

      for (int i = 0; i < intrebari.length; i++) {
        final intrebare = intrebari[i];
        final intrebareText = intrebare['question'] ?? '';
        final optiuni = List<String>.from(intrebare['options'] ?? []);
        final raspunsIndex = intrebare['answer'];
        final explicatie = intrebare['explanation'] ?? '';

        testControls.add(
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              border: Border.all(color: Colors.blueGrey),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Întrebarea ${i + 1}: $intrebareText",
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                ...List.generate(optiuni.length, (j) {
                  String val = "$i-$j";
                  return RadioListTile<String>(
                    title: Text(optiuni[j]),
                    value: val,
                    groupValue: selectedValues[i],
                    onChanged: (val) {
                      if (!testVerificat) {
                        setState(() {
                          selectedValues[i] = val!;
                        });
                      }
                    },
                  );
                }),

                // Feedback după verificare
                if (testVerificat && results.containsKey(i))
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(
                      results[i]! ? "✅ Corect! $explicatie" : "❌ Greșit! $explicatie",
                      style: TextStyle(
                        color: results[i]! ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      }
      testControls.add(
        ElevatedButton(
          onPressed: () {
            int tempScor = 0;
            Map<int, bool> tempResults = {};

            for (int i = 0; i < intrebari.length; i++) {
              final raspunsIndex = intrebari[i]['answer'];
              final selVal = selectedValues[i];
              if (selVal != null) {
                final selectedParts = selVal.split("-");
                if (selectedParts.length == 2 && selectedParts[0] == "$i") {
                  final indexSelectat = int.parse(selectedParts[1]);
                  bool corect = indexSelectat == raspunsIndex;
                  tempResults[i] = corect;
                  if (corect) tempScor++;
                } else {
                  tempResults[i] = false;
                }
              } else {
                tempResults[i] = false;
              }
            }

            setState(() {
              results = tempResults;
              scor = tempScor;
              testVerificat = true;
            });
          },
          child: const Text("Rezolvă testul"),
        ),
      );

      // Afișare scor total
      if (testVerificat) {
        testControls.add(
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text(
              "Scor total: $scor / ${intrebari.length}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        );
      }
    }

    return MainLayout(
      selectedIndex: 6,
      child: Container(
        color: Colors.white,  // fundal alb pentru tot conținutul
        child: SingleChildScrollView(   // ca să poți da scroll dacă e conținut mai mult
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...continutControls,
              ...testControls,
            ],
          ),
        ),
      ),
    );
  }
}
