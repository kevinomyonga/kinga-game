import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flutter/widgets.dart';
import 'package:kinga/components/buttons/back-button.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/game_state.dart';
import 'package:kinga/res/assets.dart';

class LostView {

  final GameController gameController;
  Rect rect;
  Sprite sprite;

  BackButton backButton;

  LostView(this.gameController) {
    resize();
    sprite = Sprite(Assets.gameOverImg);

    backButton = BackButton(gameController);
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);

    backButton.render(c);
  }

  void update(double t) {
  }

  void resize() {
    rect = Rect.fromLTWH(
      (gameController.screenSize.width / 2) - (gameController.tileSize * 3.5),
      (gameController.screenSize.height / 2) - (gameController.tileSize * 5),
      gameController.tileSize * 7,
      gameController.tileSize * 5,
    );

    backButton?.resize();
  }

  /*void onTapDown(TapDownDetails d) {
    bool isHandled = false;

    // Back Button
    if (!isHandled && backButton.rect.contains(d.globalPosition)) {
      if (gameController.gameState == GameState.CREDITS || gameController.gameState == GameState.GAME_OVER) {
        backButton.onTapDown();
        isHandled = true;
      }
    }
  }*/

  void onTapUp(TapUpDetails d) {
    bool isHandled = false;

    // Back Button
    if (!isHandled && backButton.rect.contains(d.globalPosition)) {
      if (gameController.gameState == GameState.CREDITS || gameController.gameState == GameState.GAME_OVER) {
        backButton.onTapUp();
        isHandled = true;
      }
    }
  }
}