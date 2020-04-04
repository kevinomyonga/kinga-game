import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/res/assets.dart';

class HomeView {

  final GameController gameController;
  Rect titleRect;
  Sprite titleSprite;

  TextPainter painter;
  Offset position;

  HomeView(this.gameController) {
    resize();
    titleSprite = Sprite(Assets.virus1Img);
  }

  void render(Canvas c) {
    titleSprite.renderRect(c, titleRect);
  }

  void resize() {
    titleRect = Rect.fromLTWH(
      (gameController.screenSize.width / 2) - (gameController.tileSize * 2.5),
      (gameController.screenSize.height / 2) - (gameController.tileSize * 4),
      gameController.tileSize * 5,
      gameController.tileSize * 5,
    );
  }
}