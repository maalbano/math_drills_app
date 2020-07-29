import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mathdrillsapp/drill_generator.dart';

class Question {
  String question;
  String answer;
  List<String> choices = [];

  Question(this.question, this.answer);

  @override
  String toString() {
    return '$question = $answer';
  }
}

enum DrillType {
  addition,
  subtraction,
  multiplication,
  division,
  custom,
}

class Drill {
  //A set of questions
  //Records the answers, and the final score.

  static String convertTimeString(int time) {
    String mins = '${time ~/ 60}';
    String secs =
    time % 60 < 10 ? '0${time % 60}' : '${time % 60}';

    return '$mins:$secs';
  }

  List<Question> questions;
  List<String> answers = [];
  int finalScore = 0;
  int drillTime;
  DrillType type;
  DrillSettings settings;

  Drill({@required this.questions, @required this.type, this.settings});

  Drill getNewDrill() {
    return DrillGenerator.getDrillWith(type: type, settings: settings);
  }

  void appendAnswer(String ans) {
    answers.add(ans);
    print(answers);
  }

  String drillTimeString() {
    return convertTimeString(drillTime);
  }
}
