import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flutter/widgets.dart';
import 'package:kinga/components/buttons/menu-button.dart';
import 'package:kinga/components/buttons/credits-button.dart';
import 'package:kinga/components/buttons/feedback-button.dart';
import 'package:kinga/components/text/about-copyright-display.dart';
import 'package:kinga/components/text/about-display.dart';
import 'package:kinga/components/text/version-display.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/game_state.dart';
import 'package:kinga/res/assets.dart';

class AboutView {

  final GameController gameController;
  Rect rect;
  Sprite sprite;

  AboutDisplay aboutDisplay;
  VersionDisplay versionDisplay;
  AboutCopyrightDisplay aboutCopyrightDisplay;

  FeedbackButton feedbackButton;
  CreditsButton creditsButton;
  MenuButton menuButton;

  AboutView(this.gameController) {
    resize();
    sprite = Sprite(Assets.dialogBgImg);

    aboutDisplay = AboutDisplay(gameController);
    versionDisplay = VersionDisplay(gameController);
    aboutCopyrightDisplay = AboutCopyrightDisplay(gameController);

    feedbackButton = FeedbackButton(gameController);
    creditsButton = CreditsButton(gameController);
    menuButton = MenuButton(gameController);
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);

    aboutDisplay.render(c);
    versionDisplay.render(c);
    aboutCopyrightDisplay.render(c);
    feedbackButton.render(c);
    creditsButton.render(c);
    menuButton.render(c);
  }

  void update(double t) {
    aboutDisplay.update(t);
    versionDisplay.update(t);
    aboutCopyrightDisplay.update(t);

    feedbackButton.update(t);
    creditsButton.update(t);
  }

  void resize() {
    rect = Rect.fromLTWH(
      (gameController.screenSize.width / 2) - (gameController.tileSize * 4),
      (gameController.screenSize.height / 2) - (gameController.tileSize * 6),
      gameController.tileSize * 8,
      gameController.tileSize * 12,
    );

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