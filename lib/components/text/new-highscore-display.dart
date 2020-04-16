import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/res/assets.dart';
import 'package:kinga/res/strings.dart';

class NewHighScoreDisplay {

  final GameController gameController;
  TextPainter painter;
  Offset position;

  Rect rectLeft;
  Sprite spriteLeft;
  Rect rectRight;
  Sprite spriteRight;

  NewHighScoreDisplay(this.gameController) {
    resize();

    painter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    position = Offset.zero;

    spriteLeft = Sprite(Assets.star);
    spriteRight = Sprite(Assets.star);
  }

  void render(Canvas c) {
    painter.paint(c, position);
    spriteLeft.renderRect(c, rectLeft);
    spriteRight.renderRect(c, rectRight);
  }

  Future<void> update(double t) async {

    Shadow shadow = Shadow(
      blurRadius: gameController.tileSize * .0625,
      color: Colors.black,
      offset: Offset.zero,
    );

    painter.text = TextSpan(
      text: AppStrings.newHighScore,
      style: TextStyle(
        color: Colors.yellow,
        fontFamily: Assets.fontEquestria,
        fontSize: gameController.tileSize * .85,
        shadows: <Shadow>[shadow, shadow, shadow, shadow, shadow, shadow, shadow, shadow],
      ),
    );
    painter.layout();

    position = Offset(
      (gameController.screenSize.width / 2) - (painter.width / 2),
      gameController.tileSize * 10.8,
    );
  }

  void resize() {
    rectLeft = Rect.fromLTWH(
      (gameController.screenSize.width / 2) - (gameController.tileSize * 3.7),
      (gameController.screenSize.height * .65) - (gameController.tileSize * 1.5),
      gameController.tileSize,
      gameController.tileSize,
    );
    rectRight = Rect.fromLTWH(
      (gameController.screenSize.width / 2) + (gameController.tileSize * 2.7),
      (gameController.screenSize.height * .65) - (gameController.tileSize * 1.5),
      gameController.tileSize,
      gameController.tileSize,
    );
  }
}