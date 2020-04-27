import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/res/assets.dart';

class DialogBackdrop {

  final GameController gameController;
  Sprite dialogBgSprite;
  Rect dialogBgRect;

  DialogBackdrop(this.gameController) {
    resize();
    dialogBgSprite = Sprite(Assets.dialogBgImg);
  }

  void render(Canvas c) {
    dialogBgSprite.renderRect(c, dialogBgRect);
  }

  void resize() {
    dialogBgRect = Rect.fromLTWH(
      (gameController.screenSize.width / 2) - (gameController.tileSize * 4),
      (gameController.screenSize.height / 2) - (gameController.tileSize * 6),
      gameController.tileSize * 8,
      gameController.tileSize * 12,
    );
  }

  void update(double t) {}
}