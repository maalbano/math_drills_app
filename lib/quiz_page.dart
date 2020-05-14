import 'package:flutter/material.dart';
import 'package:mathdrillsapp/results_page.dart';
import 'drill_generator.dart';
import 'drill.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'choice_button.dart';
import 'constants.dart';
import 'results_page.dart';
import 'package:theme_provider/theme_provider.dart';

class QuizPage extends StatefulWidget {
  final Drill drill;

  QuizPage({this.drill});

  @override
  _QuizPageState createState() => _QuizPageState(drill: drill);
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];

  //Drill drill = DrillGenerator.getDrill();
  Drill drill;
  int currentQuestion = 0;

  _QuizPageState({this.drill});

  void restartWithDrill({Drill newDrill}) {
    this.drill = newDrill;
    scoreKeeper = [];
    currentQuestion = 0;
  }

  void checkAnswer(String answer) {
    setState(() {
      Alert wrongAnswerAlert;
      Alert quizCompletedAlert;

      drill.appendAnswer(answer);

      if (answer == drill.questions[currentQuestion].answer) {
        drill.finalScore++;
        scoreKeeper.add(kRightAnswerIcon);
      } else {
        String correctAnswer = drill.questions[currentQuestion].toString();
        String wrongAnswer =
            drill.questions[currentQuestion].question + ' is not ' + answer;
        wrongAnswerAlert = Alert(
          context: context,
          title: 'Whoops!',
          desc: wrongAnswer,
          buttons: [
            DialogButton(
              child: Text(
                correctAnswer,
                style: kIncorrectAnswerTextStyle,
              ),
              onPressed: () => Navigator.pop(context),
              //width: 150,
            )
          ],
        );
        scoreKeeper.add(kWrongAnswerIcon);
      }

      currentQuestion++;
      if (currentQuestion >= drill.questions.length) {
        var score = drill.finalScore;
        var total = drill.questions.length;

        currentQuestion = drill.questions.length - 1;

        quizCompletedAlert = Alert(
          closeFunction: () {
            setState(() {
              restartWithDrill(newDrill: drill.getNewDrill());
            });
          },
          context: context,
          title: 'Congratulations!',
          desc:
              "You've Completed the Quiz with a final score of $score / $total! \nShow your parents!",
          buttons: [
            DialogButton(
              child: Text(
                "Restart Quiz",
                style: kDialogButtonTextStyle,
              ),
              onPressed: () {
                setState(() {
                  restartWithDrill(newDrill: drill.getNewDrill());
                });

                Navigator.pop(context);
              },
              //width: 150,
            ),
            DialogButton(
              child: Text(
                "Review",
                style: kDialogButtonTextStyle,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ThemeConsumer(
                      child: ResultsPage(
                        completedDrill: drill,
                      ),
                    ),
                  ),
                );
              },
              //width: 150,
            )
          ],
        );

        //restartWithDrill(newDrill: drill.getNewDrill());
      }

      if (quizCompletedAlert != null) quizCompletedAlert.show();
      if (wrongAnswerAlert != null) wrongAnswerAlert.show();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Math Drills'),
      ),
      drawer: Drawer(
        child: Container(
          color: Theme.of(context)
              .scaffoldBackgroundColor, //kDrawerBackgroundColor,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Divider(
                color: Theme.of(context).dividerColor, //kDrawerDividerColor,
              ),
              ListTile(
                onTap: () {
                  setState(() {
                    restartWithDrill(
                        newDrill: DrillGenerator.getAdditionDrill());
                    Navigator.pop(context);
                  });
                },
                leading: Icon(
                  Icons.add,
                  size: kDrawerIconSize,
                  color: Theme.of(context).primaryColor,
                ),
                title: Text('Addition Drill',
                    style: Theme.of(context).textTheme.headline6),
              ),
              Divider(
                color: kDrawerDividerColor,
              ),
              ListTile(
                onTap: () {
                  setState(() {
                    restartWithDrill(
                        newDrill: DrillGenerator.getSubtractionDrill());
                    Navigator.pop(context);
                  });
                },
                leading: Icon(
                  Icons.remove,
                  size: kDrawerIconSize,
                  color: Theme.of(context).primaryColor,
                ),
                title: Text('Subtraction Drill',
                    style: Theme.of(context).textTheme.headline6),
              ),
              Divider(
                color: kDrawerDividerColor,
              ),
              ListTile(
                onTap: () {
                  setState(() {
                    restartWithDrill(
                        newDrill: DrillGenerator.getMultiplicationDrill());
                    Navigator.pop(context);
                  });
                },
                leading: Icon(
                  Icons.close,
                  size: kDrawerIconSize,
                  color: Theme.of(context).primaryColor,
                ),
                title: Text('Multiplication Drill',
                    style: Theme.of(context).textTheme.headline6),
              ),
              Divider(
                color: kDrawerDividerColor,
              ),
              ListTile(
                onTap: () {
                  setState(() {
                    restartWithDrill(
                        newDrill: DrillGenerator.getDivisionDrill());
                    Navigator.pop(context);
                  });
                },
                leading: Icon(
                  Icons.view_module,
                  size: kDrawerIconSize,
                  color: Theme.of(context).primaryColor,
                ),
                title: Text(
                  'Division Drill',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Divider(
                color: kDrawerDividerColor,
              ),
              ListTile(
                onTap: () {
                  Alert contactMeAlert = Alert(
                    context: context,
                    title: 'I\'m working on it!',
                    desc:
                        "If you have any suggestions, please email me at mike@mikealbano.org.",
                    buttons: [
                      DialogButton(
                        child: Text(
                          'Thanks',
                          //style: kIncorrectAnswerTextStyle,
                        ),
                        onPressed: () => Navigator.pop(context),
                      )
                    ],
                  );
                  contactMeAlert.show();
                },
                leading: Icon(
                  Icons.border_outer,
                  size: kDrawerIconSize,
                  color: Theme.of(context).primaryColor,
                ),
                title: Text('Custom Drill (Soon)',
                    style: Theme.of(context).textTheme.headline6),
              ),
              Divider(
                color: kDrawerDividerColor,
              ),
              ListTile(
                onTap: () {
                  print('Settings');

                  showDialog(
                      context: context,
                      builder: (context) =>
                          ThemeConsumer(child: ThemeDialog()));
                },
                leading: Icon(
                  Icons.settings,
                  size: kDrawerIconSize,
                  color: Theme.of(context)
                      .primaryColor, //Theme.of(context).primaryColor,
                ),
                title: Text(
                  'Choose Theme',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Theme.of(context)
                    .primaryColor
                    .withAlpha(50), //kQuizPageTransparentBackgroundColor,
              ),
              margin: EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  drill.questions[currentQuestion].question,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline2, //  kQuizPageQuestionTextStyle,
                ),
              ),
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ChoiceButton(
                    choice: drill.questions[currentQuestion].choices[0],
                    onPressed: () {
                      checkAnswer(drill.questions[currentQuestion].choices[0]);
                    }),
                ChoiceButton(
                    choice: drill.questions[currentQuestion].choices[1],
                    onPressed: () {
                      checkAnswer(drill.questions[currentQuestion].choices[1]);
                    })
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ChoiceButton(
                  choice: drill.questions[currentQuestion].choices[2],
                  onPressed: () {
                    checkAnswer(drill.questions[currentQuestion].choices[2]);
                  },
                ),
                ChoiceButton(
                    choice: drill.questions[currentQuestion].choices[3],
                    onPressed: () {
                      checkAnswer(drill.questions[currentQuestion].choices[3]);
                    }),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: scoreKeeper,
          ),
        ],
      ),
    );
  }
}