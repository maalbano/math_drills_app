import 'package:mathdrillsapp/models/drill_log.dart';
import 'package:mathdrillsapp/models/drill.dart';
import 'package:flutter/material.dart';
import 'package:mathdrillsapp/components/score_row.dart';

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

  ListTile makeDrillListTile(String k, dynamic v) {
    DateTime t = DateTime.fromMillisecondsSinceEpoch(int.tryParse(k));

    return ListTile(
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

    drillList?.forEach((k, v) => rows.add(makeDrillListTile(k, v)));

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
