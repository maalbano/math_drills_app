import 'package:mathdrillsapp/components/stats_panel.dart';
import 'package:mathdrillsapp/models/drill_log.dart';
import 'package:mathdrillsapp/models/drill.dart';
import 'package:flutter/material.dart';
import 'package:mathdrillsapp/components/score_row.dart';
import 'package:mathdrillsapp/screens/results_page.dart';
import 'package:theme_provider/theme_provider.dart';

class DrillLogPage extends StatefulWidget {
  @override
  _DrillLogPageState createState() => _DrillLogPageState();
}

class _DrillLogPageState extends State<DrillLogPage> {
  final DrillLog drillLog = DrillLog();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Drill Logs'),
            IconButton(
                icon: Icon(Icons.delete_outline),
                onPressed: () {
                  print('clear data here');

                  setState(() {
                    drillLog.clearDrills();
                  });
                }),
          ],
        ),
      ),
      body: FutureBuilder(
          future: drillLog.drillLog.ready,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return Center(
              child: buildListViewTable(drillLog.getDrillLog()),
            );
          }),
    );
  }

  Widget makeDrillListTile(String k, dynamic v) {
    DateTime t = DateTime.fromMillisecondsSinceEpoch(int.tryParse(k));

    return ListTile(
      trailing: Icon(
        Icons.chevron_right,
        size: 40,
        color: Theme.of(context).buttonColor,
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ThemeConsumer(
                    child:
                        ResultsPage(t: t, completedDrill: Drill.fromMap(v)))));
      },

      tileColor: Theme.of(context).cardColor,
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('${t.day}/${t.month}/${t.year}'),
          Text(v['type'] ?? ''),
        ],
      ),
      //Text(t.toString()),

      title: ScoreRow(
        scoreText: '${v['finalScore']}/10',
        timeText: '${Drill.convertTimeString(v['drillTime'])}',
      ),
      //subtitle: Text(v['type'] ?? ''),
    );
  }

  Widget buildListViewTable(Map<String, dynamic> drillList) {
    List<Widget> rows = [];

    rows.add(
      ListTile(
        title: Text(
          'View Stats',
          textAlign: TextAlign.center,
        ),
        tileColor: Theme.of(context).canvasColor,
        onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                    title: Text(
                      'Stats Page',
                    ),
                    content: StatsPanel(drillLog));
              });
        },
      ),
    );

    drillList?.forEach((k, v) {
      rows.add(makeDrillListTile(k, v));
      rows.add(Divider(
        height: 2,
      ));
    });

    return ListView(children: rows);
  }

  DataRow makeDrillRow(String k, dynamic v) {
    DateTime t = DateTime.fromMillisecondsSinceEpoch(int.tryParse(k));

    return DataRow(
      cells: <DataCell>[
        DataCell(
          Text('${t.day}/${t.month}/${t.year}'),
          //Text(t.toString()),
        ),
        DataCell(Text('${v['finalScore']}/10')),
        DataCell(Text('${Drill.convertTimeString(v['drillTime'])}')),
        DataCell(Text(v['type'] ?? '')),
      ],
    );
  }

  Widget buildDataTable(Map drillList) {
    List<DataRow> rows = [];

    drillList?.forEach((k, v) => rows.add(makeDrillRow(k, v)));

    return ListView(children: [
      DataTable(
        columns: const <DataColumn>[
          DataColumn(
            label: Text(
              'Date',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          DataColumn(
            label: Text(
              'Score',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          DataColumn(
            label: Text(
              'Time',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          DataColumn(
            label: Text(
              'Type',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ],
        rows: rows,
      ),
    ]);
  }
}
