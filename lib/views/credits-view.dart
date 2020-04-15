import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flutter/widgets.dart';
import 'package:kinga/components/buttons/back-button.dart';
import 'package:kinga/components/text/credits-display.dart';
import 'package:kinga/components/text/credits-title-display.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/game_state.dart';
import 'package:kinga/res/assets.dart';

class CreditsView {

  final GameController gameController;
  Rect rect;
  Sprite sprite;

  CreditsDisplay creditsDisplay;
  CreditsTitleDisplay creditsTitleDisplay;

  BackButton backButton;

  CreditsView(this.gameController) {
    resize();
    sprite = Sprite(Assets.dialogBgImg);

    creditsDisplay = CreditsDisplay(gameController);
    creditsTitleDisplay = CreditsTitleDisplay(gameController);
    backButton = BackButton(gameController);
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);

    creditsDisplay.render(c);
    creditsTitleDisplay.render(c);
    backButton.render(c);
  }

  void update(double t) {
    creditsDisplay.update(t);
    creditsTitleDisplay.update(t);
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