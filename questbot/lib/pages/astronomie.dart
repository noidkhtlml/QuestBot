import 'package:flutter/material.dart';
import '../utils/main_layout.dart';
import '../utils/chenare.dart';
import '../models/Lectie.dart';

class AstronomiePage extends StatelessWidget {
  const AstronomiePage({super.key});

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
      CapitolBox(id: 10, titlu: "Introducere in astronomie si astrofizica"),
      CapitolBox(id: 11, titlu: "Introducere in Univers"),
      CapitolBox(id: 12, titlu: "Cosmologia"),
      CapitolBox(id: 13, titlu: "Tehnologii moderne in astronomie"),
      CapitolBox(id: 14, titlu: "Radiatia si lumina"),
      CapitolBox(id: 15, titlu: "Soarele"),
      CapitolBox(id: 16, titlu: "Imprastierea si transferul radiatiei"),
      CapitolBox(id: 17, titlu: "Gravitatia"),
      CapitolBox(id: 18, titlu: "Miscarea corpurilor cosmice"),
      CapitolBox(id: 19, titlu: "Constituentii elementari ai materiei"),
      CapitolBox(id: 20, titlu: "Fenomene termodinamice in astronomie si starea materie"),
      CapitolBox(id: 21, titlu: "Undele sonore"),
      CapitolBox(id: 22, titlu: "Undele magnetice"),
      CapitolBox(id: 23, titlu: "Astrofizica stelara"),
      CapitolBox(id: 24, titlu: "Materia dintre stele"),
      CapitolBox(id: 25, titlu: "Cum a luat nastere Sistemul Solar?"),
      CapitolBox(id: 26, titlu: "Formarea stelelor"),
      CapitolBox(id: 27, titlu: "Galaxiile")
    ];

    return MainLayout(
      selectedIndex: 4,
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
              buildBannerModul("Astrofizică", "Descoperă misterele Universului"),
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
        color: Colors.indigo.shade400,
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
