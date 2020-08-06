import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'drill_generator.dart';

class Question {
  String question;
  String answer;
  List<String> choices = [];

  Question(this.question, this.answer);

  @override
  String toString() {
    return '$question = $answer';
  }

  toJSONEncodable() {
    Map<String, dynamic> m = new Map();

    m['q'] = question;
    m['a'] = answer;
    m['choices'] = choices;

    return m;

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

  toJSONEncodable() {
    Map<String, dynamic> m = new Map();

    List l = [];
    for (Question q in questions) l.add(q.toJSONEncodable());
    m['questions'] = l;

    m['answers'] = answers;
    m['finalScore'] = finalScore;
    m['drillTime'] = drillTime;
    m['type'] = type.toString().split('.')[1];
    m['settings'] = settings;

    return m;
  }

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
