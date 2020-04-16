import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flutter/widgets.dart';
import 'package:kinga/components/buttons/menu-button.dart';
import 'package:kinga/components/buttons/tutorial-demo-button.dart';
import 'package:kinga/components/text/tutorial-display.dart';
import 'package:kinga/components/text/tutorial-info-display.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/game_state.dart';
import 'package:kinga/res/assets.dart';

class TutorialView {

  final GameController gameController;
  Rect rect;
  Sprite sprite;

  TutorialDisplay tutorialDisplay;
  TutorialInfoDisplay tutorialInfoDisplay;

  TutorialDemoButton tutorialDemoButton;
  MenuButton menuButton;

  TutorialView(this.gameController) {
    resize();
    sprite = Sprite(Assets.dialogBgImg);

    tutorialDisplay = TutorialDisplay(gameController);
    tutorialInfoDisplay = TutorialInfoDisplay(gameController);
    tutorialDemoButton = TutorialDemoButton(gameController);
    menuButton = MenuButton(gameController);
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);

    tutorialDisplay.render(c);
    tutorialInfoDisplay.render(c);

    tutorialDemoButton.render(c);
    menuButton.render(c);
  }

  void update(double t) {
    tutorialDisplay.update(t);
    tutorialInfoDisplay.update(t);

    tutorialDemoButton.update(t);
  }

  void resize() {
    rect = Rect.fromLTWH(
      (gameController.screenSize.width / 2) - (gameController.tileSize * 4),
      (gameController.screenSize.height / 2) - (gameController.tileSize * 6),
      gameController.tileSize * 8,
      gameController.tileSize * 12,
    );

    tutorialDemoButton?.resize();
    menuButton?.resize();
  }

  void onTapUp(TapUpDetails d) {
    bool isHandled = false;

    // Demo Button
    if (!isHandled && tutorialDemoButton.rect.contains(d.globalPosition)) {
      if (gameController.gameState == GameState.HELP) {
        tutorialDemoButton.onTapUp();
        isHandled = true;
      }
    }

    // Back Button
    if (!isHandled && menuButton.rect.contains(d.globalPosition)) {
      if (gameController.gameState == GameState.HELP) {
        menuButton.onTapUp();
        isHandled = true;
      }
    }
  }
}