import 'package:flutter/material.dart';
import 'drill.dart';
import 'constants.dart';

class ResultsPage extends StatelessWidget {
  final Drill completedDrill;

  ResultsPage({this.completedDrill});

  @override
  Widget build(BuildContext context) {
    List<Widget> resultsList = [];

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
