import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../database.dart';

class LocalCapitolStats {
  final String materie;
  final String capitol;
  final int timp;
  final int scor;
  final List<ScoreEntry> scoruri;
  final String elev;
  LocalCapitolStats(this.materie, this.capitol, this.timp, this.scor, this.scoruri, this.elev);
}

class ScoreEntry {
  final DateTime timestamp;
  final int value;
  ScoreEntry(this.timestamp, this.value);
}

class ParinteUiPage extends StatefulWidget {
  const ParinteUiPage({super.key});

  @override
  State<ParinteUiPage> createState() => _ParinteUiPageState();
}

class _ParinteUiPageState extends State<ParinteUiPage> {
  List<LocalCapitolStats> capitolStats = [];

  final List<Color> chartColors = [
    Colors.redAccent,
    Colors.blueAccent,
    Colors.greenAccent,
    Colors.orangeAccent,
  ];

  @override
  void initState() {
    super.initState();
    _fetchStatsFromDb();
  }

  Future<void> _fetchStatsFromDb() async {
    final db = LocalDatabase.instance;
    final progressList = await (await db.database).query('progress');

    Map<String, List<Map<String, dynamic>>> statsGrouped = {};

    for (final row in progressList) {
      final elev = row['userId']?.toString() ?? 'Elev Anonim';
      final materie = row['materie']?.toString() ?? elev;
      final capitol = row['chenarId']?.toString() ?? 'Necunoscut';
      final timp = row['timeSpent'] is int ? row['timeSpent'] as int : 0;
      final scor = row['score'] is int ? row['score'] as int : 0;
      final timestampStr = row['timestamp']?.toString() ?? DateTime.now().toIso8601String();

      final key = '$elev|$materie|$capitol';
      statsGrouped.putIfAbsent(key, () => []);
      statsGrouped[key]!.add({
        'timp': timp,
        'scor': scor,
        'timestamp': timestampStr,
        'elev': elev,
        'materie': materie,
        'capitol': capitol,
      });
    }

    List<LocalCapitolStats> stats = [];
    statsGrouped.forEach((key, entries) {
      final elev = entries.first['elev'] as String;
      final materie = entries.first['materie'] as String;
      final capitol = entries.first['capitol'] as String;

      final totalTimp = entries.fold<int>(0, (sum, e) => sum + (e['timp'] as int));
      final maxScor = entries.fold<int>(0, (max, e) => e['scor'] > max ? e['scor'] as int : max);

      final scoruri = entries.map((e) {
        DateTime ts;
        try {
          ts = DateTime.parse(e['timestamp']);
        } catch (_) {
          ts = DateTime.now();
        }
        return ScoreEntry(ts, e['scor'] as int);
      }).toList();
      scoruri.sort((a, b) => a.timestamp.compareTo(b.timestamp));
      stats.add(LocalCapitolStats(materie, capitol, totalTimp, maxScor, scoruri, elev));
    });

    setState(() {
      capitolStats = stats;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color: Colors.white,
            child: const Text(
              "Statistici Elevi",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: capitolStats.length,
              itemBuilder: (context, index) {
                return ExpandableTileWithGraph(data: capitolStats[index]);
              },
            ),
          )
        ],
      ),
    );
  }
}

class ExpandableTileWithGraph extends StatefulWidget {
  final LocalCapitolStats data;
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
          title: Text('${widget.data.elev} - ${widget.data.materie}'),
          subtitle: Text('${widget.data.capitol}: ${widget.data.timp} min, ${widget.data.scor}%'),
          trailing: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
          onTap: () => setState(() => _expanded = !_expanded),
        ),
        if (_expanded && widget.data.scoruri.isNotEmpty)
          SizedBox(
            height: 200,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
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
          )
      ],
    );
  }
}
