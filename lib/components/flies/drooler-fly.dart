import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:kinga/components/enemy.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/res/assets.dart';

class DroolerFly extends Enemy {

  double get speed => gameController.tileSize * 0.5;

  DroolerFly(GameController gameController, double x, double y) : super(gameController) {
    resize(x: x, y: y);
    flyingSprite = List<Sprite>();

    // Determine which side the fly is coming from
    if(x > gameController.screenSize.width / 2) {
      flyingSprite.add(Sprite(Assets.enemyDroolerFly1));
      flyingSprite.add(Sprite(Assets.enemyDroolerFly2));
      deadSprite = Sprite(Assets.enemyDroolerFlyDead);
    } else {
      flyingSprite.add(Sprite(Assets.enemyDroolerFly1Inverted));
      flyingSprite.add(Sprite(Assets.enemyDroolerFly2Inverted));
      deadSprite = Sprite(Assets.enemyDroolerFlyDeadInverted);
    }
  }

  void resize({double x, double y}) {
    x ??= (enemyRect?.left) ?? 0;
    y ??= (enemyRect?.top) ?? 0;
    enemyRect = Rect.fromLTWH(x, y, gameController.tileSize * 1, gameController.tileSize * 1);
    super.resize();
  }
}