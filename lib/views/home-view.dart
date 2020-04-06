import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/res/assets.dart';

class HomeView {

  final GameController gameController;
  Rect titleRect;
  //Sprite titleSprite;
  List<Sprite> titleSprite;
  double flyingSpriteIndex = 0;

  TextPainter painter;
  Offset position;

  HomeView(this.gameController) {
    resize();
    //titleSprite = Sprite(Assets.enemyAgileFly1);
    titleSprite = List<Sprite>();
    titleSprite.add(Sprite(Assets.enemyAgileFly1));
    titleSprite.add(Sprite(Assets.enemyAgileFly2));
  }

  void render(Canvas c) {
    //titleSprite.renderRect(c, titleRect);
    titleSprite[flyingSpriteIndex.toInt()].renderRect(c, titleRect.inflate(titleRect.width / 2));
  }

  void update(double t) {
    // Flap the wings
    flyingSpriteIndex += 30 * t;
    while (flyingSpriteIndex >= 2) {
      flyingSpriteIndex -= 2;
    }
  }

  void resize() {
    titleRect = Rect.fromLTWH(
      (gameController.screenSize.width / 2) - (gameController.tileSize * 2.5),
      (gameController.screenSize.height / 2) - (gameController.tileSize * 4),
      gameController.tileSize * 3.5,
      gameController.tileSize * 3.5,
    );
  }
}