import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mathdrillsapp/models/drill_log.dart';


class StatsPanel extends StatelessWidget {
  final DrillLog drillLog;

  StatsPanel(this.drillLog);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 200,
      // height: 200,
      child: Column(
         mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CircleAvatar(
            radius: MediaQuery.of(context).size.width/4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AutoSizeText(
                  '${drillLog.computeAccuracy().toStringAsFixed(1)}%',
                  style: Theme.of(context).textTheme.headline3,
                ),
                AutoSizeText(
                  'Accuracy',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
          ),


          CircleAvatar(

            radius: MediaQuery.of(context).size.width/4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AutoSizeText(
                  '${drillLog.computeAveSpeed().toStringAsFixed(1)} s',
                  style: Theme.of(context).textTheme.headline3,
                ),
                AutoSizeText(
                  'Speed',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
          ),

          // CircularProgressIndicator(),
          // Text('Consistency',style: Theme.of(context).textTheme.headline5,),
        ],
      ),
    );
  }
}
