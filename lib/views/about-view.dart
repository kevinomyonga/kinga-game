import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:kinga/components/buttons/credits-button.dart';
import 'package:kinga/components/buttons/feedback-button.dart';
import 'package:kinga/components/buttons/menu-button.dart';
import 'package:kinga/components/dialog-backdrop.dart';
import 'package:kinga/components/text/about-copyright-display.dart';
import 'package:kinga/components/text/about-display.dart';
import 'package:kinga/components/text/version-display.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/helpers/game_state.dart';

class AboutView {

  final GameController gameController;

  DialogBackdrop dialogBackdrop;

  AboutDisplay aboutDisplay;
  VersionDisplay versionDisplay;
  AboutCopyrightDisplay aboutCopyrightDisplay;

  FeedbackButton feedbackButton;
  CreditsButton creditsButton;
  MenuButton menuButton;

  AboutView(this.gameController) {
    resize();
    dialogBackdrop = DialogBackdrop(gameController);

    aboutDisplay = AboutDisplay(gameController);
    versionDisplay = VersionDisplay(gameController);
    aboutCopyrightDisplay = AboutCopyrightDisplay(gameController);

    feedbackButton = FeedbackButton(gameController);
    creditsButton = CreditsButton(gameController);
    menuButton = MenuButton(gameController);
  }

  void render(Canvas c) {
    dialogBackdrop.render(c);

    aboutDisplay.render(c);
    versionDisplay.render(c);
    aboutCopyrightDisplay.render(c);
    feedbackButton.render(c);
    creditsButton.render(c);
    menuButton.render(c);
  }

  void update(double t) {
    dialogBackdrop.update(t);

    aboutDisplay.update(t);
    versionDisplay.update(t);
    aboutCopyrightDisplay.update(t);

    feedbackButton.update(t);
    creditsButton.update(t);
  }

  void resize() {
    dialogBackdrop?.resize();

    feedbackButton?.resize();
    creditsButton?.resize();
    menuButton?.resize();
  }

  void onTapUp(TapUpDetails d) {

    // FeedBack Button
    if (!gameController.isHandled && feedbackButton.rect.contains(d.globalPosition)) {
      if (gameController.gameState == GameState.ABOUT) {
        feedbackButton.onTapUp();
        gameController.isHandled = true;
      }
    }

    // Credits Button
    if (!gameController.isHandled && creditsButton.rect.contains(d.globalPosition)) {
      if (gameController.gameState == GameState.ABOUT) {
        creditsButton.onTapUp();
        gameController.isHandled = true;
      }
    }

    // Back Button
    if (!gameController.isHandled && menuButton.rect.contains(d.globalPosition)) {
      if (gameController.gameState == GameState.ABOUT) {
        menuButton.onTapUp();
        gameController.isHandled = true;
      }
    }
  }
}