import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/game_state.dart';
import 'package:kinga/res/assets.dart';

class CreditsButton {

  final GameController gameController;
  Rect rect;
  Sprite sprite;

  CreditsButton(this.gameController) {
    resize();
    sprite = Sprite(Assets.creditsImg);
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