import 'dart:math';
import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:kinga/components/buttons/credits-button.dart';
import 'package:kinga/components/buttons/help-button.dart';
import 'package:kinga/components/buttons/leaderboard-button.dart';
import 'package:kinga/components/buttons/start-button.dart';
import 'package:kinga/components/text/copyright-display.dart';
import 'package:kinga/components/text/highscore_display.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/game_state.dart';
import 'package:kinga/res/assets.dart';

class HomeView {

  final GameController gameController;
  Rect titleRect;

  Offset titleRectOriginalPosition;
  bool isHoveringDown = true;

  Random rand;

  //Sprite titleSprite;
  List<Sprite> titleSprite;
  double flyingSpriteIndex = 0;

  double speed;

  HighScoreDisplay highScoreDisplay;

  StartButton startButton;
  HelpButton helpButton;
  CreditsButton creditsButton;
  LeaderBoardButton leaderBoardButton;

  CopyrightDisplay copyrightDisplay;

  HomeView(this.gameController) {
    resize();
    rand = gameController.rand;
    //titleSprite = Sprite(Assets.enemyAgileFly1);
    titleSprite = List<Sprite>();
    titleFly();

    speed = gameController.tileSize * 1;

    highScoreDisplay = HighScoreDisplay(gameController);
    copyrightDisplay = CopyrightDisplay(gameController);

    startButton = StartButton(gameController);
    helpButton = HelpButton(gameController);
    creditsButton = CreditsButton(gameController);
    leaderBoardButton = LeaderBoardButton(gameController);
  }

  void render(Canvas c) {
    //titleSprite.renderRect(c, titleRect);
    titleSprite[flyingSpriteIndex.toInt()].renderRect(c, titleRect.inflate(titleRect.width / 2));

    // Menu
    startButton.render(c);
    highScoreDisplay.render(c);
    helpButton.render(c);
    creditsButton.render(c);
    leaderBoardButton.render(c);
    copyrightDisplay.render(c);
  }

  void update(double t) {
    // Flap the wings
    flyingSpriteIndex += 30 * t;
    while (flyingSpriteIndex >= 2) {
      flyingSpriteIndex -= 2;
    }

    // Move the fly (Hover)

    // Menu
    startButton.update(t);
    highScoreDisplay.update(t);
    copyrightDisplay.update(t);
  }

  void resize() {
    titleRect = Rect.fromLTWH(
      (gameController.screenSize.width / 2) - (gameController.tileSize * 2),
      (gameController.screenSize.height / 2) - (gameController.tileSize * 6),
      gameController.tileSize * 3.5,
      gameController.tileSize * 3.5,
    );
    titleRectOriginalPosition = titleRect.center;

    // Menu
    startButton?.resize();
    helpButton?.resize();
    creditsButton?.resize();
    leaderBoardButton?.resize();
  }

  /*void onTapDown(TapDownDetails d) {
    bool isHandled = false;

    // Start Button
    if (!isHandled && startButton.rect.contains(d.globalPosition)) {
      if (gameController.gameState == GameState.MENU) {
        startButton.onTapDown();
        isHandled = true;
      }
    }

    // Help Button
    if (!isHandled && helpButton.rect.contains(d.globalPosition)) {
      if (gameController.gameState == GameState.MENU) {
        helpButton.onTapDown();
        isHandled = true;
      }
    }

    // Credits Button
    if (!isHandled && creditsButton.rect.contains(d.globalPosition)) {
      if (gameController.gameState == GameState.MENU) {
        creditsButton.onTapDown();
        isHandled = true;
      }
    }

    // LeaderBoard Button
    if (!isHandled && leaderBoardButton.rect.contains(d.globalPosition)) {
      if (gameController.gameState == GameState.MENU) {
        leaderBoardButton.onTapDown();
        isHandled = true;
      }
    }

    // Dialog Boxes
    *//*if (!isHandled) {
      if (gameController.gameState == GameState.HELP || gameController.gameState == GameState.CREDITS) {
        //gameController.gameState = GameState.MENU;
        isHandled = true;
      }
    }*//*
  }*/

  void onTapUp(TapUpDetails d) {
    bool isHandled = false;

    // Start Button
    if (!isHandled && startButton.rect.contains(d.globalPosition)) {
      if (gameController.gameState == GameState.MENU) {
        startButton.onTapUp();
        isHandled = true;
      }
    }

    // Help Button
    if (!isHandled && helpButton.rect.contains(d.globalPosition)) {
      if (gameController.gameState == GameState.MENU) {
        helpButton.onTapUp();
        isHandled = true;
      }
    }

    // Credits Button
    if (!isHandled && creditsButton.rect.contains(d.globalPosition)) {
      if (gameController.gameState == GameState.MENU) {
        creditsButton.onTapUp();
        isHandled = true;
      }
    }

    // LeaderBoard Button
    if (!isHandled && leaderBoardButton.rect.contains(d.globalPosition)) {
      if (gameController.gameState == GameState.MENU) {
        leaderBoardButton.onTapUp();
        isHandled = true;
      }
    }
  }

  void titleFly() {
    // Type of enemy spawned
    switch (rand.nextInt(5)) {
      case 0:
        titleSprite.add(Sprite(Assets.enemyAgileFly1));
        titleSprite.add(Sprite(Assets.enemyAgileFly2));
        break;
      case 1:
        titleSprite.add(Sprite(Assets.enemyDroolerFly1));
        titleSprite.add(Sprite(Assets.enemyDroolerFly2));
        break;
      case 2:
        titleSprite.add(Sprite(Assets.enemyHouseFly1));
        titleSprite.add(Sprite(Assets.enemyHouseFly2));
        break;
      case 3:
        titleSprite.add(Sprite(Assets.enemyHungryFly1));
        titleSprite.add(Sprite(Assets.enemyHungryFly2));
        break;
      case 4:
        titleSprite.add(Sprite(Assets.enemyMachoFly1));
        titleSprite.add(Sprite(Assets.enemyMachoFly2));
        break;
    }
  }
}