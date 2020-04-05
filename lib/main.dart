import 'package:flame/flame.dart';
import 'package:flame/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kinga/bgm.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/game.dart';
import 'package:kinga/res/assets.dart';
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
      debugShowCheckedModeBanner: false,
      home: GameWidget(),
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
    Assets.enemy1Img,
    Assets.enemy2Img,
    Assets.enemyMacho1,
    Assets.enemyMacho2,
    Assets.enemyHouse1,
    Assets.enemyHouse2,
    Assets.enemyDrooler1,
    Assets.enemyDrooler2,
    Assets.enemyDroolerDead,
    Assets.titleImg,
    Assets.playerImg,
    Assets.gameOverImg,
    Assets.musicEnabledImg,
    Assets.musicDisabledImg,
    Assets.soundEnabledImg,
    Assets.soundDisabledImg,
    Assets.helpImg,
    Assets.creditsImg,
  ]);

  Flame.audio.disableLog();
  await BGM.preload();

  await Flame.audio.loadAll(<String>[
    Assets.enemyHaha,
    Assets.enemyOuch,
  ]);

  WidgetsBinding.instance.addObserver(BGMHandler());
}
