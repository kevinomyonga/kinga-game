import 'package:flame/sprite.dart';
import 'package:kinga/components/enemy.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/res/assets.dart';

class HungryFly extends Enemy {

  HungryFly(GameController gameController, double x, double y) : super(gameController) {
    //resize(x: x, y: y);
    super.resize(x: x, y: y);
    flyingSprite = List<Sprite>();

    // Determine which side the fly is coming from
    if(x < gameController.screenSize.width / 2) {
      flyingSprite.add(Sprite(Assets.enemyHungryFly1));
      flyingSprite.add(Sprite(Assets.enemyHungryFly2));
      deadSprite = Sprite(Assets.enemyHungryFlyDead);
    } else {
      flyingSprite.add(Sprite(Assets.enemyHungryFly1Inverted));
      flyingSprite.add(Sprite(Assets.enemyHungryFly2Inverted));
      deadSprite = Sprite(Assets.enemyHungryFlyDeadInverted);
    }
  }

  /*void resize({double x, double y}) {
    x ??= (enemyRect?.left) ?? 0;
    y ??= (enemyRect?.top) ?? 0;
    enemyRect = Rect.fromLTWH(x, y, gameController.tileSize * 1, gameController.tileSize * 0.5);
    super.resize();
  }*/
}