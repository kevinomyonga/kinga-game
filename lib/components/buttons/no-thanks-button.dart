import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:kinga/components/buttons/base-button.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/res/assets.dart';
import 'package:kinga/res/strings.dart';

class NoThanksButton extends BaseButton {

  final GameController gameController;
  Rect rect;
  Sprite sprite;

  TextPainter painter;
  Offset position;

  NoThanksButton(this.gameController) : super(gameController) {
    resize();
    sprite = Sprite(Assets.bgMenuButton);

    painter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    position = Offset.zero;
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
    painter.paint(c, position);
  }

  void update(double t) {

    Shadow shadow = Shadow(
      blurRadius: gameController.tileSize * .0625,
      color: Colors.black,
      offset: Offset.zero,
    );

    painter.text = TextSpan(
      text: AppStrings.noThanks,
      style: TextStyle(
        color: Colors.white,
        fontFamily: Assets.fontEquestria,
        fontSize: gameController.tileSize * .75,
        shadows: <Shadow>[shadow, shadow, shadow, shadow, shadow, shadow, shadow, shadow],
      ),
    );
    painter.layout();

    position = Offset(
      (gameController.screenSize.width / 2) - (painter.width / 2),
      ((gameController.screenSize.height * .75) - (gameController.tileSize * 1.5)
          + (gameController.tileSize * 1.5 / 2)) - (painter.height / 2),
    );
  }

  void resize() {
    rect = Rect.fromLTWH(
      (gameController.screenSize.width / 2) - (gameController.tileSize * 3),
      (gameController.screenSize.height * .75) - (gameController.tileSize * 1.5),
      gameController.tileSize * 6,
      gameController.tileSize * 1.5,
    );
  }

  void onTapUp() {
    super.onTapUp();
    gameController.playView.endGame();
  }
}