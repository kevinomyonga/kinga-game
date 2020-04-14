import 'package:flame_splash_screen/flame_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:kinga/game.dart';
import 'package:kinga/res/assets.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenGameState createState() => _SplashScreenGameState();
}

class _SplashScreenGameState extends State<SplashScreen> {

  FlameSplashController controller;

  @override
  void initState() {
    super.initState();
    controller = FlameSplashController(
        fadeInDuration: Duration(seconds: 1),
        fadeOutDuration: Duration(milliseconds: 250),
        waitDuration: Duration(seconds: 4),
    );
  }

  @override
  void dispose() {
    // Dispose it when necessary
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlameSplashScreen(
        theme: FlameSplashTheme(
          backgroundDecoration: const BoxDecoration(color: Color(0xFF000000)),
          logoBuilder: _darkLogoBuilder,
        ),
        onFinish: (context) => navigationPage(),
        controller: controller,
      ),
    );
  }

  void navigationPage() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => GameWidget())
    );
  }
}

WidgetBuilder _darkLogoBuilder = (context) => Image(
  width: 300,
  image: const AssetImage(
    Assets.assetsImageDir + Assets.knoeyesGamesLogo,
  ),
);
