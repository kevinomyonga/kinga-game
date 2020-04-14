import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flutter/widgets.dart';
import 'package:kinga/components/buttons/back-button.dart';
import 'package:kinga/components/text/best_score_display.dart';
import 'package:kinga/components/text/game-over-display.dart';
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

  BackButton backButton;

  LostView(this.gameController) {
    resize();
    sprite = Sprite(Assets.dialogBgImg);

    gameOverDisplay = GameOverDisplay(gameController);
    yourScoreDisplay = YourScoreDisplay(gameController);
    bestScoreDisplay = BestScoreDisplay(gameController);
    backButton = BackButton(gameController);
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);

    gameOverDisplay.render(c);
    yourScoreDisplay.render(c);
    bestScoreDisplay.render(c);
    backButton.render(c);
  }

  void update(double t) {
    gameOverDisplay.update(t);
    yourScoreDisplay.update(t);
    bestScoreDisplay.update(t);
  }

  void resize() {
    rect = Rect.fromLTWH(
      (gameController.screenSize.width / 2) - (gameController.tileSize * 4),
      (gameController.screenSize.height / 2) - (gameController.tileSize * 6),
      gameController.tileSize * 8,
      gameController.tileSize * 12,
    );

    bestScoreDisplay?.resize();
    backButton?.resize();
  }

  void onTapUp(TapUpDetails d) {
    bool isHandled = false;

    // Back Button
    if (!isHandled && backButton.rect.contains(d.globalPosition)) {
      if (gameController.gameState == GameState.CREDITS || gameController.gameState == GameState.GAME_OVER) {
        backButton.onTapUp();
        isHandled = true;
      }
    }
  }
}