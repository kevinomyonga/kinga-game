import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/res/assets.dart';
import 'package:kinga/res/strings.dart';

class VersionDisplay {

  final GameController gameController;
  TextPainter painter;
  Offset position;

  VersionDisplay(this.gameController) {
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

    Shadow shadow = Shadow(
      blurRadius: gameController.tileSize * .0625,
      color: Colors.black,
      offset: Offset.zero,
    );

    painter.text = TextSpan(
      text: AppStrings.pause,
      style: TextStyle(
        color: Colors.white,
        fontFamily: Assets.fontEquestria,
        fontSize: gameController.tileSize * .55,
        shadows: <Shadow>[shadow, shadow, shadow, shadow, shadow, shadow, shadow, shadow],
      ),
    );
    painter.layout();

    position = Offset(
      (gameController.screenSize.width / 2) - (painter.width / 2),
      (gameController.screenSize.height * 0.3) - (painter.height / 2),
    );
  }
}