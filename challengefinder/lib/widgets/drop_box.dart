import 'package:challengefinder/config/palette.dart';
import 'package:flutter/material.dart';

class DropBox extends StatelessWidget {
  const DropBox({Key key, this.category="", this.showInBoxDescription=true}) : super(key: key);

  final String category;
  final bool showInBoxDescription;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(category, style: Theme.of(context).textTheme.headline3),
        Container(
          constraints: BoxConstraints(
            minHeight: 180,
            minWidth: 400,
          ),
          decoration: BoxDecoration(border: Border.all(width: 1, style: BorderStyle.solid, color: Palette.textColor)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  showInBoxDescription ? "Hier wird dein $category hinzugefügt" : "",
                  style: Theme.of(context).textTheme.headline4,
                  // textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}


class SelectedBox extends StatelessWidget {
  const SelectedBox({Key key, this.category="", this.id=0, this.element=""}) : super(key: key);

  final String category;
  final int id;
  final String element;


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(
            minHeight: 210,
            minWidth: 400,
          ),
          // decoration: BoxDecoration(border: Border.all(width: 1, style: BorderStyle.solid, color: Palette.textColor)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("$category${id != 0 ? ' $id' : ''}", style: Theme.of(context).textTheme.headline3),
              Text(
                element,
                style: Theme.of(context).textTheme.headline5,
                // textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
