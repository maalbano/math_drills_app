import 'dart:math';
import 'drill.dart';

class DrillGenerator {
  //A Random Drill Generator

  static Question newQuestionAddition() {
    // Addition problem
    // first operand min 2, max 21
    int a = 2 + Random().nextInt(20);
    // 2nd operand min 2, max 11
    int b = 2 + Random().nextInt(10);
    int ans = a + b;

    var q = Question('$a + $b', '$ans');

    int pos = Random().nextInt(4);

    // Wrong choices, = ans + or - 8.
    for (int i = 0; i < 4; i++) {
      if (i == pos)
        q.choices.add('$ans');
      else {
        var wrongAns = ans + Random().nextInt(16) - 8;
        while (wrongAns == ans) {
          wrongAns = ans + Random().nextInt(16) - 8;
        }
        q.choices.add('$wrongAns');
      }
    }
    return q;
  }

  static Question newQuestionSubtraction() {
    // Addition problem
    // first operand min 2, max 21
    int ans = 2 + Random().nextInt(20);
    // 2nd operand min 2, max 11
    int b = 2 + Random().nextInt(10);
    int a = ans + b;

    var q = Question('$a - $b', '$ans');

    int pos = Random().nextInt(4);

    // Wrong choices, = ans + or - 8.
    for (int i = 0; i < 4; i++) {
      if (i == pos)
        q.choices.add('$ans');
      else {
        var wrongAns = ans + Random().nextInt(16) - 8;
        while (wrongAns == ans) {
          wrongAns = ans + Random().nextInt(16) - 8;
        }
        q.choices.add('$wrongAns');
      }
    }
    return q;
  }

  static Question newQuestionMultiplication() {
    // first operand min 2, max 13
    int a = 2 + Random().nextInt(12);
    // first operand min 6, max 9
    int b = 6 + Random().nextInt(4);
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

  static Drill getDrillWith({DrillType type}) {
    return Drill(questions: getDrillQuestions(type: type), type: type);
  }
}
