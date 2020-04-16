import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:kinga/components/buttons/base-button.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/res/assets.dart';

class ShareButton extends BaseButton {

  final GameController gameController;
  Rect rect;
  Sprite sprite;

  ShareButton(this.gameController) : super(gameController) {
    resize();
    sprite = Sprite(Assets.shareImg);
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
  }

  void resize() {
    rect = Rect.fromLTWH(
      gameController.screenSize.width - (gameController.tileSize * 1.25),
      gameController.screenSize.height - (gameController.tileSize * 1.25),
      gameController.tileSize,
      gameController.tileSize,
    );
  }

  void onTapUp() {
    super.onTapUp();
    gameController.shareGame();
  }
}