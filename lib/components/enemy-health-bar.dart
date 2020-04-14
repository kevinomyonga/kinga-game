import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:kinga/components/enemy.dart';
import 'package:kinga/res/assets.dart';

class EnemyHealthBar {

  final Enemy enemy;

  Rect emptyHealthRect;
  Rect remainingHealthRect;

  Sprite spriteFull;
  Sprite spriteEmpty;

  EnemyHealthBar(this.enemy) {
    /*emptyHealthRect = Rect.fromLTWH(
        enemy.enemyRect.left - (enemy.gameController.tileSize * .75),
        enemy.enemyRect.top - (enemy.gameController.tileSize * .625),
        enemy.gameController.tileSize * .75,
        enemy.gameController.tileSize * 0.5
    );*/

    /*remainingHealthRect = Rect.fromLTWH(
        enemy.enemyRect.left - (enemy.gameController.tileSize * .75),
        enemy.enemyRect.top - (enemy.gameController.tileSize * .625),
        enemy.gameController.tileSize * .75,
        enemy.gameController.tileSize * 0.5
    );*/

    spriteEmpty = Sprite(Assets.healthBarEmpty);
    spriteFull = Sprite(Assets.healthBarFull);
  }

  void render(Canvas c) {
    spriteEmpty.renderRect(c, emptyHealthRect);
    spriteFull.renderRect(c, remainingHealthRect);
  }

  void update(double t) {
    double percentHealth = enemy.currentHealth / enemy.maxHealth;

    emptyHealthRect = Rect.fromLTWH(
        enemy.enemyRect.left - (enemy.gameController.tileSize * .75),
        enemy.enemyRect.top - (enemy.gameController.tileSize * .625),
        enemy.gameController.tileSize * .75,
        enemy.gameController.tileSize * 0.2
    );

    remainingHealthRect = Rect.fromLTWH(
        enemy.enemyRect.left - (enemy.gameController.tileSize * .75),
        enemy.enemyRect.top - (enemy.gameController.tileSize * .625),
        (enemy.gameController.tileSize * .75) * percentHealth,
        enemy.gameController.tileSize * 0.2
    );
  }
}