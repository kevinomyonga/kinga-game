import 'package:flame/flame.dart';
import 'package:flame/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kinga/bgm.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/game.dart';
import 'package:kinga/res/assets.dart';
import 'package:kinga/splashscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences sharedPrefs;
GameController gameController;

void main() async {
  //Make sure flame is ready before we launch our game
  await setupFlame();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /*theme: ThemeData(
        fontFamily: Assets.fontEquestria,
      ),*/
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

/// Setup all Flame specific parts
Future setupFlame() async {
  WidgetsFlutterBinding.ensureInitialized(); //Since flutter upgrade this is required

  sharedPrefs = await SharedPreferences.getInstance();
  Util flameUtil = Util();
  flameUtil.fullScreen();
  flameUtil.setOrientation(DeviceOrientation.portraitUp); //Force the app to be in this screen mode

  await Flame.images.loadAll(<String>[
    Assets.backgroundImg,
    Assets.startButtonImg,
    Assets.backButtonImg,
    Assets.enemyAgileFly1,
    Assets.enemyAgileFly2,
    Assets.enemyAgileFlyDead,
    Assets.enemyDroolerFly1,
    Assets.enemyDroolerFly2,
    Assets.enemyDroolerFlyDead,
    Assets.enemyHouseFly1,
    Assets.enemyHouseFly2,
    Assets.enemyHouseFlyDead,
    Assets.enemyHungryFly1,
    Assets.enemyHungryFly2,
    Assets.enemyHungryFlyDead,
    Assets.enemyMachoFly1,
    Assets.enemyMachoFly2,
    Assets.enemyMachoFlyDead,
    Assets.enemyAgileFly1Inverted,
    Assets.enemyAgileFly2Inverted,
    Assets.enemyAgileFlyDeadInverted,
    Assets.enemyDroolerFly1Inverted,
    Assets.enemyDroolerFly2Inverted,
    Assets.enemyDroolerFlyDeadInverted,
    Assets.enemyHouseFly1Inverted,
    Assets.enemyHouseFly2Inverted,
    Assets.enemyHouseFlyDeadInverted,
    Assets.enemyHungryFly1Inverted,
    Assets.enemyHungryFly2Inverted,
    Assets.enemyHungryFlyDeadInverted,
    Assets.enemyMachoFly1Inverted,
    Assets.enemyMachoFly2Inverted,
    Assets.enemyMachoFlyDeadInverted,
    Assets.titleImg,
    Assets.playerImg,
    Assets.gameOverImg,
    Assets.musicEnabledImg,
    Assets.musicDisabledImg,
    Assets.soundEnabledImg,
    Assets.soundDisabledImg,
    Assets.helpImg,
    Assets.creditsImg,
    Assets.screenshotImg,
  ]);

  Flame.audio.disableLog();
  await BGM.preload();

  await Flame.audio.loadAll(<String>[
    Assets.enemyHaha,
    Assets.enemyHit,
    Assets.enemyOuch,
  ]);

  WidgetsBinding.instance.addObserver(BGMHandler());
}
