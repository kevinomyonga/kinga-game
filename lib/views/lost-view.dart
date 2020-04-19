import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flutter/widgets.dart';
import 'package:kinga/components/buttons/menu-button.dart';
import 'package:kinga/components/dialog-backdrop.dart';
import 'package:kinga/components/text/best_score_display.dart';
import 'package:kinga/components/text/game-over-display.dart';
import 'package:kinga/components/text/new-highscore-display.dart';
import 'package:kinga/components/text/your_score_display.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/helpers/game_state.dart';
import 'package:kinga/res/assets.dart';

class LostView {

  final GameController gameController;

  DialogBackdrop dialogBackdrop;

  GameOverDisplay gameOverDisplay;
  YourScoreDisplay yourScoreDisplay;
  BestScoreDisplay bestScoreDisplay;
  NewHighScoreDisplay newHighScoreDisplay;

  MenuButton menuButton;

  LostView(this.gameController) {
    resize();
    dialogBackdrop = DialogBackdrop(gameController);

    gameOverDisplay = GameOverDisplay(gameController);
    yourScoreDisplay = YourScoreDisplay(gameController);
    bestScoreDisplay = BestScoreDisplay(gameController);
    newHighScoreDisplay = NewHighScoreDisplay(gameController);
    menuButton = MenuButton(gameController);
  }

  void render(Canvas c) {
    dialogBackdrop.render(c);

    gameOverDisplay.render(c);
    yourScoreDisplay.render(c);
    bestScoreDisplay.render(c);
    if(gameController.isNewHighScore) newHighScoreDisplay.render(c);
    menuButton.render(c);
  }

  void update(double t) {
    dialogBackdrop.update(t);

    gameOverDisplay.update(t);
    yourScoreDisplay.update(t);
    bestScoreDisplay.update(t);
    newHighScoreDisplay.update(t);
  }

  void resize() {
    dialogBackdrop?.resize();

    newHighScoreDisplay?.resize();
    menuButton?.resize();
  }

  void onTapUp(TapUpDetails d) {

    // Back Button
    if (!gameController.isHandled && menuButton.rect.contains(d.globalPosition)) {
      if (gameController.gameState == GameState.CREDITS || gameController.gameState == GameState.GAME_OVER) {
        menuButton.onTapUp();
        gameController.isHandled = true;
      }
    }
  }
}