import 'package:flame/sprite.dart';
import 'package:kinga/components/enemies/enemy.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/res/assets.dart';

class HouseFly extends Enemy {

  HouseFly(GameController gameController, double x, double y) : super(gameController) {
    super.resize(x: x, y: y);
    flyingSprite = List<Sprite>();

    // Determine which side the fly is coming from
    if(x < gameController.screenSize.width / 2) {
      flyingSprite.add(Sprite(Assets.enemyHouseFly1));
      flyingSprite.add(Sprite(Assets.enemyHouseFly2));
      deadSprite = Sprite(Assets.enemyHouseFlyDead);
    } else {
      flyingSprite.add(Sprite(Assets.enemyHouseFly1Inverted));
      flyingSprite.add(Sprite(Assets.enemyHouseFly2Inverted));
      deadSprite = Sprite(Assets.enemyHouseFlyDeadInverted);
    }
  }
}