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
      CapitolBox(id: 28, titlu: "Introducere in neurostiinte"),
      CapitolBox(id: 29, titlu: "Principii moleculare si celulare ale sistemului nervos"),
      CapitolBox(id: 30, titlu: "Neuronii, unitati structural-functionale"),
      CapitolBox(id: 31, titlu: "Celulele gliale"),
      CapitolBox(id: 32, titlu: "Tesutul nervos"),
      CapitolBox(id: 33, titlu: "Organizarea subcelulara si functiile organitelor neuronale"),
      CapitolBox(id: 34, titlu: "Electrofiziologie: potențial de repaus și potențial de acțiune"),
      CapitolBox(id: 35, titlu: "Organizarea sistemului nervos"),
      CapitolBox(id: 36, titlu: "Transmiterea sinaptica"),
      CapitolBox(id: 37, titlu: "Lichidul cefalorahidian si microclimatul neuronal"),
      CapitolBox(id: 38, titlu: "Fiziologia creierului"),
      CapitolBox(id: 39, titlu: "Circuitele neuronale in sistemul nervos central"),
      CapitolBox(id: 40, titlu: "Neuroplasticitate si invatare"),
      CapitolBox(id: 41, titlu: "Neurodezvoltarea"),
      CapitolBox(id: 42, titlu: "Fiziologia sistemului senzorial"),
      CapitolBox(id: 43, titlu: "Fiziologia sistemului motor"),
      CapitolBox(id: 44, titlu: "Fiziologia creierului in stari patologice"),
      CapitolBox(id: 45, titlu: "Fiziologia imbatranirii"),
      CapitolBox(id: 46, titlu: "Tipuri de neurotransmitatori si receptori")
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
              buildBannerModul("Neuroștiință", "Explorăm creierul și mintea umană", "bla bla descriere"),
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

  Widget buildBannerModul(String titlu, String subtitlu, String descriere) {
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
          Text(
            descriere,
            style: const TextStyle(fontSize: 18, color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
