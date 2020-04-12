import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flutter/widgets.dart';
import 'package:kinga/components/buttons/home-button.dart';
import 'package:kinga/components/buttons/play-button.dart';
import 'package:kinga/components/buttons/reload-button.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/game_state.dart';
import 'package:kinga/res/assets.dart';

class PauseView {

  final GameController gameController;
  Rect rect;
  Sprite sprite;

  PlayButton playButton;
  ReloadButton reloadButton;
  HomeButton homeButton;

  PauseView(this.gameController) {
    resize();
    sprite = Sprite(Assets.dialogBgImg);

    playButton = PlayButton(gameController);
    reloadButton = ReloadButton(gameController);
    homeButton = HomeButton(gameController);
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);

    playButton.render(c);
    reloadButton.render(c);
    homeButton.render(c);
  }

  void update(double t) {
  }

  void resize() {
    rect = Rect.fromLTWH(
      (gameController.screenSize.width / 2) - (gameController.tileSize * 4),
      (gameController.screenSize.height / 2) - (gameController.tileSize * 6),
      gameController.tileSize * 8,
      gameController.tileSize * 12,
    );

    playButton?.resize();
    reloadButton?.resize();
    homeButton?.resize();
  }

  void onTapDown(TapDownDetails d) {
    bool isHandled = false;

    // Play/Resume Button
    if (!isHandled && playButton.rect.contains(d.globalPosition)) {
      if (gameController.gameState == GameState.PAUSED) {
        playButton.onTapDown();
        isHandled = true;
      }
    }

    // Reload Button
    if (!isHandled && reloadButton.rect.contains(d.globalPosition)) {
      if (gameController.gameState == GameState.PAUSED) {
        reloadButton.onTapDown();
        isHandled = true;
      }
    }

    // Back Button
    if (!isHandled && homeButton.rect.contains(d.globalPosition)) {
      if (gameController.gameState == GameState.PAUSED) {
        homeButton.onTapDown();
        isHandled = true;
      }
    }
  }
}