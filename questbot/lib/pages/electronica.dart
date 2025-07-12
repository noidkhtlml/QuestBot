import 'package:flutter/material.dart';
import '../utils/main_layout.dart';
import '../utils/chenare.dart';
import '../models/Lectie.dart';

class ElectronicaPage extends StatelessWidget {
  const ElectronicaPage({super.key});

  void onChenarAles(BuildContext context, int id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LectiePage(chenarId: id.toString()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<CapitolBox> capitole = [
      CapitolBox(id: 47, titlu: "Teoria din spatele electricitatii"),
      CapitolBox(id: 48, titlu: "Conductori, semiconductori, insulatori"),
      CapitolBox(id: 49, titlu: "Cum functioneaza electricitatea?"),
      CapitolBox(id: 50, titlu: "Curenti si circuite"),
      CapitolBox(id: 51, titlu: "FUneltele meseriei"),
      CapitolBox(id: 52, titlu: "Comutatoare"),
      CapitolBox(id: 53, titlu: "Rezistoare"),
      CapitolBox(id: 54, titlu: "Condensatorii"),
      CapitolBox(id: 55, titlu: "Diodurile"),
      CapitolBox(id: 56, titlu: "Tranzistorul"),
      CapitolBox(id: 57, titlu: "Surse de putere si alimentare"),
      CapitolBox(id: 58, titlu: "Lipire (Soldering)"),
      CapitolBox(id: 59, titlu: "Teoria digitala"),
      CapitolBox(id: 60, titlu: "Circuite integrate"),
      CapitolBox(id: 61, titlu: "Memoria"),
      CapitolBox(id: 62, titlu: "Microcontrollere"),
      CapitolBox(id: 63, titlu: "Motoare si controllere"),
      CapitolBox(id: 64, titlu: "Senzori"),
      CapitolBox(id: 65, titlu: "Comunicatie electronica"),
      CapitolBox(id: 66, titlu: "Securitate cibernetica si IOT(Internet of Things) pentru proiecte de electronica"),
    ];

    return MainLayout(
      selectedIndex: 5,
      backgroundColor: Colors.white,
      child: Container(
        color: Colors.white,
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildBannerModul("Electronică", "Învață principiile circuitelor și componentelor electronice"),
              const SizedBox(height: 24),
              CapitolBoxList(
                capitole: capitole,
                onTap: (id) => onChenarAles(context, id),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBannerModul(String titlu, String subtitlu) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.teal.shade600,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titlu,
            style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 4),
          Text(
            subtitlu,
            style: const TextStyle(fontSize: 24, color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
