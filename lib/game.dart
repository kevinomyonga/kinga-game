import 'package:flutter/material.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/views/about-view.dart';
import 'package:kinga/views/help-view.dart';

class GameWidget extends StatefulWidget {
  @override
  _GameWidgetState createState() => _GameWidgetState();
}

class _GameWidgetState extends State<GameWidget> {

  GameController gameController;

  _GameWidgetState() {
    gameController = new GameController();
  }

  @override
  void initState() {
    super.initState();
    gameController.showHelp = () {
      showDialog(
          context: context,
          builder: (BuildContext buildContext) {
            return HelpDialog();
          });
    };
    gameController.showCredits = () {
      showDialog(
          context: context,
          builder: (BuildContext buildContext) {
            return AboutGameDialog();
          });
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        gameController.widget,
      ]),
    );
  }
}