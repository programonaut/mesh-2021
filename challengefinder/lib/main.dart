import 'package:challengefinder/screens/define_challenge.dart';
import 'package:challengefinder/screens/multi_select_screen.dart';
import 'package:challengefinder/screens/question_screen.dart';
import 'package:flutter/material.dart';
import 'config/palette.dart';
import 'screens/select_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Roboto',
        primarySwatch: Colors.blue,
        canvasColor: Palette.background,
        primaryColor: Palette.textColor,
        hintColor: Palette.textColor,
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 44, color: Palette.textColor, fontWeight: FontWeight.w100, letterSpacing: 0), //rückblick
          headline2: TextStyle(fontSize: 20, color: Palette.textColor, fontWeight: FontWeight.w400, letterSpacing: 0), // call to action
          headline3: TextStyle(fontSize: 24, color: Palette.textColor, fontWeight: FontWeight.w300, letterSpacing: 0), // box title
          headline4: TextStyle(fontSize: 22, color: Palette.textColor, fontWeight: FontWeight.w300, letterSpacing: 0), // empty box description
          headline5: TextStyle(fontSize: 48, color: Palette.textColor, fontWeight: FontWeight.w700, letterSpacing: 0), // rückblick
          headline6: TextStyle(color: Palette.textColor),
          bodyText1: TextStyle(fontSize: 24, color: Palette.textColor, fontWeight: FontWeight.w300, letterSpacing: 0), // tag box unselected
          bodyText2: TextStyle(fontSize: 24, color: Palette.textColor, fontWeight: FontWeight.w400, letterSpacing: 0), // tag box
        ),
      ),
      home: SelectScreen(
        history: "Unmaze!",
        call: "Wähle dein Thema!",
        category: "Thema",
        tags: ["Sustainability"],
        nonTags: ["Mobility"],
        nextScreen: SelectScreen(
          history: "Sustainability",
          call: "Wähle die beteiligten Handlungsorte!",
          category: "Handlungsort",
          tags: ["Schule"],
          nextScreen: SelectScreen(
            history: "Schule",
            call: "Wähle die beteiligten Charaktere!",
            category: "Charakter",
            tags: ["Schüler"],
            nextScreen: SelectScreen(
              history: "Schüler",
              call: "Wähle die beteiligten Charaktere!",
              category: "Potentielles Problem",
              tags: ["Abfall"],
              //Auswahl der favs
              nextScreen: MultiSelectScreen(
                call: "Triff deine Auswahl!",
                categories: {
                  "Handlungsort": ["Schule"],
                  "Charakters": ["Schüler"],
                  "Potentielles Problem": ["Abfall"]
                },
                // Define the challenge (new screen)
                nextScreen: DefineChallenge(
                  call: "Definiere deine challenge!",
                  categories: {
                    "Handlungsort": ["Schule"],
                    "Charakters": ["Schüler"],
                    "Potentielles Problem": ["Abfall"]
                  },
                  // frage, antwort spiel
                  nextScreen: QuestionScreen(
                    call: "Beantworte die Frage!",
                    category: "Charakter",
                    nextScreen: QuestionScreen(
                      call: "Beantworte die Frage!",
                      category: "Problem",
                      nextScreen: QuestionScreen(
                        call: "Beantworte die Frage!",
                        category: "Bedürfniss",
                        nextScreen: SelectScreen(
                          category: "You got your challenge",
                          tags: ["Schule"],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
