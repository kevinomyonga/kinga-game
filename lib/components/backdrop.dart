import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/res/assets.dart';

class Backdrop {

  final GameController gameController;
  Sprite bgSprite;
  Rect bgRect;

  Backdrop(this.gameController) {
    bgSprite = Sprite(Assets.backgroundImg);
    resize();
  }

  void render(Canvas c) {
    bgSprite.renderRect(c, bgRect);
  }

  void resize() {
    bgRect = Rect.fromLTWH(
        0,
        0,
        gameController.screenSize.width,
        gameController.screenSize.height
    );
  }

  void update(double t) {}
}