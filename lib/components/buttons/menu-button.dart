import 'package:flame/sprite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kinga/components/buttons/base-button.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/helpers/game_state.dart';
import 'package:kinga/res/assets.dart';

class MenuButton extends BaseButton {

  final GameController gameController;
  Rect rect;
  Sprite sprite;

  MenuButton(this.gameController) : super(gameController) {
    resize();
    sprite = Sprite(Assets.menuButtonImg);
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
  }

  void update(double t) {}

  void resize() {
    rect = Rect.fromLTWH(
      (gameController.screenSize.width / 2) - (gameController.tileSize * 0.75),
      (gameController.screenSize.height * .77) - (gameController.tileSize * 1.2),
      gameController.tileSize * 1.2,
      gameController.tileSize * 1.2,
    );
  }

  void onTapUp() {
    super.onTapUp();
    gameController.gameState = GameState.MENU;
    // Reset game
    gameController.initialize();
  }
}