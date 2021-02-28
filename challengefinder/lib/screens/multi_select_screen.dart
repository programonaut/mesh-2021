import 'package:challengefinder/config/palette.dart';
import 'package:challengefinder/widgets/add_box.dart';
import 'package:challengefinder/widgets/call_to_action.dart';
import 'package:challengefinder/widgets/drop_box.dart';
import 'package:challengefinder/widgets/tag_box.dart';
import 'package:flutter/material.dart';

class MultiSelectScreen extends StatefulWidget {
  const MultiSelectScreen({Key key,this.history="", this.call="", this.selected = const <String>[], this.categories = const <String, List<String>>{}, this.nextScreen}) : super(key: key);

  final history;
  final call;
  final selected;
  final Map<String, List<String>> categories;
  final Widget nextScreen;

  @override
  _MultiSelectScreenState createState() => _MultiSelectScreenState();
}

class _MultiSelectScreenState extends State<MultiSelectScreen> {
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

  bool allOne() {
    bool all = true;
    for (var category in selected.keys) {
      print("$category has length ${selected[category].length}");
      if(selected[category].length != 1){
        all = false;
      }
    }
    print("all one will return $all");
    return all;
  }

  List<Widget> createBoxes() {
    return [
      for (var category in widget.categories.keys) ...[
        Column(
          children: [
            if (selected[category].length == 0) ...[
              DropBox(category: category),
            ] else ...[
              SelectedBox(category: category, element: selected[category][0]),
            ],
            SizedBox(height: 30),
            for (var i = 0; i < widget.categories[category].length; i++) ...[
              TagBox(
                tag: widget.categories[category].elementAt(i),
                selected: selected[category].contains(widget.categories[category].elementAt(i)),
                onClick: () => handleSelected(category, widget.categories[category].elementAt(i)),
              ),
              SizedBox(height: 10),
            ],
          ],
        ),
        if (category != widget.categories.keys.last) ... [
          SizedBox(width: 50),
        ]
      ],
    ];
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
              flex: 8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: createBoxes(),
              ),
            ),
            // DropBox(),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // for (var i = 0; i < tags.length; i++) ...[
                      //   TagBox(
                      //     tag: tags[i],
                      //     selected: selected.contains(tags[i]),
                      //     onClick: () => handleSelected(tags[i]),
                      //   ),
                      //   SizedBox(width: 10),
                      // ],
                      // AddBox(),
                    ],
                  ),
                  if (allOne() && widget.nextScreen != null) ...[
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
