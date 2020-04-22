import 'package:flame/flame.dart';
import 'package:flame/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/helpers/bgm.dart';
import 'package:kinga/helpers/game_data.dart';
import 'package:kinga/res/assets.dart';
import 'package:kinga/screens/game.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences sharedPrefs;
GameController gameController;
GameData gameDataStorage;

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
  gameDataStorage = GameData(sharedPrefs);
  Util flameUtil = Util();
  flameUtil.fullScreen();
  flameUtil.setOrientation(DeviceOrientation.portraitUp); //Force the app to be in this screen mode

  await Flame.images.loadAll(<String>[
    Assets.backgroundDayImg,
    Assets.backgroundNightImg,
    Assets.dialogBgImg,
    Assets.dialogHeaderBgImg,
    Assets.bgMenuButton,
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
    Assets.playerImg,
    Assets.musicEnabledImg,
    Assets.musicDisabledImg,
    Assets.soundEnabledImg,
    Assets.soundDisabledImg,
    Assets.helpImg,
    Assets.shareImg,
    Assets.backButtonImg,
    Assets.playButtonImg,
    Assets.pauseButtonImg,
    Assets.homeButtonImg,
    Assets.menuButtonImg,
    Assets.reloadButtonImg,
    Assets.healthBar,
    Assets.healthBarEmpty,
    Assets.healthBarFull,
    Assets.heart,
    Assets.star,
  ]);

  Flame.audio.disableLog();
  await BGM.preload();

  await Flame.audio.loadAll(<String>[
    Assets.buttonClick,
    Assets.wellDone,
    Assets.enemyHit,
    Assets.enemyDefeated,
  ]);

  WidgetsBinding.instance.addObserver(BGMHandler());
}
