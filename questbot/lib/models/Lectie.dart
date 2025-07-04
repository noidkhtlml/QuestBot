import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

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
        body: Center(child: Text('⚠️ Lecția nu a fost găsită.', style: TextStyle(color: Colors.red, fontSize: 20))),
      );
    }

    List<Widget> continutControls = [];

    // Titlu
    continutControls.add(Text(
      lectieData['titlul'] ?? '',
      style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black87),
    ));

    // Conținut
    for (var item in lectieData['continut'] ?? []) {
      // Definiții
      for (var definitie in item['definitie'] ?? []) {
        Color culoare = colorPalette[Random().nextInt(colorPalette.length)];
        continutControls.add(Text(
          definitie['subtitlu'] ?? '',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: culoare),
        ));
        for (var paragraf in definitie['paragraf'] ?? []) {
          continutControls.add(Text(paragraf, style: TextStyle(fontSize: 16)));
        }
      }

      // Teorie
      for (var bloc in item['teorie'] ?? []) {
        String subtitlu = bloc['subtitlu'] ?? '';
        if (subtitlu.isNotEmpty) {
          continutControls.add(Text(
            subtitlu,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF4A4E69)),
          ));
        }
        for (var paragraf in bloc['paragraf'] ?? []) {
          continutControls.add(Text(paragraf, style: TextStyle(fontSize: 16)));
        }
      }

      // Formule
      var formule = item['formule'];
      if (formule != null) {
        continutControls.add(Text("🧮 Formule: $formule", style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic)));
      }

      // Tabel
      var tabel = item['tabel'];
      if (tabel != null) {
        continutControls.add(Text("📊 Tabel: $tabel",
            style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.blue)));
      }
    }

    // Test interactiv
    List<Widget> testControls = [];
    if (testData != null) {
      String intrebare = testData['intrebare'] ?? '';
      List<dynamic> variante = testData['variante'] ?? [];

      testControls = [
        Divider(height: 30),
        Text("📝 Test interactiv:", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue[800])),
        Text(intrebare, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ...variante.map((opt) => RadioListTile<String>(
          title: Text(opt),
          value: opt,
          groupValue: selectedValue,
          onChanged: (val) {
            setState(() {
              selectedValue = val;
            });
          },
        )),
        ElevatedButton(onPressed: verificaRaspuns, child: Text("✅ Verifică răspunsul")),
        if (rezultatText.isNotEmpty) Text(rezultatText, style: TextStyle(color: rezultatColor, fontSize: 16)),
        Text("Scor: $scor", style: TextStyle(fontSize: 16)),
      ];
    }

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...continutControls,
            ...testControls,
          ],
        ),
      ),
      backgroundColor: Color(0xFFFDFDFD),
    );
  }
  Widget buildNavigationRail(BuildContext context) {
    return NavigationRail(
      selectedIndex: 3,
      onDestinationSelected: (int index) {
        // Logica de navigare
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
