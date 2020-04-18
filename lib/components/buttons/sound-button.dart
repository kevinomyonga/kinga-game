import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:kinga/components/buttons/base-button.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/res/assets.dart';

class SoundButton extends BaseButton {

  final GameController gameController;
  Rect rect;
  Sprite enabledSprite;
  Sprite disabledSprite;
  bool isEnabled = true;

  SoundButton(this.gameController) : super(gameController) {
    resize();
    enabledSprite = Sprite(Assets.soundEnabledImg);
    disabledSprite = Sprite(Assets.soundDisabledImg);

    // Load Pref
    isEnabled = gameController.gameData.isSoundEnabled();
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
      gameController.tileSize * 1.5,
      gameController.tileSize * .25,
      gameController.tileSize,
      gameController.tileSize,
    );
  }

  void onTapUp() {
    super.onTapUp();
    isEnabled = !isEnabled;
    // Update Pref
    gameController.gameData.setSoundEnabled(isEnabled);
  }
}