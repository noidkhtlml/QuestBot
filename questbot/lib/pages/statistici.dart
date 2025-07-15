import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../utils/main_layout.dart';

class StatisticiPage extends StatefulWidget {
  const StatisticiPage({super.key});

  @override
  State<StatisticiPage> createState() => _StatisticiPageState();
}

class _StatisticiPageState extends State<StatisticiPage> {
  final List<_TimpData> timpData = [
    _TimpData('Neuroștiințe', 35),
    _TimpData('Astronomie', 20),
    _TimpData('Electronică', 15),
    _TimpData('AI', 25),
  ];

  final List<_TestData> testData = [
    _TestData('Transmiterea sinaptica', 70),
    _TestData('Cosmologia', 85),
    _TestData('Microcontrollere', 40),
    _TestData('Sintaxa de baza python', 90),
  ];

  final List<_CapitolStats> capitolStats = [
    _CapitolStats('Neuroștiințe', 'Transmiterea sinaptica', 15, 70),
    _CapitolStats('Astronomie', 'Cosmologia', 10, 85),
    _CapitolStats('Electronică', 'Microcontrollere', 5, 40),
    _CapitolStats('AI', 'Sintaxa de baza python', 20, 90),
  ];

  final borderColor = const Color(0xFFADCFFF);
  final backgroundColor = const Color(0xFFFAFAFC);
  final headerColor = const Color(0xFFFF98A2);
  final List<Color> chartColors = [
    Colors.redAccent,
    Colors.blueAccent,
    Colors.greenAccent,
    Colors.orangeAccent,
  ];

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      selectedIndex: 2,
      backgroundColor: Colors.white,
      child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: headerColor,
              child: const Text(
                "Statistici",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: _buildPieChartStyled()),
                        const SizedBox(width: 10),
                        Expanded(child: _buildBarChartStyled()),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildChapterStatsStyled(),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
  }

  Widget _buildPieChartStyled() {
    final total = timpData.fold(0, (sum, item) => sum + item.timp);

    return Container(
      height: 220,
      padding: const EdgeInsets.all(12),
      decoration: _roundedBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Timp pe Materie',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: PieChart(
              PieChartData(
                sectionsSpace: 2,
                centerSpaceRadius: 30,
                sections: timpData.asMap().entries.map((entry) {
                  final index = entry.key;
                  final data = entry.value;
                  final percentage = (data.timp / total * 100).toStringAsFixed(0);
                  return PieChartSectionData(
                    value: data.timp.toDouble(),
                    color: chartColors[index % chartColors.length],
                    title: '$percentage%',
                    radius: 50,
                    titleStyle: const TextStyle(color: Colors.white, fontSize: 12),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBarChartStyled() {
    return Container(
      height: 220,
      padding: const EdgeInsets.all(12),
      decoration: _roundedBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Scor pe Capitole',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: BarChart(
              BarChartData(
                maxY: 100,
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: true, reservedSize: 28),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        if (index >= 0 && index < testData.length) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              testData[index].capitol,
                              style: const TextStyle(fontSize: 10),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                ),
                barGroups: testData.asMap().entries.map((entry) {
                  final index = entry.key;
                  final data = entry.value;
                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: data.scor.toDouble(),
                        color: Colors.cyanAccent,
                        width: 20,
                        borderRadius: BorderRadius.circular(6),
                      )
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChapterStatsStyled() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _roundedBoxDecoration(),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: capitolStats.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final item = capitolStats[index];
          return ListTile(
            leading: const Icon(Icons.bar_chart, color: Colors.pinkAccent),
            title: Text('${item.materie} - ${item.capitol}'),
            subtitle: Text('Timp: ${item.timp} min, Scor: ${item.scor}%'),
          );
        },
      ),
    );
  }

  BoxDecoration _roundedBoxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      border: Border.all(color: borderColor, width: 3),
      borderRadius: BorderRadius.circular(24),
    );
  }
}

class _TimpData {
  final String materie;
  final int timp;
  _TimpData(this.materie, this.timp);
}

class _TestData {
  final String capitol;
  final int scor;
  _TestData(this.capitol, this.scor);
}

class _CapitolStats {
  final String materie;
  final String capitol;
  final int timp;
  final int scor;
  _CapitolStats(this.materie, this.capitol, this.timp, this.scor);
}
