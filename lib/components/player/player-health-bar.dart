import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/res/assets.dart';

class HealthBar {

  final GameController gameController;
  Rect healthBarRect;
  Rect heartRect;
  Rect emptyHealthRect;
  Rect remainingHealthRect;

  Sprite spriteBar;
  Sprite spriteHeart;
  Sprite spriteFull;
  Sprite spriteEmpty;

  HealthBar(this.gameController) {
    double barWidth = gameController.screenSize.width / 1.75;
    healthBarRect = Rect.fromLTWH(
        (gameController.screenSize.width / 2) - (barWidth / 2),
        gameController.screenSize.height - (gameController.tileSize * 1.35),
        barWidth,
        gameController.tileSize * 1.15
    );

    heartRect = Rect.fromLTWH(
        (gameController.screenSize.width / 2) - (barWidth / 2 * (Device.get().isTablet ? 0.93 : 0.98)),
        gameController.screenSize.height - (gameController.tileSize * 1.25),
        gameController.tileSize,
        gameController.tileSize,
    );

    emptyHealthRect = Rect.fromLTWH(
        gameController.screenSize.width / 2 - (barWidth * 0.75 / 2.5),
        gameController.screenSize.height - (gameController.tileSize * 0.95),
        barWidth * 0.78,
        gameController.tileSize * 0.5
    );

    remainingHealthRect = Rect.fromLTWH(
        (gameController.screenSize.width / 2) - (barWidth * 0.75 / 2.5),
        gameController.screenSize.height - (gameController.tileSize * 0.95),
        barWidth * 0.78,
        gameController.tileSize * 0.5
    );

    spriteBar = Sprite(Assets.healthBar);
    spriteHeart = Sprite(Assets.heart);
    spriteEmpty = Sprite(Assets.healthBarEmpty);
    spriteFull = Sprite(Assets.healthBarFull);
  }

  void render(Canvas c) {
    spriteBar.renderRect(c, healthBarRect);
    spriteHeart.renderRect(c, heartRect);
    spriteEmpty.renderRect(c, emptyHealthRect);
    spriteFull.renderRect(c, remainingHealthRect);
  }

  void update(double t) {
    double barWidth = gameController.screenSize.width / 1.75;
    double percentHealth = gameController.playView.player.currentHealth / gameController.playView.player.maxHealth;

    remainingHealthRect = Rect.fromLTWH(
        (gameController.screenSize.width / 2) - (barWidth * 0.75 / 2.5),
        gameController.screenSize.height - (gameController.tileSize * 0.95),
        ((barWidth * 0.78) - 0) * percentHealth,
        gameController.tileSize * 0.5
    );
  }
}