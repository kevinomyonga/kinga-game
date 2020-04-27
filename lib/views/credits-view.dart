import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:kinga/components/backdrops/dialog-backdrop.dart';
import 'package:kinga/components/buttons/back-button.dart';
import 'package:kinga/components/buttons/developer-website-button.dart';
import 'package:kinga/components/text/credits-display.dart';
import 'package:kinga/components/text/credits-name-display.dart';
import 'package:kinga/components/text/credits-title-display.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/helpers/game_state.dart';

class CreditsView {

  final GameController gameController;

  DialogBackdrop dialogBackdrop;

  CreditsDisplay creditsDisplay;
  CreditsNameDisplay creditsNameDisplay;
  CreditsTitleDisplay creditsTitleDisplay;

  DeveloperWebsiteButton developerWebsiteButton;
  BackButton backButton;

  CreditsView(this.gameController) {
    resize();
    dialogBackdrop = DialogBackdrop(gameController);

    creditsDisplay = CreditsDisplay(gameController);
    creditsNameDisplay = CreditsNameDisplay(gameController);
    creditsTitleDisplay = CreditsTitleDisplay(gameController);

    developerWebsiteButton = DeveloperWebsiteButton(gameController);
    backButton = BackButton(gameController);
  }

  void render(Canvas c) {
    dialogBackdrop.render(c);

    creditsDisplay.render(c);
    creditsNameDisplay.render(c);
    creditsTitleDisplay.render(c);

    developerWebsiteButton.render(c);
    backButton.render(c);
  }

  void update(double t) {
    dialogBackdrop.update(t);

    creditsDisplay.update(t);
    creditsNameDisplay.update(t);
    creditsTitleDisplay.update(t);

    developerWebsiteButton.update(t);
  }

  void resize() {
    dialogBackdrop?.resize();

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