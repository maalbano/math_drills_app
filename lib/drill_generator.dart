import 'dart:math';
import 'package:flutter/material.dart';

import 'drill.dart';


class DrillSettings {
  bool addition;
  bool subtraction;
  bool multiplication;
  RangeValues firstOperandRange;
  RangeValues secondOperandRange;

  DrillSettings(
      {this.addition,
      this.subtraction,
      this.multiplication,
      this.firstOperandRange,
      this.secondOperandRange});
}

class DrillGenerator {
  //A Random Drill Generator

  static Question newQuestionAddition(
      {RangeValues r1 = const RangeValues(2, 20),
      RangeValues r2 = const RangeValues(2, 10)}) {
    // Addition problem
    // first operand min 2, max 21
    int a = r1.start.toInt() +
        Random().nextInt(1 + r1.end.toInt() - r1.start.toInt());
    int b = r2.start.toInt() +
        Random().nextInt(1 + r2.end.toInt() - r2.start.toInt());
    int ans = a + b;

    var q = Question('$a + $b', '$ans');

    int pos = Random().nextInt(4);

    // Wrong choices, = ans + or - 8.
    for (int i = 0; i < 4; i++) {
      if (i == pos)
        q.choices.add('$ans');
      else {
        int swing = max(r1.end.toInt(), r2.end.toInt()) - 1;

        var wrongAns = ans + Random().nextInt(swing * 2) - swing;
        while (wrongAns == ans) {
          wrongAns = ans + Random().nextInt(swing * 2) - swing;
        }
        q.choices.add('$wrongAns');
      }
    }
    return q;
  }

  static Question newQuestionSubtraction(
      {RangeValues r1 = const RangeValues(2, 20),
      RangeValues r2 = const RangeValues(2, 10)}) {
    int ans = r1.start.toInt() +
        Random().nextInt(1 + r1.end.toInt() - r1.start.toInt());
    int b = r2.start.toInt() +
        Random().nextInt(1 + r2.end.toInt() - r2.start.toInt());

    int a = ans + b;

    var q = Question('$a - $b', '$ans');

    int pos = Random().nextInt(4);

    // Wrong choices, = ans + or - 8.
    for (int i = 0; i < 4; i++) {
      if (i == pos)
        q.choices.add('$ans');
      else {
        int swing = max(r1.end.toInt(), r2.end.toInt()) - 1;

        var wrongAns = ans + Random().nextInt(swing * 2) - swing;
        while (wrongAns == ans) {
          wrongAns = ans + Random().nextInt(swing * 2) - swing;
        }
        q.choices.add('$wrongAns');
      }
    }
    return q;
  }

  static Question newQuestionMultiplication(
      {RangeValues r1 = const RangeValues(2, 12),
      RangeValues r2 = const RangeValues(6, 10)}) {
    int a = r1.start.toInt() +
        Random().nextInt(1 + r1.end.toInt() - r1.start.toInt());
    int b = r2.start.toInt() +
        Random().nextInt(1 + r2.end.toInt() - r2.start.toInt());
    int ans = a * b;

    var q = Question('$a x $b', '$ans');

    int pos = Random().nextInt(4);

    for (int i = 0; i < 4; i++) {
      if (i == pos)
        q.choices.add('$ans');
      else {
        var wrongAns =
            ans + b * Random().nextInt(3) + Random().nextInt(2 * a) - a;
        while (wrongAns == ans) {
          wrongAns =
              ans + b * Random().nextInt(3) + Random().nextInt(2 * a) - a;
        }
        q.choices.add('$wrongAns');
      }
    }
    return q;
  }

  static Question newQuestionDivision() {
    // answer
    int ans = 2 + Random().nextInt(11);
    // first operand min 6, max 9
    int b = 6 + Random().nextInt(4);
    int a = ans * b;

    var q = Question('$a / $b', '$ans');

    int pos = Random().nextInt(4);

    for (int i = 0; i < 4; i++) {
      if (i == pos)
        q.choices.add('$ans');
      else {
        var wrongAns = Random().nextInt(12);
        while (wrongAns == ans) {
          wrongAns = Random().nextInt(12);
        }
        q.choices.add('$wrongAns');
      }
    }

    return q;
  }

  static List<Question> getDrillQuestions({DrillType type}) {
    List<Question> questions = [];

    for (int i = 0; i < 10; i++) {
      if (type == DrillType.addition) {
        questions.add(newQuestionAddition());
      }
      if (type == DrillType.subtraction) {
        questions.add(newQuestionSubtraction());
      }
      if (type == DrillType.multiplication) {
        questions.add(newQuestionMultiplication());
      }
      if (type == DrillType.division) {
        questions.add(newQuestionDivision());
      }
    }

    return questions;
  }

  static Drill getAdditionDrill() {
    return Drill(
        questions: getDrillQuestions(type: DrillType.addition),
        type: DrillType.addition);
  }

  static Drill getSubtractionDrill() {
    return Drill(
        questions: getDrillQuestions(type: DrillType.subtraction),
        type: DrillType.subtraction);
  }

  static Drill getMultiplicationDrill() {
    return Drill(
        questions: getDrillQuestions(type: DrillType.multiplication),
        type: DrillType.multiplication);
  }

  static Drill getDivisionDrill() {
    return Drill(
        questions: getDrillQuestions(type: DrillType.division),
        type: DrillType.division);
  }

  static Drill getDrillWith({DrillType type, DrillSettings settings}) {
    if (type == DrillType.custom) {
      return getCustomDrill(settings: settings);
    } else {
      return Drill(questions: getDrillQuestions(type: type), type: type);
    }
  }

  static Drill getCustomDrill({DrillSettings settings}) {
    List<Function> questionGenerators = [];

    if (settings.addition) questionGenerators.add(newQuestionAddition);
    if (settings.subtraction) questionGenerators.add(newQuestionSubtraction);
    if (settings.multiplication)
      questionGenerators.add(newQuestionMultiplication);

    List<Question> questions = [];
    for (int i = 0; i < 10; i++) {
      var q = questionGenerators[Random().nextInt(questionGenerators.length)];
      questions.add(
          q(r1: settings.firstOperandRange, r2: settings.secondOperandRange));
    }

    return Drill(
        questions: questions, type: DrillType.custom, settings: settings);
  }
}
