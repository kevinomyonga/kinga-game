import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/game_data.dart';
import 'package:kinga/game_state.dart';
import 'package:kinga/res/assets.dart';

class Player {

  final GameController gameController;
  int maxHealth;
  int currentHealth;
  Rect playerRect;
  Sprite sprite;

  bool isDead = false;

  Player(this.gameController) {
    maxHealth = currentHealth = 300;
    resize();
    sprite = Sprite(Assets.playerImg);
  }

  void render(Canvas c) {
    sprite.renderRect(c, playerRect);
  }

  void update(double t) {
    //print(currentHealth);
    if(!isDead && currentHealth <= 0) {
      isDead = true;

      // Save the current score
      GameData.setLastSubmittedScore(gameController.playView.score);

      /*// Update HighScore
      GameData.updateScore(gameController.playView.score);

      // Submit HighScore to LeaderBoard
      GamesServices.submitScore(
          score: Score(
              androidLeaderboardID: Ids.androidLeaderBoardID,
              iOSLeaderboardID: Ids.iOSLeaderBoardID,
              value: gameController.playView.score)
      );*/

      // Only give player continue option if they meet the criteria
      if(gameController.playView.score > 0 && gameController.continueView.continuesLeft > 0) {
        // Give player a chance to continue
        gameController.gameState = GameState.CONTINUE;
        // Load reward video for user to watch
        gameController.loadRewardVideo();
        // Refresh the Continue View
        gameController.continueView.startCountdown();
      } else {
        gameController.playView.endGame();
      }
    }
  }

  void resize() {
    final size = gameController.tileSize * 2;
    playerRect = Rect.fromLTWH(
        gameController.screenSize.width / 2 - (size / 2),
        gameController.screenSize.height / 2 - (size / 2),
        size,
        size
    );
  }
}