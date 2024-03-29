import 'package:flame/flame.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/res/assets.dart';

class BaseButton {

  final GameController gameController;

  BaseButton(this.gameController);

  void onTapUp() {
    if (gameController.soundButton.isEnabled) {
      Flame.audio.play(Assets.buttonClick);
    }
  }
}