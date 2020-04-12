import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:kinga/components/buttons/base-button.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/game_state.dart';
import 'package:kinga/res/assets.dart';

class PauseButton extends BaseButton {

  final GameController gameController;
  Rect rect;
  Sprite sprite;

  PauseButton(this.gameController) : super(gameController) {
    resize();
    sprite = Sprite(Assets.pauseButtonImg);
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
  }

  void update(double t) {}

  void resize() {
    rect = Rect.fromLTWH(
      gameController.tileSize * .25,
      gameController.screenSize.height - (gameController.tileSize * 1.25),
      gameController.tileSize,
      gameController.tileSize,
    );
  }

  void onTapUp() {
    super.onTapUp();
    gameController.gameState = GameState.PAUSED;
  }
}