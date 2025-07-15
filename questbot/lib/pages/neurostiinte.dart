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
      CapitolBox(id: 28, titlu: "1.Introducere in neurostiinte"),
      CapitolBox(id: 29, titlu: "2.Principii moleculare si celulare ale sistemului nervos"),
      CapitolBox(id: 30, titlu: "3.Neuronii, unitati structural-functionale"),
      CapitolBox(id: 31, titlu: "4.Celulele gliale"),
      CapitolBox(id: 32, titlu: "5.Tesutul nervos"),
      CapitolBox(id: 33, titlu: "6.Organizarea subcelulara si functiile organitelor neuronale"),
      CapitolBox(id: 34, titlu: "7.Electrofiziologie: potențial de repaus și potențial de acțiune"),
      CapitolBox(id: 35, titlu: "8.Organizarea sistemului nervos"),
      CapitolBox(id: 36, titlu: "9.Transmiterea sinaptica"),
      CapitolBox(id: 37, titlu: "10.Lichidul cefalorahidian si microclimatul neuronal"),
      CapitolBox(id: 38, titlu: "11.Fiziologia creierului"),
      CapitolBox(id: 39, titlu: "13.Circuitele neuronale in sistemul nervos central"),
      CapitolBox(id: 40, titlu: "14.Neuroplasticitate si invatare"),
      CapitolBox(id: 41, titlu: "15.Neurodezvoltarea"),
      CapitolBox(id: 42, titlu: "16.Fiziologia sistemului senzorial"),
      CapitolBox(id: 43, titlu: "17.Fiziologia sistemului motor"),
      CapitolBox(id: 44, titlu: "18.Fiziologia creierului in stari patologice"),
      CapitolBox(id: 45, titlu: "19.Fiziologia imbatranirii"),
      CapitolBox(id: 46, titlu: "20.Tipuri de neurotransmitatori si receptori")
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
