import 'package:flame/sprite.dart';
import 'package:kinga/components/enemies/enemy.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/res/assets.dart';

class DroolerFly extends Enemy {

  double get speed => gameController.tileSize * 0.5;

  DroolerFly(GameController gameController, double x, double y) : super(gameController) {
    super.resize(x: x, y: y);
    flyingSprite = List<Sprite>();

    // Determine which side the fly is coming from
    if(x < gameController.screenSize.width / 2) {
      flyingSprite.add(Sprite(Assets.enemyDroolerFly1));
      flyingSprite.add(Sprite(Assets.enemyDroolerFly2));
      deadSprite = Sprite(Assets.enemyDroolerFlyDead);
    } else {
      flyingSprite.add(Sprite(Assets.enemyDroolerFly1Inverted));
      flyingSprite.add(Sprite(Assets.enemyDroolerFly2Inverted));
      deadSprite = Sprite(Assets.enemyDroolerFlyDeadInverted);
    }
  }
}