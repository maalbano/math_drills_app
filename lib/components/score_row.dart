import 'package:flutter/material.dart';



class ScoreRow extends StatelessWidget {
  final String scoreText;
  final String timeText;

  const ScoreRow({@required this.scoreText, @required this.timeText});


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.timelapse),
            Text(
              ' ' + scoreText,
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.watch_later),
            Text(
              ' ' + timeText,
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),

      ],
    );
  }
}
