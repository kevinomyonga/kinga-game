import 'package:flame/sprite.dart';
import 'package:kinga/components/enemy.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/res/assets.dart';

class AgileFly extends Enemy {

  double get speed => gameController.tileSize * 4;

  AgileFly(GameController gameController, double x, double y) : super(gameController) {
    super.resize(x: x, y: y);

    // Determine which side the fly is coming from
    if(x < gameController.screenSize.width / 2) {
      flyingSprite.add(Sprite(Assets.enemyAgileFly1));
      flyingSprite.add(Sprite(Assets.enemyAgileFly2));
      deadSprite = Sprite(Assets.enemyAgileFlyDead);
    } else {
      flyingSprite.add(Sprite(Assets.enemyAgileFly1Inverted));
      flyingSprite.add(Sprite(Assets.enemyAgileFly2Inverted));
      deadSprite = Sprite(Assets.enemyAgileFlyDeadInverted);
    }
  }
}