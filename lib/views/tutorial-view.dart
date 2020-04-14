import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flutter/widgets.dart';
import 'package:kinga/components/buttons/back-button.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/game_state.dart';
import 'package:kinga/res/assets.dart';

class TutorialView {

  final GameController gameController;
  Rect rect;
  Sprite sprite;

  BackButton backButton;

  TutorialView(this.gameController) {
    resize();
    sprite = Sprite(Assets.dialogBgImg);

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
      (gameController.screenSize.width / 2) - (gameController.tileSize * 4),
      (gameController.screenSize.height / 2) - (gameController.tileSize * 6),
      gameController.tileSize * 8,
      gameController.tileSize * 12,
    );

    backButton?.resize();
  }

  void onTapUp(TapUpDetails d) {
    bool isHandled = false;

    // Back Button
    if (!isHandled && backButton.rect.contains(d.globalPosition)) {
      if (gameController.gameState == GameState.CREDITS) {
        backButton.onTapUp();
        isHandled = true;
      }
    }
  }
}