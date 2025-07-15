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
      CapitolBox(id: 10, titlu: "1.Introducere in astronomie si astrofizica"),
      CapitolBox(id: 11, titlu: "2.Introducere in Univers"),
      CapitolBox(id: 12, titlu: "3.Cosmologia"),
      CapitolBox(id: 13, titlu: "4.Tehnologii moderne in astronomie"),
      CapitolBox(id: 14, titlu: "5.Radiatia si lumina"),
      CapitolBox(id: 15, titlu: "6.Soarele"),
      CapitolBox(id: 16, titlu: "7.Imprastierea si transferul radiatiei"),
      CapitolBox(id: 17, titlu: "8.Gravitatia"),
      CapitolBox(id: 18, titlu: "9.Miscarea corpurilor cosmice"),
      CapitolBox(id: 19, titlu: "10.Constituentii elementari ai materiei"),
      CapitolBox(id: 20, titlu: "11.Fenomene termodinamice in astronomie si starea materie"),
      CapitolBox(id: 21, titlu: "12.Undele sonore"),
      CapitolBox(id: 22, titlu: "13.Undele magnetice"),
      CapitolBox(id: 23, titlu: "14.Astrofizica stelara"),
      CapitolBox(id: 24, titlu: "15.Materia dintre stele"),
      CapitolBox(id: 25, titlu: "16.Cum a luat nastere Sistemul Solar?"),
      CapitolBox(id: 26, titlu: "17.Formarea stelelor"),
      CapitolBox(id: 27, titlu: "18.Galaxiile")
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
