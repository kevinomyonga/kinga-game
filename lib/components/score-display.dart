import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:kinga/controllers/game_controller.dart';

class ScoreDisplay {

  final GameController gameController;
  TextPainter painter;
  Offset position;

  ScoreDisplay(this.gameController) {
    painter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    position = Offset.zero;
  }

  void render(Canvas c) {
    painter.paint(c, position);
  }

  void update(double t) {
    if((painter.text ?? '') != gameController.playView.score.toString()) {

      Shadow shadow = Shadow(
        blurRadius: gameController.tileSize * .0625,
        color: Colors.black,
        offset: Offset.zero,
      );

      painter.text = TextSpan(
        text: gameController.playView.score.toString(),
        style: TextStyle(
          color: Colors.white,
          fontSize: 70.0,
          shadows: <Shadow>[shadow, shadow, shadow, shadow, shadow, shadow, shadow, shadow],
        ),
      );
      painter.layout();

      position = Offset(
          (gameController.screenSize.width / 2) - (painter.width / 2),
          (gameController.screenSize.height * 0.2) - (painter.height / 2),
      );
    }
  }
}