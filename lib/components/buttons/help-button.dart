import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/res/assets.dart';

class HelpButton {

  final GameController gameController;
  Rect rect;
  Sprite sprite;

  HelpButton(this.gameController) {
    resize();
    sprite = Sprite(Assets.helpImg);
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
  }

  void resize() {
    rect = Rect.fromLTWH(
      gameController.tileSize * .25,
      gameController.screenSize.height - (gameController.tileSize * 1.25),
      gameController.tileSize,
      gameController.tileSize,
    );
  }

  void onTapDown() {
    gameController.showHelp();
  }
}