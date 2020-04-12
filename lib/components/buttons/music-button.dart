import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:kinga/bgm.dart';
import 'package:kinga/components/buttons/base-button.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/res/Ids.dart';
import 'package:kinga/res/assets.dart';

class MusicButton extends BaseButton {

  final GameController gameController;
  Rect rect;
  Sprite enabledSprite;
  Sprite disabledSprite;
  bool isEnabled = true;

  MusicButton(this.gameController) : super(gameController) {
    resize();
    enabledSprite = Sprite(Assets.musicEnabledImg);
    disabledSprite = Sprite(Assets.musicDisabledImg);

    // Load Pref
    isEnabled = gameController.storage.getBool(Ids.sharedPrefMusic) ?? true;
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

  void onTapUp() {
    super.onTapUp();
    if (isEnabled) {
      isEnabled = false;
      BGM.pause();
    } else {
      isEnabled = true;
      BGM.resume();
    }
    // Save Pref
    gameController.storage.setBool(Ids.sharedPrefMusic, isEnabled);
  }
}