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
          child: Column(
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
              Expanded(
                child: Center(
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
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
                          'Ce face questbot',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Dropdown "MATERII"
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
                              items: <String>['MATERII', 'Matematică', 'Fizică', 'AI', 'Statistici']
                                  .map((String value) {
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

                                // Navigare bazată pe selecție
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

                        // yappa
                        const Text('yappa', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const Text('yappa', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const Text('yappa', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),

                        const SizedBox(height: 30),

                        const Text(
                          'Ce face',
                          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                        ),

                        const SizedBox(height: 16),
                        const Text('mai mult yappa',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const Text('yappa', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
