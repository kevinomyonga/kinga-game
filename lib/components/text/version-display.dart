import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/res/assets.dart';
import 'package:kinga/res/strings.dart';
import 'package:package_info/package_info.dart';

class VersionDisplay {

  final GameController gameController;
  TextPainter painter;
  Offset position;

  VersionDisplay(this.gameController) {
    painter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    position = Offset.zero;
  }

  void render(Canvas c) {
    painter.paint(c, position);
  }

  Future<void> update(double t) async {

    String appVersion = await getVersionNumber();

    Shadow shadow = Shadow(
      blurRadius: gameController.tileSize * .0625,
      color: Colors.black,
      offset: Offset.zero,
    );

    painter.text = TextSpan(
      text: '${AppStrings.version}: $appVersion',
      style: TextStyle(
        color: Colors.yellow,
        fontFamily: Assets.fontEquestria,
        fontSize: gameController.tileSize * .65,
        shadows: <Shadow>[shadow, shadow, shadow, shadow, shadow, shadow, shadow, shadow],
      ),
    );
    painter.layout();

    position = Offset(
      (gameController.screenSize.width / 2) - (painter.width / 2),
      (gameController.screenSize.height * 0.4) - (painter.height / 2),
    );
  }

  Future<String> getVersionNumber() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version + ' (' + packageInfo.buildNumber + ')';
    return version;
  }
}