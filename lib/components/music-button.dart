import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:kinga/bgm.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/res/assets.dart';

class MusicButton {
  final GameController gameController;
  Rect rect;
  Sprite enabledSprite;
  Sprite disabledSprite;
  bool isEnabled = true;

  MusicButton(this.gameController) {
    resize();
    enabledSprite = Sprite(Assets.musicEnabledImg);
    disabledSprite = Sprite(Assets.musicDisabledImg);
  }

  void render(Canvas c) {
    if (isEnabled) {
      enabledSprite.renderRect(c, rect);
    } else {
      disabledSprite.renderRect(c, rect);
    }
  }

  void resize() {
    rect = Rect.fromLTWH(
      gameController.tileSize * .25,
      gameController.tileSize * .25,
      gameController.tileSize,
      gameController.tileSize,
    );
  }

  void onTapDown() {
    if (isEnabled) {
      isEnabled = false;
      BGM.pause();
    } else {
      isEnabled = true;
      BGM.resume();
    }
  }
}