import 'package:challengefinder/config/palette.dart';
import 'package:challengefinder/widgets/add_box.dart';
import 'package:challengefinder/widgets/call_to_action.dart';
import 'package:challengefinder/widgets/drop_box.dart';
import 'package:challengefinder/widgets/tag_box.dart';
import 'package:flutter/material.dart';

class SelectScreen extends StatefulWidget {
  const SelectScreen(
      {Key key,
      this.history = "",
      this.call = "",
      this.category = "",
      this.tags = const <String>[],
      this.nonTags = const <String>[],
      this.selected = const <String>[],
      this.onlyOne = false,
      this.nextScreen})
      : super(key: key);

  final history;
  final call;
  final tags;
  final nonTags;
  final selected;
  final category;
  final onlyOne;
  final Widget nextScreen;

  @override
  _SelectScreenState createState() => _SelectScreenState();
}

class _SelectScreenState extends State<SelectScreen> {
  List<String> tags = [];
  List<String> selected = [];

  @override
  void initState() {
    super.initState();
    tags.addAll(widget.tags);
    selected.addAll(widget.selected);
  }

  void handleSelected(String element) {
    setState(() {
      // add
      if (!selected.contains(element) || widget.onlyOne && selected.length == 0)
        selected.add(element);
      else if (selected.contains(element)) selected.remove(element);
    });
  }

  List<Widget> createBoxes() {
    return [
      if (selected.length == 0) ...[
        DropBox(category: widget.category),
      ] else ...[
        for (var i = 0; i < selected.length; i++) ...[
          SelectedBox(category: widget.category, id: selected.length > 1 ? i + 1 : 0, element: selected[i]),
          if (i != selected.length - 1) ...[
            SizedBox(width: 50),
          ]
        ]
      ]
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
                      for (var tag in tags) ...[
                        TagBox(
                          tag: tag,
                          selected: selected.contains(tag),
                          onClick: () => handleSelected(tag),
                        ),
                        SizedBox(width: 10),
                      ],
                      for (var tag in widget.nonTags) ...[
                        TagBox(
                          tag: tag,
                          selected: selected.contains(tag),
                          onClick: () => ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Palette.accent,
                              content: Text(
                                'I`m a prototype! I will be clickable In the future!\n -> Click the first element!',
                                style: Theme.of(context).textTheme.bodyText1,
                                textAlign: TextAlign.center,
                              ),
                              duration: const Duration(seconds: 5),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                      ],
                      AddBox(
                        onClick: () => ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Palette.accent,
                            content: Text(
                              'I`m a prototype! I will be clickable In the future!\n -> Click the first element!',
                              style: Theme.of(context).textTheme.bodyText1,
                              textAlign: TextAlign.center,
                            ),
                            duration: const Duration(seconds: 5),
                          ),
                        ),
                      ),
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
