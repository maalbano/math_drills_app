import 'package:flutter/material.dart';
import '../constants.dart';

class BottomButton extends StatelessWidget {
  final String label;
  final Function onPressed;

  BottomButton({@required this.label, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.only(bottom: 20),
        child: Center(
          child: Text(
            label,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        color: Theme.of(context).primaryColor,
        margin: EdgeInsets.only(top: 15),
        width: double.infinity,
        height: kBottomContainerHeight,
      ),
    );
  }
}
