import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/widgets.dart';
import 'package:kinga/components/buttons/no-thanks-button.dart';
import 'package:kinga/components/buttons/show-ad-button.dart';
import 'package:kinga/components/player.dart';
import 'package:kinga/components/text/continue-display.dart';
import 'package:kinga/components/text/continues-left-display.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/game_state.dart';
import 'package:kinga/res/assets.dart';

class ContinueView {

  final GameController gameController;
  Rect rect;
  Sprite sprite;

  int continuesLeft;

  ContinueDisplay continueDisplay;
  ContinuesLeftDisplay continuesLeftDisplay;

  ShowAdButton showAdButton;
  NoThanksButton noThanksButton;

  ContinueView(this.gameController) {
    resize();
    sprite = Sprite(Assets.dialogBgImg);

    continuesLeft = 3;

    continueDisplay = ContinueDisplay(gameController);
    continuesLeftDisplay = ContinuesLeftDisplay(gameController);
    showAdButton = ShowAdButton(gameController);
    noThanksButton = NoThanksButton(gameController);
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);

    continueDisplay.render(c);
    continuesLeftDisplay.render(c);
    showAdButton.render(c);
    noThanksButton.render(c);
  }

  void update(double t) {
    continueDisplay.update(t);
    continuesLeftDisplay.update(t);
    showAdButton.update(t);
    noThanksButton.update(t);
  }

  void resize() {
    rect = Rect.fromLTWH(
      (gameController.screenSize.width / 2) - (gameController.tileSize * 4),
      (gameController.screenSize.height / 2) - (gameController.tileSize * 6),
      gameController.tileSize * 8,
      gameController.tileSize * 12,
    );

    showAdButton?.resize();
    noThanksButton?.resize();
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

    // No Thanks Button
    if (!isHandled && noThanksButton.rect.contains(d.globalPosition)) {
      if (gameController.gameState == GameState.CONTINUE) {
        noThanksButton.onTapUp();
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

    // Deduct from continues
    gameController.continueView.continuesLeft--;
  }
}