import 'package:challengefinder/config/palette.dart';
import 'package:flutter/material.dart';

class AddBox extends StatelessWidget {
  const AddBox({Key key, this.selected = false, this.tag="", @required this.onClick}) : super(key: key);
  final tag;
  final selected;
  final Function onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        child: Icon(Icons.add, color: Palette.textColor),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          color: Palette.accent,
          // border: Border.all(
          //   color: Palette.textColor,
          //   style: BorderStyle.solid
          // ),
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          ),
        ),
      ),
    );
  }
}

class QuestionBox extends StatelessWidget {
  const QuestionBox({Key key, this.selected = false, this.tag=""}) : super(key: key);
  final tag;
  final selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Icon(Icons.help, color: Palette.textColor),
    );
  }
}

