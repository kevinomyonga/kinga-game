import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/helpers/game_state.dart';
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
    // Load reward video for user to watch
    gameController.loadRewardVideo();
  }

  void render(Canvas c) {
    sprite.renderRect(c, playerRect);
  }

  void update(double t) {
    if(!isDead && currentHealth <= 0) {
      isDead = true;

      // Save the current score
      gameController.gameData.setLastSubmittedScore(gameController.playView.score);

      // Only give player continue option if they meet the criteria
      if(gameController.playView.score > 0 && gameController.continueView.continuesLeft > 0) {
        showContinue(true);
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

  void showContinue(bool reseTime) {
    // Give player a chance to continue
    gameController.gameState = GameState.CONTINUE;
    // Reset Countdown Time
    if(reseTime) gameController.continueView.timeLeft = 10;
    // Refresh the Continue View
    gameController.continueView.startCountdown();
  }
}