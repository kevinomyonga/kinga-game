import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/res/assets.dart';
import 'package:kinga/res/strings.dart';

class HighScoreDisplay {

  final GameController gameController;
  TextPainter painter;
  Offset position;

  Rect rectHeader;
  Sprite spriteHeader;
  Rect rectContent;
  Sprite spriteContent;

  HighScoreDisplay(this.gameController) {
    resize();
    painter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    position = Offset.zero;

    spriteHeader = Sprite(Assets.dialogHeaderBgImg);
    spriteContent = Sprite(Assets.dialogBgImg);
  }

  void render(Canvas c) {
    spriteContent.renderRect(c, rectContent);
    spriteHeader.renderRect(c, rectHeader);
    painter.paint(c, position);
  }

  void update(double t) {
    int highScore = gameController.gameData.getHighScore();

    Shadow shadow = Shadow(
      blurRadius: gameController.tileSize * .0625,
      color: Colors.black,
      offset: Offset.zero,
    );

    painter.text = TextSpan(
      text: '${AppStrings.highScore}\n$highScore',
      style: TextStyle(
        color: Colors.white,
        fontFamily: Assets.fontEquestria,
        fontSize: gameController.tileSize * .65,
        shadows: <Shadow>[shadow, shadow, shadow, shadow, shadow, shadow, shadow, shadow],
      ),
    );
    painter.layout();

    /*position = Offset(
      (gameController.screenSize.width / 2) - (painter.width / 2),
      (gameController.screenSize.height * 0.2) - (painter.height / 2),
    );*/
    position = Offset(
      gameController.screenSize.width - (gameController.tileSize * .75) - painter.width,
      gameController.tileSize * .85,
    );
  }

  void resize() {
    rectHeader = Rect.fromLTWH(
      gameController.screenSize.width - (gameController.tileSize * 3.5),
      gameController.tileSize * .75,
      gameController.tileSize * 3,
      gameController.tileSize,
    );
    rectContent = Rect.fromLTWH(
      gameController.screenSize.width - (gameController.tileSize * 3.75),
      gameController.tileSize * 1.45,
      gameController.tileSize * 3.5,
      gameController.tileSize,
    );
  }
}