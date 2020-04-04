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
  List<Sprite> enemySprites;

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
    enemySprites = List<Sprite>();
    enemySprites.add(Sprite(Assets.virus1Img));
    enemySprites.add(Sprite(Assets.virus2Img));
    enemySprites.add(Sprite(Assets.virus3Img));
  }

  void render(Canvas c) {
    //Color color;
    int index;

    switch(health) {
      case 1:
        //color = Color(0xFFFF7F7F);
        index = 2;
        break;
      case 2:
        //color = Color(0xFFFF4C4C);
        index = 1;
        break;
      case 3:
        //color = Color(0xFFFF4500);
        index = 0;
        break;
      default:
        //color = Color(0xFFFF0000);
        index = 0;
        break;
    }
    /*Paint enemyColor = Paint()..color = color;
    c.drawRect(enemyRect, enemyColor);*/
    enemySprites[index].renderRect(c, enemyRect);
  }

  void update(double t) {
    if(!isDead) {
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