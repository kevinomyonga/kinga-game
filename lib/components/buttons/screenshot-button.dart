import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:kinga/components/buttons/base-button.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/res/assets.dart';

class ScreenshotButton extends BaseButton {

  final GameController gameController;
  Rect rect;
  Sprite sprite;

  ScreenshotButton(this.gameController) : super(gameController) {
    resize();
    sprite = Sprite(Assets.screenshotImg);
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

  void onTapDown() {
    gameController.showCredits();
  }
}