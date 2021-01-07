import 'package:flutter/material.dart';
import '../models/drill.dart';
import '../constants.dart';
import 'package:mathdrillsapp/components/score_row.dart';

class QuestionDisplayTile extends StatelessWidget {
  String question;
  String answer;
  bool correct;
  String correctAns;

  QuestionDisplayTile(
      this.question, this.answer, this.correct, this.correctAns);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: correct ? kRightAnswerIcon : kWrongAnswerIcon,
      title: Text(
        '$question = $answer',
        style: correct
            ? Theme.of(context).textTheme.headline6 //kDrawerTextStyle
            : Theme.of(context).textTheme.headline6.copyWith(color: Colors.red),
      ),
      trailing: correct
          ? null
          : Text(
              '$question = $correctAns',
              style: kDrawerTextStyle.copyWith(color: Colors.green),
            ),
    );
  }
}

class QuestionDisplaySquare extends StatelessWidget {
  String question;
  String answer;
  bool correct;
  String correctAns;

  QuestionDisplaySquare(
      this.question, this.answer, this.correct, this.correctAns);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context)
              .primaryColor
              .withAlpha(50), //kQuizPageTransparentBackgroundColor,
        ),
        margin: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              child: Center(
                child: Text(
                  '$question = $correctAns',
                  style: Theme.of(context)
                      .textTheme
                      .headline2
                      .copyWith(color: Colors.white) //kDrawerTextStyle
                  ,
                ),
              ),
            ),
            correct
                ? Text('You got it correct!',
                style: kDrawerTextStyle.copyWith(color: Colors.green))
                : Text(
              ' you answered $answer',
              style: kDrawerTextStyle.copyWith(color: Colors.red),
            )
          ],
        ));
  }
}

class ResultsPage extends StatelessWidget {
  final Drill completedDrill;
  final DateTime t;

  ResultsPage({@required this.completedDrill, this.t});

  Widget generateResultsList(BuildContext context) {
    List<Widget> resultsList = [];

    for (int i = 0; i < completedDrill.questions.length; i++) {
      var q = completedDrill.questions[i];
      var qString = q.question;
      var correctAns = q.answer;

      var a = completedDrill.answers[i];
      var correct = (a == correctAns);
      //

      resultsList.add(QuestionDisplayTile(qString, a, correct, correctAns));

      resultsList.add(Divider(
        color: Colors.grey,
        height: 2,
      ));
    }

    return ListView(children: resultsList);
  }

  Widget generateResultsGrid(BuildContext context) {
    List<Widget> resultsList = [];

    for (int i = 0; i < completedDrill.questions.length; i++) {
      var q = completedDrill.questions[i];
      var qString = q.question;
      var correctAns = q.answer;

      var a = completedDrill.answers[i];
      var correct = (a == correctAns);
      //

      resultsList.add(QuestionDisplaySquare(qString, a, correct, correctAns));

      resultsList.add(Divider(
        color: Colors.grey,
        height: 2,
      ));
    }

    return ListView(
      children: resultsList,
    );
  }

  @override
  Widget build(BuildContext context) {
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
                // padding: EdgeInsets.all(8),
                color: Theme.of(context).canvasColor,

                child: Hero(
                  tag: 'drillrow',
                  child: ListTile(
                    leading: t != null ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${t.day}/${t.month}/${t.year}'),
                        Text(completedDrill.type.toString().split('.')[1] ?? ''),
                      ],
                    ) : null,
                    title: ScoreRow(
                      scoreText:
                          '${completedDrill.finalScore}/${completedDrill.answers.length}',
                      timeText: '${completedDrill.drillTimeString()}',
                    ),
                  ),
                ),
              ),
            ),
            Expanded(child: generateResultsGrid(context)),
          ],
        ),
      ),
    );
  }
}
