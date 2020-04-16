import 'dart:math';
import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/res/assets.dart';

class Backdrop {

  final GameController gameController;
  Sprite bgSprite;
  Rect bgRect;

  Random rand;

  Backdrop(this.gameController) {
    resize();
    rand = gameController.rand;

    backgroundSelect();
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

  void backgroundSelect() {
    // Select background image at random
    switch (rand.nextInt(2)) {
      case 0:
        bgSprite = Sprite(Assets.backgroundDayImg);
        break;
      case 1:
        bgSprite = Sprite(Assets.backgroundNightImg);
        break;
    }
  }
}