import 'dart:io';
import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:kinga/components/backdrops/dialog-backdrop.dart';
import 'package:kinga/components/buttons/menu-button.dart';
import 'package:kinga/components/buttons/tutorial-demo-button.dart';
import 'package:kinga/components/text/tutorial-display.dart';
import 'package:kinga/components/text/tutorial-info-display.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/helpers/game_state.dart';

class TutorialView {

  final GameController gameController;

  DialogBackdrop dialogBackdrop;

  TutorialDisplay tutorialDisplay;
  TutorialInfoDisplay tutorialInfoDisplay;

  TutorialDemoButton tutorialDemoButton;
  MenuButton menuButton;

  TutorialView(this.gameController) {
    resize();
    dialogBackdrop = DialogBackdrop(gameController);

    tutorialDisplay = TutorialDisplay(gameController);
    tutorialInfoDisplay = TutorialInfoDisplay(gameController);
    tutorialDemoButton = TutorialDemoButton(gameController);
    menuButton = MenuButton(gameController);
  }

  void render(Canvas c) {
    dialogBackdrop.render(c);

    tutorialDisplay.render(c);
    tutorialInfoDisplay.render(c);

    if(Platform.isAndroid) tutorialDemoButton.render(c);
    menuButton.render(c);
  }

  void update(double t) {
    dialogBackdrop.update(t);

    tutorialDisplay.update(t);
    tutorialInfoDisplay.update(t);

    tutorialDemoButton.update(t);
  }

  void resize() {
    dialogBackdrop?.resize();
    tutorialDemoButton?.resize();
    menuButton?.resize();
  }

  void onTapUp(TapUpDetails d) {

    // Demo Button
    if (!gameController.isHandled && tutorialDemoButton.rect.contains(d.globalPosition)) {
      if (gameController.gameState == GameState.HELP) {
        tutorialDemoButton.onTapUp();
        gameController.isHandled = true;
      }
    }

    // Back Button
    if (!gameController.isHandled && menuButton.rect.contains(d.globalPosition)) {
      if (gameController.gameState == GameState.HELP) {
        menuButton.onTapUp();
        gameController.isHandled = true;
      }
    }
  }
}