import 'package:flame/sprite.dart';
import 'package:kinga/components/enemies/enemy.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/res/assets.dart';

class MachoFly extends Enemy {

  double get speed => gameController.tileSize * 1.5;

  MachoFly(GameController gameController, double x, double y) : super(gameController) {
    super.resize(x: x, y: y);
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
}