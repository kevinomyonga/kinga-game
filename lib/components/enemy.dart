import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/game_data.dart';
import 'package:kinga/res/Ids.dart';
import 'package:kinga/res/assets.dart';

class Enemy {

  final GameController gameController;
  int health;
  int damage;
  double speed;
  Rect enemyRect;
  List<Sprite> flyingSprite;

  Sprite deadSprite;

  double flyingSpriteIndex = 0;

  bool isDead = false;
  bool isOffScreen = false;

  Enemy(this.gameController) {
    health = 3;
    damage = 1;
    speed = gameController.tileSize * 2;

    deadSprite = Sprite(Assets.enemyDroolerFlyDead);
  }

  void render(Canvas c) {
    if(!isDead) {
      flyingSprite[flyingSpriteIndex.toInt()].renderRect(c, enemyRect.inflate(enemyRect.width / 2));
    } else {
      deadSprite.renderRect(c, enemyRect.inflate(enemyRect.width / 2));
    }
  }

  void update(double t) {
    if(!isDead) {
      // Flap the wings
      flyingSpriteIndex += 30 * t;
      while (flyingSpriteIndex >= 2) {
        flyingSpriteIndex -= 2;
      }

      // Move the fly
      double stepDistance = speed * t;
      Offset toPlayer = gameController.playView.player.playerRect.center  - enemyRect.center;

      if(stepDistance <= toPlayer.distance - gameController.tileSize * 1.25) {
        Offset stepToPlayer = Offset.fromDirection(toPlayer.direction, stepDistance);
        enemyRect = enemyRect.shift(stepToPlayer);
      } else {
        attack();
      }
    } else {
      // Make the fly fall
      enemyRect = enemyRect.translate(0, gameController.tileSize * 12 * t);
      if (enemyRect.top > gameController.screenSize.height) {
        isOffScreen = true;
      }
    }
  }

  void resize() {}

  void attack() {
    if(!gameController.playView.player.isDead) {
      gameController.playView.player.currentHealth -= damage;
    }
  }

  void onTapDown() {
    if(!isDead) {
      health--;

      if(health >= 0) {
        if (gameController.soundButton.isEnabled) {
          Flame.audio.play(Assets.enemyHit);
        }
      }

      if(health <= 0) {
        if (gameController.soundButton.isEnabled) {
          Flame.audio.play(Assets.enemyOuch);
        }

        isDead = true;

        // Score
        gameController.playView.score++;
        print(gameController.playView.score);

        GameData.updateScore(gameController.playView.score);

        /*if(gameController.playView.score > (gameController.storage.getInt(Ids.sharedPrefHighScore) ?? 0)) {
          gameController.storage.setInt(Ids.sharedPrefHighScore, gameController.playView.score);
        }*/
      }
    }
  }
}