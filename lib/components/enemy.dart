import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/res/Ids.dart';
import 'package:kinga/res/assets.dart';

class Enemy {

  final GameController gameController;
  int health;
  int damage;
  double speed;
  Rect enemyRect;
  List<List<Sprite>> flyingSprite;

  List<Sprite> machoFlySprite;
  List<Sprite> houseFlySprite;
  List<Sprite> droolerFlySprite;

  double flyingSpriteIndex = 0;

  bool isDead = false;

  Enemy(this.gameController, double x, double y) {
    health = 3;
    damage = 1;
    speed = gameController.tileSize * 2;
    enemyRect = Rect.fromLTWH(
        x,
        y,
        gameController.tileSize * 1.2,
        gameController.tileSize * 1.2
    );
    //sprite = Sprite(Assets.virus3Img);
    machoFlySprite = List<Sprite>();
    machoFlySprite.add(Sprite(Assets.enemyMacho1));
    machoFlySprite.add(Sprite(Assets.enemyMacho2));

    houseFlySprite = List<Sprite>();
    houseFlySprite.add(Sprite(Assets.enemyHouse1));
    houseFlySprite.add(Sprite(Assets.enemyHouse2));

    droolerFlySprite = List<Sprite>();
    droolerFlySprite.add(Sprite(Assets.enemyDrooler1));
    droolerFlySprite.add(Sprite(Assets.enemyDrooler2));

    flyingSprite = List<List<Sprite>>();
    flyingSprite.add(machoFlySprite);
    flyingSprite.add(houseFlySprite);
    flyingSprite.add(droolerFlySprite);
  }

  void render(Canvas c) {
    int index;

    switch(health) {
      case 1:
        index = 2;
        break;
      case 2:
        index = 1;
        break;
      case 3:
        index = 0;
        break;
      default:
        index = 0;
        break;
    }

    if(!isDead) {
      List<Sprite> enemySprites = List<Sprite>();
      enemySprites = flyingSprite[index].toList();
      enemySprites[flyingSpriteIndex.toInt()].renderRect(
          c, enemyRect.inflate(enemyRect.width / 2));
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
      Offset toPlayer = gameController.player.playerRect.center  - enemyRect.center;

      if(stepDistance <= toPlayer.distance - gameController.tileSize * 1.25) {
        Offset stepToPlayer = Offset.fromDirection(toPlayer.direction, stepDistance);
        enemyRect = enemyRect.shift(stepToPlayer);
      } else {
        attack();
      }
    }
  }

  void attack() {
    if(!gameController.player.isDead) {
      gameController.player.currentHealth -= damage;
    }
  }

  void onTapDown() {
    if(!isDead) {
      health--;

      if(health <= 0) {
        if (gameController.soundButton.isEnabled) {
          Flame.audio.play(Assets.enemyOuch);
        }

        isDead = true;

        // Score
        gameController.score++;
        print(gameController.score);

        if(gameController.score > (gameController.storage.getInt(Ids.sharedPrefHighScore) ?? 0)) {
          gameController.storage.setInt(Ids.sharedPrefHighScore, gameController.score);
        }
      }
    }
  }
}