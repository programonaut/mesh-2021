import 'package:challengefinder/widgets/add_box.dart';
import 'package:challengefinder/widgets/call_to_action.dart';
import 'package:flutter/material.dart';

class ChallengeScreen extends StatelessWidget {
  const ChallengeScreen({Key key, this.challenge = "", this.call=""}) : super(key: key);

  final challenge;
  final call;

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
              child: Center(child: Text("UnMaze", style: Theme.of(context).textTheme.headline1)),
            ),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CallToAction(call: call),
                  SizedBox(width: 10),
                  QuestionBox(),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text(challenge, style: Theme.of(context).textTheme.headline5)],
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
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
