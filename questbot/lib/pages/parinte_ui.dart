import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;

import '../utils/main_layout.dart';

class ParinteUiPage extends StatefulWidget {
  const ParinteUiPage({super.key});

  @override
  State<ParinteUiPage> createState() => _ParinteUiPageState();
}

class _ParinteUiPageState extends State<ParinteUiPage> {
  final borderColor = const Color(0xFFADCFFF);
  final headerColor = const Color(0xFFFF98A2);
  final List<Color> chartColors = [
    Colors.redAccent,
    Colors.blueAccent,
    Colors.greenAccent,
    Colors.orangeAccent,
  ];

  List<_TimpData> timpData = [];
  List<_TestData> testData = [];
  List<_CapitolStats> capitolStats = [];

  final String projectId = 'questbot-database';
  final String collection = 'statistici';
  final String document = 'user_id_exemplu';

  @override
  void initState() {
    super.initState();
    _fetchStats();
  }

  Future<void> _fetchStats() async {
    final url =
        'https://firestore.googleapis.com/v1/projects/$projectId/databases/(default)/documents/$collection/$document';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final fields = data['fields'];

      final Map<String, dynamic> statistici =
      fields.map((k, v) => MapEntry(k, v['mapValue']['fields']));

      List<_TimpData> timpList = [];
      List<_TestData> testList = [];
      List<_CapitolStats> capitolList = [];

      statistici.forEach((materie, detalii) {
        final timp = int.parse(detalii['timp']['integerValue']);
        final scor = int.parse(detalii['scor']['integerValue']);
        final capitol = detalii['capitol']['stringValue'];

        final scoruriList =
            (detalii['scoruri']?['arrayValue']?['values'] as List?) ?? [];

        List<_ScoreEntry> scoruri = scoruriList.map((entry) {
          final map = entry['mapValue']['fields'];
          final dateStr = map['timestamp']['stringValue'];
          final score = int.parse(map['value']['integerValue']);
          return _ScoreEntry(DateTime.parse(dateStr), score);
        }).toList();

        timpList.add(_TimpData(materie, timp));
        testList.add(_TestData(capitol, scor));
        capitolList.add(_CapitolStats(materie, capitol, timp, scor, scoruri));
      });

      setState(() {
        timpData = timpList;
        testData = testList;
        capitolStats = capitolList;
      });
    } else {
      debugPrint("Eroare la fetch: ${response.body}");
    }
  }

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
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
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
          const Text('Timp pe Materie', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Expanded(
            child: PieChart(
              PieChartData(
                sectionsSpace: 2,
                centerSpaceRadius: 30,
                sections: timpData.asMap().entries.map((entry) {
                  final index = entry.key;
                  final data = entry.value;
                  final percentage = total > 0 ? (data.timp / total * 100).toStringAsFixed(0) : '0';
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
          const Text('Scor pe Capitole', style: TextStyle(fontWeight: FontWeight.bold)),
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
          return ExpandableTileWithGraph(data: capitolStats[index]);
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
  final List<_ScoreEntry> scoruri;
  _CapitolStats(this.materie, this.capitol, this.timp, this.scor, this.scoruri);
}

class _ScoreEntry {
  final DateTime timestamp;
  final int value;
  _ScoreEntry(this.timestamp, this.value);
}

class ExpandableTileWithGraph extends StatefulWidget {
  final _CapitolStats data;
  const ExpandableTileWithGraph({required this.data, super.key});

  @override
  State<ExpandableTileWithGraph> createState() => _ExpandableTileWithGraphState();
}

class _ExpandableTileWithGraphState extends State<ExpandableTileWithGraph> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.bar_chart, color: Colors.pinkAccent),
          title: Text('${widget.data.materie} - ${widget.data.capitol}'),
          subtitle: Text('Timp: ${widget.data.timp} min, Scor: ${widget.data.scor}%'),
          trailing: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
          onTap: () => setState(() => _expanded = !_expanded),
        ),
        if (_expanded && widget.data.scoruri.isNotEmpty)
          Container(
            height: 200,
            padding: const EdgeInsets.all(12),
            child: LineChart(
              LineChartData(
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, _) {
                        final index = value.toInt();
                        if (index >= 0 && index < widget.data.scoruri.length) {
                          final date = widget.data.scoruri[index].timestamp;
                          return Text('${date.day}/${date.month}');
                        }
                        return const Text('');
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: true),
                  ),
                ),
                minY: 0,
                maxY: 100,
                lineBarsData: [
                  LineChartBarData(
                    spots: widget.data.scoruri.asMap().entries.map((e) {
                      return FlSpot(e.key.toDouble(), e.value.value.toDouble());
                    }).toList(),
                    isCurved: true,
                    barWidth: 3,
                    color: Colors.blue,
                    dotData: FlDotData(show: true),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
