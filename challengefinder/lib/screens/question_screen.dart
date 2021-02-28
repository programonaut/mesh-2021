import 'package:challengefinder/config/palette.dart';
import 'package:challengefinder/widgets/add_box.dart';
import 'package:challengefinder/widgets/call_to_action.dart';
import 'package:challengefinder/widgets/drop_box.dart';
import 'package:challengefinder/widgets/tag_box.dart';
import 'package:flutter/material.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({Key key, this.tags = const <String>[], this.selected = const <String>[], this.category = "", this.nextScreen, this.history="", this.call=""}) : super(key: key);

  final history;
  final call;
  final tags;
  final selected;
  final category;
  final Widget nextScreen;

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  List<String> tags = [];
  List<String> selected = [];

  @override
  void initState() {
    super.initState();
    tags = ["Mehrere ${widget.category}e", "Mehrere Gemeinsamkeiten zwischen den ${widget.category}en", "Weder noch"];
    selected.addAll(widget.selected);
  }

  void handleSelected(String element) {
    setState(() {
      if (selected.contains(tags[2]) && tags.indexOf(element) != 2 || !selected.contains(tags[2]) && tags.indexOf(element) == 2) {
        selected = [];
      }
      // tag index = 2 nicht wählbar
      if (!selected.contains(element))
        selected.add(element);
      else if (selected.contains(element)) selected.remove(element);
    });
  }

  Future<bool> handleAnswer() async {
    String reason;
    print("$selected =>");
    if (selected.length == 2) {
      //alles ist gut einfach weiter
    } else if (selected.length == 1 && tags.indexOf(selected[0]) == 0) {
      print("Du solltest deine Frage etwas offener gestalten.");
      reason = "Du solltest deine Frage etwas offener gestalten.";
    } else if (selected.length == 1 && tags.indexOf(selected[0]) == 1) {
      print("Du solltest deine Frage etwas eingrenzen.");
      reason = "Du solltest deine Frage etwas eingrenzen.";
    } else if (selected.length == 1 && tags.indexOf(selected[0]) == 2) {
      print("Du solltest deine Frage neu gestalten.!");
      reason = "Du solltest deine Frage neu gestalten.";
    }

    if (reason != null) {
      await showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Iteriere!'),
            backgroundColor: Palette.background,
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(reason, style: Theme.of(context).textTheme.bodyText1),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Ignorieren', style: TextStyle(color: Palette.accent)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
    return true;
  }

  List<Widget> createBoxes() {
    return [
      if (selected.length == 0) ...[
        DropBox(category: "In dieser Situation gibt es...", showInBoxDescription: false),
      ] else ...[
        SelectedBox(category: "In dieser Situation gibt es...", element: handleSelectedString()),
      ]
    ];
  }

  String handleSelectedString() {
    if (selected.length == 2) return "${selected[0]} und ${selected[1]}";
    return selected[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: Center(child: Text(widget.history, style: Theme.of(context).textTheme.headline1)),
            ),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CallToAction(call: widget.call),
                  SizedBox(width: 10),
                  QuestionBox(),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: createBoxes(),
              ),
            ),
            // DropBox(),
            Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var i = 0; i < tags.length; i++) ...[
                        TagBox(
                          tag: tags[i],
                          selected: selected.contains(tags[i]),
                          onClick: () => handleSelected(tags[i]),
                        ),
                        if (i != tags.length - 1) SizedBox(width: 10),
                      ],
                    ],
                  ),
                  if (selected.length > 0 && widget.nextScreen != null) ...[
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: GestureDetector(
                        child: Icon(
                          Icons.arrow_downward,
                          size: 64,
                          color: Palette.textColor,
                        ),
                        onTap: () {
                          handleAnswer().then((value) => Navigator.of(context).push(MaterialPageRoute(builder: (context) => widget.nextScreen)));
                        },
                      ),
                    )
                  ]
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
