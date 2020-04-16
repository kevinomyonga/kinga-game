import 'dart:math';
import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:kinga/components/buttons/about-button.dart';
import 'package:kinga/components/buttons/help-button.dart';
import 'package:kinga/components/buttons/leaderboard-button.dart';
import 'package:kinga/components/buttons/start-button.dart';
import 'package:kinga/components/text/copyright-display.dart';
import 'package:kinga/components/text/highscore_display.dart';
import 'package:kinga/components/text/title-display.dart';
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
  TitleDisplay titleDisplay;

  StartButton startButton;
  LeaderBoardButton leaderBoardButton;
  AboutButton aboutButton;
  HelpButton helpButton;

  CopyrightDisplay copyrightDisplay;

  HomeView(this.gameController) {
    resize();
    rand = gameController.rand;
    //titleSprite = Sprite(Assets.enemyAgileFly1);
    titleSprite = List<Sprite>();
    titleFly();

    speed = gameController.tileSize * 1;

    highScoreDisplay = HighScoreDisplay(gameController);
    titleDisplay = TitleDisplay(gameController);
    copyrightDisplay = CopyrightDisplay(gameController);

    startButton = StartButton(gameController);
    leaderBoardButton = LeaderBoardButton(gameController);
    aboutButton = AboutButton(gameController);
    helpButton = HelpButton(gameController);
  }

  void render(Canvas c) {
    //titleSprite.renderRect(c, titleRect);
    titleSprite[flyingSpriteIndex.toInt()].renderRect(c, titleRect.inflate(titleRect.width / 2));

    // Menu
    highScoreDisplay.render(c);
    titleDisplay.render(c);
    startButton.render(c);
    leaderBoardButton.render(c);
    aboutButton.render(c);
    helpButton.render(c);
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
    highScoreDisplay.update(t);
    titleDisplay.update(t);
    startButton.update(t);
    leaderBoardButton.update(t);
    aboutButton.update(t);
    copyrightDisplay.update(t);
  }

  void resize() {
    titleRect = Rect.fromLTWH(
      (gameController.screenSize.width / 2) - (gameController.tileSize * 2.25),
      (gameController.screenSize.height / 2) - (gameController.tileSize * 6),
      gameController.tileSize * 3.5,
      gameController.tileSize * 3.5,
    );
    titleRectOriginalPosition = titleRect.center;

    // Menu
    startButton?.resize();
    leaderBoardButton?.resize();
    aboutButton?.resize();
    helpButton?.resize();
  }

  void onTapUp(TapUpDetails d) {
    bool isHandled = gameController.isHandled;

    // Start Button
    if (!isHandled && startButton.rect.contains(d.globalPosition)) {
      if (gameController.gameState == GameState.MENU) {
        startButton.onTapUp();
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

    // About Button
    if (!isHandled && aboutButton.rect.contains(d.globalPosition)) {
      if (gameController.gameState == GameState.MENU) {
        aboutButton.onTapUp();
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
  }

  void titleFly() {
    // Type of enemy spawned for the title view
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