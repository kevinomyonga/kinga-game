import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:kinga/controllers/game_controller.dart';
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
    /*Paint color = Paint()..color = Color(0xFF0000FF);
    c.drawRect(playerRect, color);*/
    sprite.renderRect(c, playerRect);
  }

  void update(double t) {
    //print(currentHealth);
    if(!isDead && currentHealth <= 0) {
      isDead = true;

      // Reset game
      gameController.gameState = GameState.GAME_OVER;
      gameController.initialize();
      if (gameController.soundButton.isEnabled) {
        Flame.audio.play(Assets.enemyHaha);
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