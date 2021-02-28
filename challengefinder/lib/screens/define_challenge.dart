import 'package:challengefinder/config/palette.dart';
import 'package:challengefinder/widgets/add_box.dart';
import 'package:challengefinder/widgets/call_to_action.dart';
import 'package:challengefinder/widgets/tag_box.dart';
import 'package:flutter/material.dart';

class DefineChallenge extends StatefulWidget {
  const DefineChallenge({Key key, this.history="", this.call="", this.selected = const <String>[], this.categories = const <String, List<String>>{}, this.nextScreen}) : super(key: key);

  final history;
  final call;
  final selected;
  final Map<String, List<String>> categories;
  final Widget nextScreen;

  @override
  _DefineChallengeState createState() => _DefineChallengeState();
}

class _DefineChallengeState extends State<DefineChallenge> {
  Map<String, List<String>> selected = {};

  @override
  void initState() {
    super.initState();
    for (var category in widget.categories.keys) {
      selected[category] = [];
    }
  }

  void handleSelected(String category, String element) {
    setState(() {
      // add
      if (!selected[category].contains(element) && selected[category].length == 0)
        selected[category].add(element);
      else if (selected[category].contains(element)) selected[category].remove(element);
    });
  }

  Widget createBoxes() {
    var location = widget.categories[widget.categories.keys.elementAt(0)][0];
    var character = widget.categories[widget.categories.keys.elementAt(1)][0];
    var problem = widget.categories[widget.categories.keys.elementAt(2)][0];
    return Text(
      "Wie können wir $character[n] in der $location mit dem $problem[-Problem] helfen?",
      style: Theme.of(context).textTheme.headline5,
      // textAlign: TextAlign.center,
    );
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
                children: [createBoxes()],
              ),
            ),
            // DropBox(),
            Expanded(
              flex: 5,
              child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (var category in widget.categories.keys) ... [
                        TagBox(
                          tag: widget.categories[category][0],
                          onClick: () => print("I will be clickable!"),
                        ),
                        SizedBox(width: 10),
                    ],
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: GestureDetector(
                    child: Icon(
                      Icons.arrow_downward,
                      size: 64,
                      color: Palette.textColor,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => widget.nextScreen),
                      );
                    },
                  ),
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}
