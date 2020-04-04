import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/res/assets.dart';

class LostView {

  final GameController gameController;
  Rect rect;
  Sprite sprite;

  LostView(this.gameController) {
    resize();
    sprite = Sprite(Assets.gameOverImg);
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
  }

  void resize() {
    rect = Rect.fromLTWH(
      (gameController.screenSize.width / 2) - (gameController.tileSize * 3.5),
      (gameController.screenSize.height / 2) - (gameController.tileSize * 5),
      gameController.tileSize * 7,
      gameController.tileSize * 5,
    );
  }
}