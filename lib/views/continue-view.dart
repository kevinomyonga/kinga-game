import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/widgets.dart';
import 'package:kinga/components/buttons/back-button.dart';
import 'package:kinga/components/buttons/show-ad-button.dart';
import 'package:kinga/components/player.dart';
import 'package:kinga/components/text/continue-display.dart';
import 'package:kinga/components/text/credits-display.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/game_state.dart';
import 'package:kinga/res/assets.dart';

class ContinueView {

  final GameController gameController;
  Rect rect;
  Sprite sprite;

  ContinueDisplay continueDisplay;

  ShowAdButton showAdButton;
  BackButton backButton;

  ContinueView(this.gameController) {
    resize();
    sprite = Sprite(Assets.dialogBgImg);

    continueDisplay = ContinueDisplay(gameController);
    showAdButton = ShowAdButton(gameController);
    backButton = BackButton(gameController);
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);

    continueDisplay.render(c);
    showAdButton.render(c);
    backButton.render(c);
  }

  void update(double t) {
    continueDisplay.update(t);
  }

  void resize() {
    rect = Rect.fromLTWH(
      (gameController.screenSize.width / 2) - (gameController.tileSize * 4),
      (gameController.screenSize.height / 2) - (gameController.tileSize * 6),
      gameController.tileSize * 8,
      gameController.tileSize * 12,
    );

    showAdButton?.resize();
    backButton?.resize();
  }

  void onTapUp(TapUpDetails d) {
    bool isHandled = false;

    // Show Ad Button
    if (!isHandled && showAdButton.rect.contains(d.globalPosition)) {
      if (gameController.gameState == GameState.CONTINUE) {
        showAdButton.onTapUp();
        isHandled = true;
      }
    }

    // Back Button
    if (!isHandled && backButton.rect.contains(d.globalPosition)) {
      if (gameController.gameState == GameState.CONTINUE) {
        backButton.onTapUp();
        isHandled = true;
      }
    }
  }

  void resumeGame() {
    gameController.gameState = GameState.PLAYING;

    // Kill all enemies to clear the screen
    gameController.enemySpawner.killAllEnemies();

    // Resurrect Player
    gameController.playView.player = Player(gameController);
  }

  void endGame() {
    // End game
    gameController.gameState = GameState.GAME_OVER;

    // Reset game
    gameController.initialize();
    if (gameController.soundButton.isEnabled) {
      Flame.audio.play(Assets.enemyHaha);
    }
  }
}