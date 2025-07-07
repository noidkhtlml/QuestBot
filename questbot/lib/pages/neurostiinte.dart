import 'package:flutter/material.dart';
import '../utils/main_layout.dart';
import '../utils/chenare.dart';
import '../models/Lectie.dart';

class NeurostiintaPage extends StatelessWidget {
  const NeurostiintaPage({super.key});

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
      CapitolBox(id: 29, titlu: "Miscarea corpurilor cosmice"),
      CapitolBox(id: 30, titlu: "Constituentii elementari ai materiei"),
      CapitolBox(id: 31, titlu: "Fenomene termodinamice in astronomie si starea materie"),
      CapitolBox(id: 32, titlu: "Undele sonore"),
      CapitolBox(id: 33, titlu: "Undele magnetice"),
      CapitolBox(id: 34, titlu: "Astrofizica stelara"),
      CapitolBox(id: 35, titlu: "Materia dintre stele"),
      CapitolBox(id: 36, titlu: "Cum a luat nastere Sistemul Solar?"),
      CapitolBox(id: 37, titlu: "Formarea stelelor"),
      CapitolBox(id: 38, titlu: "Galaxiile"),
      CapitolBox(id: 39, titlu: "Miscarea corpurilor cosmice"),
      CapitolBox(id: 40, titlu: "Constituentii elementari ai materiei"),
      CapitolBox(id: 41, titlu: "Fenomene termodinamice in astronomie si starea materie"),
      CapitolBox(id: 42, titlu: "Undele sonore"),
      CapitolBox(id: 43, titlu: "Undele magnetice"),
      CapitolBox(id: 44, titlu: "Astrofizica stelara"),
      CapitolBox(id: 45, titlu: "Materia dintre stele"),
      CapitolBox(id: 46, titlu: "Cum a luat nastere Sistemul Solar?"),
    ];

    return MainLayout(
      selectedIndex: 3,
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
              buildBannerModul("Neuroștiință", "Explorăm creierul și mintea umană"),
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
        color: Colors.orange.shade600,
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
