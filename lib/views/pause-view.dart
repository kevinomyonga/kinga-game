import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:kinga/components/backdrops/dialog-backdrop.dart';
import 'package:kinga/components/buttons/home-button.dart';
import 'package:kinga/components/buttons/restart-button.dart';
import 'package:kinga/components/buttons/resume-button.dart';
import 'package:kinga/components/text/pause-display.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/helpers/game_state.dart';

class PauseView {

  final GameController gameController;

  DialogBackdrop dialogBackdrop;

  PauseDisplay pauseDisplay;

  ResumeButton resumeButton;
  RestartButton restartButton;
  HomeButton homeButton;

  PauseView(this.gameController) {
    resize();
    dialogBackdrop = DialogBackdrop(gameController);

    pauseDisplay = PauseDisplay(gameController);

    resumeButton = ResumeButton(gameController);
    restartButton = RestartButton(gameController);
    homeButton = HomeButton(gameController);
  }

  void render(Canvas c) {
    dialogBackdrop.render(c);

    pauseDisplay.render(c);
    resumeButton.render(c);
    restartButton.render(c);
    homeButton.render(c);
  }

  void update(double t) {
    dialogBackdrop.update(t);

    pauseDisplay.update(t);
    resumeButton.update(t);
    restartButton.update(t);
    homeButton.update(t);
  }

  void resize() {
    dialogBackdrop?.resize();

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