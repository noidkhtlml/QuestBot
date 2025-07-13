import 'package:flutter/material.dart';
import '../utils/route_change.dart';
import '../utils/main_layout.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedSubject = 'MATERII';

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      selectedIndex: 0,
      child: Scaffold(
        backgroundColor: const Color(0xFF33B9FF),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 10), // spațiu jos
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // QUESTBOT label sus
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 10),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF3399),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'QUEST',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        TextSpan(
                          text: 'BOT',
                          style: TextStyle(
                            color: Color(0xFFCCFF66),
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // CARD CENTRAL
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 0, bottom: 10),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.grey.shade300,
                width: 6,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Ce este QuestBot?',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  '  Questbot este o platformă educațională digitală...',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),

                const SizedBox(height: 20),

                // Dropdown
                Container(
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF8C4BFF),
                    borderRadius: BorderRadius.circular(2),
                    border: Border.all(color: const Color(0xFF651FFF), width: 3),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedSubject,
                      icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                      dropdownColor: const Color(0xFF8C4BFF),
                      isExpanded: true,
                      items: <String>[
                        'MATERII',
                        'Matematică',
                        'Fizică',
                        'AI',
                        'Statistici'
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedSubject = newValue!;
                        });

                        final routes = {
                          'Matematică': '/neuro',
                          'AI': '/ai',
                          'Fizică': '/astro',
                          'Statistici': '/statistici',
                        };
                        if (routes.containsKey(newValue)) {
                          routeChangeNamed(context, routes[newValue]!);
                        }
                      },
                    ),
                  ),
                ),

                        const SizedBox(height: 20),

                        // Continuarea descrierii
                        const Text('Scopul principal al aplicației Questbot este de a oferi elevilor pasionați de științele exacte un spațiu accesibil, interactiv și structurat, în care să poată explora domenii moderne din sfera STEM, dincolo de programa școlară standard.',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 30),

                        const Text('Astronomie',
                          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),

                        const Text('Această secțiune a aplicației este dedicată descoperirii fascinantei lumi a astronomiei. Utilizatorii vor învăța concepte fundamentale despre cosmos și despre știința din spatele acestuia. Fiecare modul este construit pentru a stimula curiozitatea și înțelegerea, transformând învățarea într-o aventură captivantă printre stele.Iși vor testa cunoștințele prin testele de la finalul fiecărei lecții.',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),

                        const Text('Electronică',
                          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),

                        const Text('În secțiunea care abordează electronica, utilizatorii învață cum funcționează lumea invizibilă a curentului electric, a componentelor electronice și a circuitelor care stau la baza tuturor dispozitivelor moderne. Lecțiile sunt construite progresiv, combinând teoria cu simulări interactive și proiecte DIY (do-it-yourself), astfel încât oricine să poată înțelege și aplica principiile de bază ale electronicii.',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),

                        const Text('Neuroștiințe',
                          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),

                        const Text('Această secțiune învață elevii cum funcționează cel mai complex sistem biologic cunoscut: creierul uman. Prin lecții interactive, simulări vizuale și activități hands-on, utilizatorii vor descoperi cum funcționează neuronii, cum luăm decizii, cum percepem lumea și ce se întâmplă în creier atunci când învățăm, simțim sau visăm.',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),

                        const Text('Inteligență Artificială',
                          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),

                        const Text('În capitolul care abordează inteligența artificială, elevii descoperă, pas cu pas, cum „gândesc” algoritmii, cum se antrenează rețelele neuronale și cum pot construi propriile aplicații smart. Lecțiile sunt concepute modular, astfel încât să poți parcurge rapid conceptele de bază sau să aprofundezi domenii specializate, totul într‑un mediu interactiv, vizual și—mai ales—practic',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ],
            ),
          ),
          ],
        ),
      ),
    ),
    ),
    );
  }
}
