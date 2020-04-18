import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flutter/widgets.dart';
import 'package:kinga/components/buttons/back-button.dart';
import 'package:kinga/components/buttons/developer-website-button.dart';
import 'package:kinga/components/text/credits-display.dart';
import 'package:kinga/components/text/credits-name-display.dart';
import 'package:kinga/components/text/credits-title-display.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/helpers/game_state.dart';
import 'package:kinga/res/assets.dart';

class CreditsView {

  final GameController gameController;
  Rect rect;
  Sprite sprite;

  CreditsDisplay creditsDisplay;
  CreditsNameDisplay creditsNameDisplay;
  CreditsTitleDisplay creditsTitleDisplay;

  DeveloperWebsiteButton developerWebsiteButton;
  BackButton backButton;

  CreditsView(this.gameController) {
    resize();
    sprite = Sprite(Assets.dialogBgImg);

    creditsDisplay = CreditsDisplay(gameController);
    creditsNameDisplay = CreditsNameDisplay(gameController);
    creditsTitleDisplay = CreditsTitleDisplay(gameController);

    developerWebsiteButton = DeveloperWebsiteButton(gameController);
    backButton = BackButton(gameController);
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);

    creditsDisplay.render(c);
    creditsNameDisplay.render(c);
    creditsTitleDisplay.render(c);

    developerWebsiteButton.render(c);
    backButton.render(c);
  }

  void update(double t) {
    creditsDisplay.update(t);
    creditsNameDisplay.update(t);
    creditsTitleDisplay.update(t);

    developerWebsiteButton.update(t);
  }

  void resize() {
    rect = Rect.fromLTWH(
      (gameController.screenSize.width / 2) - (gameController.tileSize * 4),
      (gameController.screenSize.height / 2) - (gameController.tileSize * 6),
      gameController.tileSize * 8,
      gameController.tileSize * 12,
    );

    developerWebsiteButton?.resize();
    backButton?.resize();
  }

  void onTapUp(TapUpDetails d) {

    // Developer's Website Button
    if (!gameController.isHandled && developerWebsiteButton.rect.contains(d.globalPosition)) {
      if (gameController.gameState == GameState.CREDITS) {
        developerWebsiteButton.onTapUp();
        gameController.isHandled = true;
      }
    }

    // Back Button
    if (!gameController.isHandled && backButton.rect.contains(d.globalPosition)) {
      if (gameController.gameState == GameState.CREDITS) {
        backButton.onTapUp();
        gameController.isHandled = true;
      }
    }
  }
}