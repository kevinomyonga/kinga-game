import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/res/Ids.dart';
import 'package:kinga/res/strings.dart';

class HighScoreDisplay {

  final GameController gameController;
  TextPainter painter;
  Offset position;

  HighScoreDisplay(this.gameController) {
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
    int highScore = gameController.storage.getInt(Ids.sharedPrefHighScore) ?? 0;

    Shadow shadow = Shadow(
      blurRadius: gameController.tileSize * .0625,
      color: Colors.black,
      offset: Offset.zero,
    );

    painter.text = TextSpan(
      text: AppStrings.highScore + ': $highScore',
      style: TextStyle(
        color: Colors.white,
        fontSize: gameController.tileSize * .75,
        shadows: <Shadow>[shadow, shadow, shadow, shadow, shadow, shadow, shadow, shadow],
      ),
    );
    painter.layout();

    /*position = Offset(
      (gameController.screenSize.width / 2) - (painter.width / 2),
      (gameController.screenSize.height * 0.2) - (painter.height / 2),
    );*/
    position = Offset(
      gameController.screenSize.width - (gameController.tileSize * .25) - painter.width,
      gameController.tileSize * .25,
    );
  }
}