import 'package:flame/time.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/res/assets.dart';
import 'package:kinga/res/strings.dart';

class CountdownDisplay {

  final GameController gameController;
  TextPainter painter;
  Offset position;

  Timer interval;

  CountdownDisplay(this.gameController) {
    painter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    position = Offset.zero;

    interval = Timer(1, repeat: true, callback: () {
      gameController.continueView.timeLeft--;
    });
    interval.start();
  }

  void render(Canvas c) {
    painter.paint(c, position);
  }

  void update(double t) {

    interval.update(t);
    int timeLeft = gameController.continueView.timeLeft > 0 ? gameController.continueView.timeLeft : 0;

    Shadow shadow = Shadow(
      blurRadius: gameController.tileSize * .0625,
      color: Colors.black,
      offset: Offset.zero,
    );

    painter.text = TextSpan(
      text: '$timeLeft',
      style: TextStyle(
        color: Colors.white,
        fontFamily: Assets.fontEquestria,
        fontSize: gameController.tileSize * 1.25,
        shadows: <Shadow>[shadow, shadow, shadow, shadow, shadow, shadow, shadow, shadow],
      ),
    );
    painter.layout();

    position = Offset(
      (gameController.screenSize.width / 2) - (painter.width / 2),
      (gameController.screenSize.height * 0.5) - (painter.height / 2),
    );
  }
}