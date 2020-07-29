import 'package:flutter/material.dart';
import 'package:mathdrillsapp/bottom_button.dart';
import 'package:mathdrillsapp/drill_generator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'constants.dart';

class CustomDrillPage extends StatefulWidget {
  @override
  _CustomDrillPageState createState() => _CustomDrillPageState();
}

class _CustomDrillPageState extends State<CustomDrillPage> {
  RangeValues firstOperandRange = RangeValues(2, 10);
  RangeValues secondOperandRange = RangeValues(2, 10);

  bool plusSelected = true;
  bool minusSelected = true;
  bool multiplicationSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Math Drills'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Theme.of(context)
                      .primaryColor
                      .withAlpha(50), //kQuizPageTransparentBackgroundColor,
                ),
                margin: EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      '${firstOperandRange.start.toInt()}...${firstOperandRange.end.toInt()}',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        plusSelected
                            ? Icon(
                                Icons.add,
                                size: 30,
                                color: Theme.of(context).primaryColor,
                              )
                            : Text(' '),
                        minusSelected
                            ? Icon(
                                Icons.remove,
                                size: 30,
                                color: Theme.of(context).primaryColor,
                              )
                            : Text(' '),
                        multiplicationSelected
                            ? Icon(
                                Icons.close,
                                size: 30,
                                color: Theme.of(context).primaryColor,
                              )
                            : Text(' '),
                      ],
                    ),
                    Text(
                      '${secondOperandRange.start.toInt()}...${secondOperandRange.end.toInt()}',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ],
                ),
              ),
            ),
            //Text('Drill Settings'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                InputChip(
                  label: Text('Addition'),
                  selected: plusSelected,
                  avatar: CircleAvatar(
                    child: Icon(
                      Icons.add,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  checkmarkColor: Theme.of(context).accentColor,
                  selectedColor: Theme.of(context).primaryColor,
                  onSelected: (v) {
                    setState(() {
                      plusSelected = v;
                    });
                  },
                ),
                InputChip(
                  checkmarkColor: Theme.of(context).accentColor,
                  selectedColor: Theme.of(context).primaryColor,
                  label: Text('Subtraction'),
                  selected: minusSelected,
                  avatar: CircleAvatar(
                    child: Icon(
                      Icons.remove,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  onSelected: (v) {
                    setState(() {
                      minusSelected = v;
                    });
                  },
                ),
                InputChip(
                  checkmarkColor: Theme.of(context).accentColor,
                  selectedColor: Theme.of(context).primaryColor,
                  label: Text('Multiplication'),
                  selected: multiplicationSelected,
                  avatar: CircleAvatar(
                    child: Icon(
                      Icons.close,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  onSelected: (v) {
                    setState(() {
                      multiplicationSelected = v;
                    });
                  },
                ),
              ],
            ),
            RangeSlider(
              values: firstOperandRange,
              min: 0,
              max: 12,
              divisions: 12,
              labels: RangeLabels(
                firstOperandRange.start.toStringAsFixed(0),
                firstOperandRange.end.toStringAsFixed(0),
              ),
              onChanged: (v) {
                print(v);
                setState(() {
                  firstOperandRange = v;
                });
              },
            ),
            Text(
              'First operand: ${firstOperandRange.start.toInt()} to ${firstOperandRange.end.toInt()}',
            ),
            RangeSlider(
              values: secondOperandRange,
              min: 0,
              max: 12,
              divisions: 12,
              labels: RangeLabels(
                secondOperandRange.start.toStringAsFixed(0),
                secondOperandRange.end.toStringAsFixed(0),
              ),
              onChanged: (v) {
                print(v);
                setState(() {
                  secondOperandRange = v;
                });
              },
            ),
            Text(
              'Second operand: ${secondOperandRange.start.toInt()} to ${secondOperandRange.end.toInt()}',
            ),
            Expanded(
              flex: 2,
              child: BottomButton(
                label: 'Start Drill',
                onPressed: () {
                  if (plusSelected ||
                      minusSelected ||
                      multiplicationSelected == true) {
                    DrillSettings settings = DrillSettings(
                      addition: plusSelected,
                      subtraction: minusSelected,
                      multiplication: multiplicationSelected,
                      firstOperandRange: firstOperandRange,
                      secondOperandRange: secondOperandRange,
                    );
                    Navigator.pop(context, settings);
                  } else {
                    Alert(
                            context: context,
                            style: getAlertStyle(context),
                            title: 'Please select at least one operation.')
                        .show();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
