import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flutter/widgets.dart';
import 'package:kinga/components/buttons/home-button.dart';
import 'package:kinga/components/buttons/resume-button.dart';
import 'package:kinga/components/buttons/restart-button.dart';
import 'package:kinga/components/text/pause-display.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/game_state.dart';
import 'package:kinga/res/assets.dart';

class PauseView {

  final GameController gameController;
  Rect rect;
  Sprite sprite;

  PauseDisplay pauseDisplay;

  ResumeButton resumeButton;
  RestartButton restartButton;
  HomeButton homeButton;

  PauseView(this.gameController) {
    resize();
    sprite = Sprite(Assets.dialogBgImg);

    pauseDisplay = PauseDisplay(gameController);

    resumeButton = ResumeButton(gameController);
    restartButton = RestartButton(gameController);
    homeButton = HomeButton(gameController);
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);

    pauseDisplay.render(c);
    resumeButton.render(c);
    restartButton.render(c);
    homeButton.render(c);
  }

  void update(double t) {
    pauseDisplay.update(t);
    resumeButton.update(t);
    restartButton.update(t);
    homeButton.update(t);
  }

  void resize() {
    rect = Rect.fromLTWH(
      (gameController.screenSize.width / 2) - (gameController.tileSize * 4),
      (gameController.screenSize.height / 2) - (gameController.tileSize * 6),
      gameController.tileSize * 8,
      gameController.tileSize * 12,
    );

    resumeButton?.resize();
    restartButton?.resize();
    homeButton?.resize();
  }

  void onTapUp(TapUpDetails d) {

    // Play/Resume Button
    if (!gameController.isHandled && resumeButton.rect.contains(d.globalPosition)) {
      if (gameController.gameState == GameState.PAUSED) {
        resumeButton.onTapUp();
        gameController.isHandled = true;
      }
    }

    // Reload Button
    if (!gameController.isHandled && restartButton.rect.contains(d.globalPosition)) {
      if (gameController.gameState == GameState.PAUSED) {
        restartButton.onTapUp();
        gameController.isHandled = true;
      }
    }

    // Back Button
    if (!gameController.isHandled && homeButton.rect.contains(d.globalPosition)) {
      if (gameController.gameState == GameState.PAUSED) {
        homeButton.onTapUp();
        gameController.isHandled = true;
      }
    }
  }
}