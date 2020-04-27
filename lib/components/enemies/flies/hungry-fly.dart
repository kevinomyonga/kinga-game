import 'package:flame/sprite.dart';
import 'package:kinga/components/enemies/enemy.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/res/assets.dart';

class HungryFly extends Enemy {

  HungryFly(GameController gameController, double x, double y) : super(gameController) {
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
}