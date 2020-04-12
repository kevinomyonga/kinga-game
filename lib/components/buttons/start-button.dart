import 'package:flame/sprite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kinga/bgm.dart';
import 'package:kinga/components/buttons/base-button.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/game_state.dart';
import 'package:kinga/res/assets.dart';

class StartButton extends BaseButton {

  final GameController gameController;
  Rect rect;
  Sprite sprite;

  StartButton(this.gameController) : super(gameController) {
    resize();
    sprite = Sprite(Assets.startButtonImg);
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
  }

  void update(double t) {}

  void resize() {
    rect = Rect.fromLTWH(
      (gameController.screenSize.width / 2) - (gameController.tileSize * 3),
      (gameController.screenSize.height * .65) - (gameController.tileSize * 1.5),
      gameController.tileSize * 6,
      gameController.tileSize * 1.5,
    );
  }

  void onTapUp() {
    super.onTapUp();
    gameController.gameState = GameState.PLAYING;
    BGM.play(BGMType.PLAYING);
  }
}