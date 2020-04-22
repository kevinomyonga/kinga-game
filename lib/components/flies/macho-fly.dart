import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:kinga/components/enemy.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/res/assets.dart';

class MachoFly extends Enemy {

  double get speed => gameController.tileSize * 1.5;

  MachoFly(GameController gameController, double x, double y) : super(gameController) {
    resize(x: x, y: y);
    flyingSprite = List<Sprite>();

    // Determine which side the fly is coming from
    if(x < gameController.screenSize.width / 2) {
      flyingSprite.add(Sprite(Assets.enemyMachoFly1));
      flyingSprite.add(Sprite(Assets.enemyMachoFly2));
      deadSprite = Sprite(Assets.enemyMachoFlyDead);
    } else {
      flyingSprite.add(Sprite(Assets.enemyMachoFly1Inverted));
      flyingSprite.add(Sprite(Assets.enemyMachoFly2Inverted));
      deadSprite = Sprite(Assets.enemyMachoFlyDeadInverted);
    }
  }

  void resize({double x, double y}) {
    x ??= (enemyRect?.left) ?? 0;
    y ??= (enemyRect?.top) ?? 0;
    enemyRect = Rect.fromLTWH(x, y, gameController.tileSize * 1, gameController.tileSize * 0.5);
    super.resize();
  }
}