import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:games_services/games_services.dart';
import 'package:games_services/score.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/game_data.dart';
import 'package:kinga/game_state.dart';
import 'package:kinga/res/Ids.dart';
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
    /*Paint color = Paint()..color = Color(0xFF0000FF);
    c.drawRect(playerRect, color);*/
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
      if(gameController.playView.score > 0) {
        // Give player a chance to continue
        gameController.gameState = GameState.CONTINUE;
        // Load reward video for user to watch
        gameController.loadRewardVideo();
      } else {
        // Reset game
        gameController.gameState = GameState.GAME_OVER;
        gameController.initialize();
        if (gameController.soundButton.isEnabled) {
          Flame.audio.play(Assets.enemyHaha);
        }
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