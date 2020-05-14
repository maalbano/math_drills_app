import 'package:flutter/material.dart';

class ChoiceButton extends StatelessWidget {
  final String choice;
  final Function onPressed;

  ChoiceButton({@required this.choice, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          margin: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor, //kChoiceButtonColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(
              choice,
              style: Theme.of(context)
                  .textTheme
                  .headline3, //kChoiceButtonTextStyle,
            ),
          ),
        ),
      ),
    );
  }
}
