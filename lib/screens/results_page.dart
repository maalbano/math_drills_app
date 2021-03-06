import 'package:flutter/material.dart';
import '../models/drill.dart';
import '../constants.dart';
import 'package:mathdrillsapp/components/score_row.dart';

class ResultsPage extends StatelessWidget {
  final Drill completedDrill;

  ResultsPage({this.completedDrill});

  @override
  Widget build(BuildContext context) {
    List<Widget> resultsList = [];

//    resultsList.add(ListTile(
//      tileColor: Theme.of(context).buttonColor,
//      title: Icon(Icons.timelapse),
//      leading: Text(
//        'Score: ${completedDrill.finalScore}/${completedDrill.answers.length}',
//        style: Theme.of(context).textTheme.headline6,
//      ),
//      trailing: Text(
//        ' Time: ${completedDrill.drillTimeString()}',
//        style: Theme.of(context).textTheme.headline6,
//      ),
//    ));

    for (int i = 0; i < completedDrill.questions.length; i++) {
      var q = completedDrill.questions[i];
      var qString = q.question;
      var correctAns = q.answer;

      var a = completedDrill.answers[i];
      var correct = (a == correctAns);
      //

      resultsList.add(ListTile(
        leading: correct ? kRightAnswerIcon : kWrongAnswerIcon,
        title: Text(
          '$qString = $a',
          style: correct
              ? Theme.of(context).textTheme.headline6 //kDrawerTextStyle
              : Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: Colors.red),
        ),
        trailing: correct
            ? null
            : Text(
                q.toString(),
                style: kDrawerTextStyle.copyWith(color: Colors.green),
              ),
      ));
      resultsList.add(Divider(
        //color: Colors.grey,
        height: 2,
      ));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Results'),
      ),
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          children: <Widget>[
            Center(
              child: Container(
                padding: EdgeInsets.all(8),
                color: Theme.of(context).buttonColor,
                child: ScoreRow(scoreText: '${completedDrill.finalScore}/${completedDrill.answers.length}', timeText: '${completedDrill.drillTimeString()}',),
              ),
            ),
            Expanded(
              child: ListView(
                children: resultsList,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
