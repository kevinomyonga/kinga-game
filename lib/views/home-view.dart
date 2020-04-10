import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:kinga/components/buttons/credits-button.dart';
import 'package:kinga/components/buttons/help-button.dart';
import 'package:kinga/components/buttons/start-button.dart';
import 'package:kinga/components/highscore_display.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/game_state.dart';
import 'package:kinga/res/assets.dart';

class HomeView {

  final GameController gameController;
  Rect titleRect;
  //Sprite titleSprite;
  List<Sprite> titleSprite;
  double flyingSpriteIndex = 0;

  HighScoreDisplay highScoreDisplay;

  StartButton startButton;
  HelpButton helpButton;
  CreditsButton creditsButton;

  HomeView(this.gameController) {
    resize();
    //titleSprite = Sprite(Assets.enemyAgileFly1);
    titleSprite = List<Sprite>();
    titleSprite.add(Sprite(Assets.enemyAgileFly1));
    titleSprite.add(Sprite(Assets.enemyAgileFly2));

    highScoreDisplay = HighScoreDisplay(gameController);

    startButton = StartButton(gameController);
    helpButton = HelpButton(gameController);
    creditsButton = CreditsButton(gameController);
  }

  void render(Canvas c) {
    //titleSprite.renderRect(c, titleRect);
    titleSprite[flyingSpriteIndex.toInt()].renderRect(c, titleRect.inflate(titleRect.width / 2));

    // Menu Buttons
    startButton.render(c);
    highScoreDisplay.render(c);
    helpButton.render(c);
    creditsButton.render(c);
  }

  void update(double t) {
    // Flap the wings
    flyingSpriteIndex += 30 * t;
    while (flyingSpriteIndex >= 2) {
      flyingSpriteIndex -= 2;
    }

    // Menu
    startButton.update(t);
    highScoreDisplay.update(t);
  }

  void resize() {
    titleRect = Rect.fromLTWH(
      (gameController.screenSize.width / 2) - (gameController.tileSize * 2.5),
      (gameController.screenSize.height / 2) - (gameController.tileSize * 4),
      gameController.tileSize * 3.5,
      gameController.tileSize * 3.5,
    );

    // Menu
    startButton?.resize();
    helpButton?.resize();
    creditsButton?.resize();
  }

  void onTapDown(TapDownDetails d) {
    bool isHandled = false;

    // Start Button
    if (!isHandled && startButton.rect.contains(d.globalPosition)) {
      if (gameController.gameState == GameState.MENU) {
        startButton.onTapDown();
        isHandled = true;
      }
    }

    // Help button
    if (!isHandled && helpButton.rect.contains(d.globalPosition)) {
      if (gameController.gameState == GameState.MENU || gameController.gameState == GameState.GAME_OVER) {
        helpButton.onTapDown();
        isHandled = true;
      }
    }

    // Credits button
    if (!isHandled && creditsButton.rect.contains(d.globalPosition)) {
      if (gameController.gameState == GameState.MENU || gameController.gameState == GameState.GAME_OVER) {
        creditsButton.onTapDown();
        isHandled = true;
      }
    }

    // Dialog boxes
    if (!isHandled) {
      if (gameController.gameState == GameState.HELP || gameController.gameState == GameState.CREDITS) {
        gameController.gameState = GameState.MENU;
        isHandled = true;
      }
    }
  }
}