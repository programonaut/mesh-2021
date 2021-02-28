import 'package:challengefinder/config/palette.dart';
import 'package:flutter/material.dart';

class TagBox extends StatelessWidget {
  const TagBox({Key key, this.selected = true, this.tag="", @required this.onClick}) : super(key: key);
  final tag;
  final selected;
  final Function onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        child: Text(
          tag,
          style: selected ? Theme.of(context).textTheme.bodyText2 : Theme.of(context).textTheme.bodyText1,
        ),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
