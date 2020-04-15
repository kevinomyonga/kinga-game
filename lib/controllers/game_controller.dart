import 'dart:math';
import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:kinga/bgm.dart';
import 'package:kinga/components/backdrop.dart';
import 'package:kinga/components/buttons/music-button.dart';
import 'package:kinga/components/buttons/share-button.dart';
import 'package:kinga/components/buttons/sound-button.dart';
import 'package:kinga/components/enemy.dart';
import 'package:kinga/controllers/enemy_spawner.dart';
import 'package:kinga/game_state.dart';
import 'package:kinga/main.dart';
import 'package:kinga/views/continue-view.dart';
import 'package:kinga/views/credits-view.dart';
import 'package:kinga/views/home-view.dart';
import 'package:kinga/views/lost-view.dart';
import 'package:kinga/views/pause-view.dart';
import 'package:kinga/views/play-view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameController extends Game with TapDetector {

  SharedPreferences storage;

  Size screenSize;
  double tileSize;

  Backdrop background;

  Random rand;
  EnemySpawner enemySpawner;
  List<Enemy> enemies;

  GameState gameState = GameState.MENU;

  MusicButton musicButton;
  SoundButton soundButton;
  ShareButton screenshotButton;

  HomeView homeView;
  PlayView playView;
  PauseView pauseView;
  ContinueView continueView;
  LostView lostView;
  CreditsView creditsView;

  bool isNewHighScore = false;

  GameController() {
    storage = sharedPrefs;
    initialize();
  }

  void initialize() async {
    resize(await Flame.util.initialDimensions());

    background = Backdrop(this);
    //healthBar = HealthBar(this);
    //score = 0;
    //scoreDisplay = ScoreDisplay(this);

    musicButton = MusicButton(this);
    soundButton = SoundButton(this);
    screenshotButton = ShareButton(this);

    rand = Random();
    enemies = List<Enemy>();
    enemySpawner = EnemySpawner(this);

    homeView = HomeView(this);
    playView = PlayView(this);
    pauseView = PauseView(this);
    continueView = ContinueView(this);
    lostView = LostView(this);
    creditsView = CreditsView(this);

    // Play Menu Music
    if(gameState == GameState.MENU) BGM.play(BGMType.HOME);
    if(gameState == GameState.PLAYING) BGM.play(BGMType.PLAYING);
  }

  void render(Canvas c) {
    /*Rect background = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint backgroundPaint = Paint()..color = Color(0xFFFAFAFA);
    c.drawRect(background, backgroundPaint);*/

    background.render(c);

    if(gameState == GameState.MENU) homeView.render(c);
    if(gameState == GameState.PLAYING) playView.render(c);
    if(gameState == GameState.PAUSED) pauseView.render(c);
    if(gameState == GameState.CONTINUE) continueView.render(c);
    if(gameState == GameState.GAME_OVER) lostView.render(c);
    if(gameState == GameState.CREDITS) creditsView.render(c);

    musicButton.render(c);
    // Prevent music from playing if disabled
    if(!musicButton.isEnabled) BGM.pause();
    soundButton.render(c);
    screenshotButton.render(c);

    //if (gameState == GameState.HELP) helpView.render(c);
  }

  void update(double t) {
    if(gameState == GameState.MENU) homeView.update(t);
    if(gameState == GameState.PLAYING) playView.update(t);
    if(gameState == GameState.PAUSED) pauseView.update(t);
    if(gameState == GameState.CONTINUE) continueView.update(t);
    if(gameState == GameState.GAME_OVER) lostView.update(t);
    if(gameState == GameState.CREDITS) creditsView.update(t);
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 10;

    background?.resize();

    //highScoreDisplay?.resize();
    //scoreDisplay?.resize();

    homeView?.resize();
    playView?.resize();
    pauseView?.resize();
    continueView?.resize();
    lostView?.resize();
    creditsView?.resize();

    musicButton?.resize();
    soundButton?.resize();
    screenshotButton?.resize();
  }

  void onTapDown(TapDownDetails d) {
    // The PlayView requires input to be registered immediately when playing
    playView.onTapDown(d);
  }

  void onTapUp(TapUpDetails d) {
    bool isHandled = false;

    homeView.onTapUp(d);
    playView.onTapUp(d);
    pauseView.onTapUp(d);
    continueView.onTapUp(d);
    lostView.onTapUp(d);
    creditsView.onTapUp(d);

    // Music Button
    if(!isHandled && musicButton.rect.contains(d.globalPosition)) {
      musicButton.onTapUp();
      isHandled = true;
    }

    // Sound Button
    if(!isHandled && soundButton.rect.contains(d.globalPosition)) {
      soundButton.onTapUp();
      isHandled = true;
    }

    // Screenshot Button
    if(!isHandled && screenshotButton.rect.contains(d.globalPosition)) {
      screenshotButton.onTapUp();
      isHandled = true;
    }
  }

  Function() showLeaderBoard;
  Function() showHelp;
  //Function() showCredits;
  Function() shareGame;
  Function() loadRewardVideo;
  Function() showRewardVideo;
}