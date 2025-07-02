import 'package:flutter/material.dart';

class MatematicaPage extends StatelessWidget {
  const MatematicaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          buildNavigationRail(context),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildBannerModul("Astrofizică", "Descoperă misterele Universului", "🌌"),
                  const SizedBox(height: 24),
                  buildCapitol("Scale Drawing", [
                    buildLectie("Understanding scale drawing", Icons.square_foot),
                    buildLectie("Scale drawing examples", Icons.calculate),
                  ]),
                  const SizedBox(height: 24),
                  buildCapitol("Teme generale", [
                    buildLectie("Gravitatie", Icons.downhill_skiing),
                    buildLectie("Planete", Icons.public),
                    buildLectie("Stele", Icons.star),
                    buildLectie("Galaxii", Icons.auto_awesome),
                    buildLectie("Nebuloase", Icons.cloud),
                    buildLectie("Comete", Icons.compost),
                    buildLectie("Astre", Icons.brightness_3),
                    buildLectie("Constelații", Icons.blur_on),
                    buildLectie("Cosmos", Icons.all_inclusive),
                    buildLectie("Astronomie", Icons.wb_twilight),
                    buildLectie("Fizica", Icons.science),
                    buildLectie("Energia", Icons.bolt),
                    buildLectie("Materia", Icons.scatter_plot),
                    buildLectie("Lumi", Icons.public_off),
                  ]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBannerModul(String titlu, String subtitlu, String emoji) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.indigo.shade400,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 48)),
          const SizedBox(height: 8),
          Text(titlu, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 4),
          Text(subtitlu, style: const TextStyle(fontSize: 16, color: Colors.white70)),
        ],
      ),
    );
  }

  Widget buildCapitol(String titlu, List<Widget> lectii) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(titlu, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: lectii,
        ),
      ],
    );
  }

  Widget buildLectie(String titlu, IconData icon) {
    return InkWell(
      onTap: () => debugPrint('Navigare către $titlu'),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          width: 160,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 36, color: Colors.indigo),
              const SizedBox(height: 8),
              Text(
                titlu,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNavigationRail(BuildContext context) {
    return NavigationRail(
      selectedIndex: 2,
      onDestinationSelected: (int index) {
        // Logica de navigare aici
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
