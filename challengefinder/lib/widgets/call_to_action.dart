import 'package:flutter/material.dart';

class CallToAction extends StatelessWidget {
  const CallToAction({Key key, this.call}) : super(key: key);
  final call;

  @override
  Widget build(BuildContext context) {
    return Text(call, style: Theme.of(context).textTheme.headline2);
  }
}