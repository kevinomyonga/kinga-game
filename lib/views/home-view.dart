import 'dart:math';
import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:kinga/components/buttons/about-button.dart';
import 'package:kinga/components/buttons/help-button.dart';
import 'package:kinga/components/buttons/leaderboard-button.dart';
import 'package:kinga/components/buttons/play-button.dart';
import 'package:kinga/components/text/copyright-display.dart';
import 'package:kinga/components/text/highscore-display.dart';
import 'package:kinga/components/text/title-display.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/helpers/game_state.dart';
import 'package:kinga/res/assets.dart';

class HomeView {

  final GameController gameController;
  Rect titleRect;

  Offset titleRectOriginalPosition;

  Random rand;

  List<Sprite> titleSprite;
  double flyingSpriteIndex = 0;

  Offset toTop;
  Offset toCenter;
  Offset toBottom;
  bool isHoveringDown = true;

  double speed;

  HighScoreDisplay highScoreDisplay;
  TitleDisplay titleDisplay;

  PlayButton playButton;
  LeaderBoardButton leaderBoardButton;
  AboutButton aboutButton;
  HelpButton helpButton;

  CopyrightDisplay copyrightDisplay;

  HomeView(this.gameController) {
    resize();
    rand = gameController.rand;
    titleSprite = List<Sprite>();
    titleFly();
    
    toTop = titleRect.topCenter;
    toBottom = titleRect.bottomCenter;

    speed = gameController.tileSize * 1;

    highScoreDisplay = HighScoreDisplay(gameController);
    titleDisplay = TitleDisplay(gameController);
    copyrightDisplay = CopyrightDisplay(gameController);

    playButton = PlayButton(gameController);
    leaderBoardButton = LeaderBoardButton(gameController);
    aboutButton = AboutButton(gameController);
    helpButton = HelpButton(gameController);
  }

  void render(Canvas c) {
    titleSprite[flyingSpriteIndex.toInt()].renderRect(c, titleRect.inflate(titleRect.width / 2));

    // Menu
    highScoreDisplay.render(c);
    titleDisplay.render(c);
    playButton.render(c);
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
    double stepDistance = (speed * 0.3) * t;
    Offset toPlayer = toTop - titleRect.center;
    Offset fromPlayer = toBottom - titleRect.center;
    if(isHoveringDown) {
      if (stepDistance <= toPlayer.distance - gameController.tileSize * 0.3) {
        Offset stepToPlayer = Offset.fromDirection(
            toPlayer.direction, stepDistance);
        titleRect = titleRect.shift(stepToPlayer);
      } else {
        isHoveringDown = false;
      }
    } else {
      if (stepDistance <= fromPlayer.distance - gameController.tileSize * 0.3) {
        Offset stepFromPlayer = Offset.fromDirection(
            fromPlayer.direction, stepDistance);
        titleRect = titleRect.shift(stepFromPlayer);
      } else {
        isHoveringDown = true;
      }
    }

    // Menu
    highScoreDisplay.update(t);
    titleDisplay.update(t);
    playButton.update(t);
    leaderBoardButton.update(t);
    aboutButton.update(t);
    copyrightDisplay.update(t);
  }

  void resize() {
    titleRect = Rect.fromLTWH(
      (gameController.screenSize.width / 2) - (gameController.tileSize),
      (gameController.screenSize.height * 0.53) - (gameController.tileSize * 5),
      gameController.tileSize * 2,
      gameController.tileSize * 1,
    );
    titleRectOriginalPosition = titleRect.center;

    // Menu
    highScoreDisplay?.resize();
    playButton?.resize();
    leaderBoardButton?.resize();
    aboutButton?.resize();
    helpButton?.resize();
  }

  void onTapUp(TapUpDetails d) {

    // Start Button
    if (!gameController.isHandled && playButton.rect.contains(d.globalPosition)) {
      if (gameController.gameState == GameState.MENU) {
        playButton.onTapUp();
        gameController.isHandled = true;
      }
    }

    // LeaderBoard Button
    if (!gameController.isHandled && leaderBoardButton.rect.contains(d.globalPosition)) {
      if (gameController.gameState == GameState.MENU) {
        leaderBoardButton.onTapUp();
        gameController.isHandled = true;
      }
    }

    // About Button
    if (!gameController.isHandled && aboutButton.rect.contains(d.globalPosition)) {
      if (gameController.gameState == GameState.MENU) {
        aboutButton.onTapUp();
        gameController.isHandled = true;
      }
    }

    // Help Button
    if (!gameController.isHandled && helpButton.rect.contains(d.globalPosition)) {
      if (gameController.gameState == GameState.MENU) {
        helpButton.onTapUp();
        gameController.isHandled = true;
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