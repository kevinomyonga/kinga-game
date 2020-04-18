import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:kinga/components/enemy-health-bar.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/helpers/game_data.dart';
import 'package:kinga/helpers/game_state.dart';
import 'package:kinga/res/assets.dart';

class Enemy {

  final GameController gameController;

  int maxHealth;
  int currentHealth;

  EnemyHealthBar enemyHealthBar;

  int damage;
  double speed;
  Rect enemyRect;
  List<Sprite> flyingSprite;

  Sprite deadSprite;

  double flyingSpriteIndex = 0;

  bool isDead = false;
  bool isOffScreen = false;

  Enemy(this.gameController) {
    maxHealth = currentHealth = 3;
    damage = 1;
    speed = gameController.tileSize * 2;

    enemyHealthBar = EnemyHealthBar(this);

    deadSprite = Sprite(Assets.enemyDroolerFlyDead);
  }

  void render(Canvas c) {
    if(!isDead) {
      flyingSprite[flyingSpriteIndex.toInt()].renderRect(c, enemyRect.inflate(enemyRect.width / 2));
      if (gameController.gameState == GameState.PLAYING) {
        enemyHealthBar.render(c);
      }
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

      if (gameController.gameState == GameState.PLAYING) {
        enemyHealthBar.update(t);
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
      currentHealth--;

      if(currentHealth >= 0) {
        if (gameController.soundButton.isEnabled) {
          Flame.audio.play(Assets.enemyHit);
        }
      }

      if(currentHealth <= 0) {
        if (gameController.soundButton.isEnabled) {
          Flame.audio.play(Assets.enemyOuch);
        }

        isDead = true;

        // Score
        gameController.playView.score++;
        print(gameController.playView.score);

        /*GameData.updateScore(gameController.playView.score);*/

        /*if(gameController.playView.score > (gameController.storage.getInt(Ids.sharedPrefHighScore) ?? 0)) {
          gameController.storage.setInt(Ids.sharedPrefHighScore, gameController.playView.score);
        }*/
      }
    }
  }
}