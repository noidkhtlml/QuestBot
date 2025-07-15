import 'package:flutter/material.dart';
import '../utils/main_layout.dart';
import '../utils/chenare.dart';
import '../models/Lectie.dart';

class AiPage extends StatelessWidget {
  const AiPage({super.key});

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
      CapitolBox(id: 1, titlu: "1.Sintaxa de baza Python"),
      CapitolBox(id: 2, titlu: "2.Clase si obiecte"),
      CapitolBox(id: 3, titlu: "3.Lucrul cu date"),
      CapitolBox(id: 4, titlu: "4.Introducere in Machine Learning"),
      CapitolBox(id: 5, titlu: "5.Regresia liniara"),
      CapitolBox(id: 6, titlu: "6.Arbori de decizie si Paduri aleatorii"),
      CapitolBox(id: 7, titlu: "7.Deeplearning cu TensorFlow/Keras"),
      CapitolBox(id: 8, titlu: "8.Computer Vision")
    ];

    return MainLayout(
      selectedIndex: 6,
      backgroundColor: Colors.white, // dacă MainLayout suportă asta
      child: Container(
        color: Colors.white, // fundal complet alb
        width: double.infinity,
        height: MediaQuery.of(context).size.height, // forțează înălțimea minimă
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildBannerModul("Inteligență Artificială", "Explorează bazele AI și aplicațiile sale"),
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
        color: Colors.lightBlueAccent,
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
