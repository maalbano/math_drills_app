import 'package:theme_provider/theme_provider.dart';

import 'quiz_page.dart';
import 'package:flutter/material.dart';
import 'drill_generator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      saveThemesOnChange: true,
      loadThemeOnInit: true,
      themes: [
        AppTheme(
          id: "black_and_blue", // Id(or name) of the theme(Has to be unique)
          description: "The original theme",
          data: ThemeData.dark().copyWith(
            appBarTheme: AppBarTheme(
              color: Colors.blue,
            ),
            scaffoldBackgroundColor: Colors.black,
            primaryColor: Colors.blue,
            //textTheme: TextTheme(),
          ),
        ),
        AppTheme(
          id: "green", // Id(or name) of the theme(Has to be unique)
          description: "Green",
          data: ThemeData(
            // Real theme data
            primarySwatch: Colors.green,
            scaffoldBackgroundColor: Colors.green.shade200,
          ),
        ),
        AppTheme(
          id: "pink_and_green", // Id(or name) of the theme(Has to be unique)
          description: "Pink and Green",
          data: ThemeData(
            // Real theme data
            primarySwatch: Colors.green,
            scaffoldBackgroundColor: Colors.pink.shade200,
            accentColor: Colors.pink,
          ),
        ),
        AppTheme(
          id: "pink", // Id(or name) of the theme(Has to be unique)
          description: "Pink",
          data: ThemeData(
            // Real theme data
            primaryColor: Colors.pink,
            accentColor: Colors.pinkAccent,
            scaffoldBackgroundColor: Colors.pink.shade200,
          ),
        ),
        AppTheme
            .dark(), // This is standard dark theme (id is default_dark_theme)

        AppTheme
            .light(), // This is standard light theme (id is default_light_theme)
      ],
      child: MaterialApp(
        title: 'Math Drills',
        //theme: theme,
        home: ThemeConsumer(
          child: QuizPage(
            drill: DrillGenerator.getMultiplicationDrill(),
          ),
        ),
      ),
    );
  }
}
