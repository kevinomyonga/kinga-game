import 'dart:io';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:kinga/controllers/game_controller.dart';

class Dimens {

  final GameController gameController;

  // Menu Buttons
  static double btnWidth;
  static double btnHeight;

  Dimens(this.gameController) {
    // Menu Buttons
    btnWidth = gameController.tileSize * 6;
    btnWidth = gameController.tileSize * 1.2;
  }
}