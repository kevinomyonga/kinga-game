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
      (gameController.screenSize.width / 2) - (gameController.tileSize * 3),
      (gameController.screenSize.height * .90) - (gameController.tileSize * 1.5),
      gameController.tileSize * 6,
      gameController.tileSize * 1.5,
    );
  }

  void onTapDown() {
    //gameController.showCredits();
    gameController.gameState = GameState.CREDITS;
  }
}