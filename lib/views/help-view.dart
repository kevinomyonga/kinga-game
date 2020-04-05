import 'package:flutter/material.dart';
import 'package:kinga/res/strings.dart';

class HelpDialog extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
      ),
      title: Text(
        AppStrings.howToPlay,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30.0),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            AppStrings.howToPlayExplanation,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}