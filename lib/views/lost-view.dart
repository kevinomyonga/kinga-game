import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flutter/widgets.dart';
import 'package:kinga/components/buttons/menu-button.dart';
import 'package:kinga/components/text/best_score_display.dart';
import 'package:kinga/components/text/game-over-display.dart';
import 'package:kinga/components/text/new-highscore-display.dart';
import 'package:kinga/components/text/your_score_display.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/game_state.dart';
import 'package:kinga/res/assets.dart';

class LostView {

  final GameController gameController;
  Rect rect;
  Sprite sprite;

  GameOverDisplay gameOverDisplay;
  YourScoreDisplay yourScoreDisplay;
  BestScoreDisplay bestScoreDisplay;
  NewHighScoreDisplay newHighScoreDisplay;

  MenuButton menuButton;

  LostView(this.gameController) {
    resize();
    sprite = Sprite(Assets.dialogBgImg);

    gameOverDisplay = GameOverDisplay(gameController);
    yourScoreDisplay = YourScoreDisplay(gameController);
    bestScoreDisplay = BestScoreDisplay(gameController);
    newHighScoreDisplay = NewHighScoreDisplay(gameController);
    menuButton = MenuButton(gameController);
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);

    gameOverDisplay.render(c);
    yourScoreDisplay.render(c);
    bestScoreDisplay.render(c);
    if(gameController.isNewHighScore) newHighScoreDisplay.render(c);
    menuButton.render(c);
  }

  void update(double t) {
    gameOverDisplay.update(t);
    yourScoreDisplay.update(t);
    bestScoreDisplay.update(t);
    newHighScoreDisplay.update(t);
  }

  void resize() {
    rect = Rect.fromLTWH(
      (gameController.screenSize.width / 2) - (gameController.tileSize * 4),
      (gameController.screenSize.height / 2) - (gameController.tileSize * 6),
      gameController.tileSize * 8,
      gameController.tileSize * 12,
    );

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