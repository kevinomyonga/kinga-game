import 'dart:math';
import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:kinga/components/backdrops/backdrop.dart';
import 'package:kinga/components/buttons/music-button.dart';
import 'package:kinga/components/buttons/share-button.dart';
import 'package:kinga/components/buttons/sound-button.dart';
import 'package:kinga/components/enemies/enemy.dart';
import 'package:kinga/controllers/enemy_spawner.dart';
import 'package:kinga/helpers/bgm.dart';
import 'package:kinga/helpers/game_data.dart';
import 'package:kinga/helpers/game_state.dart';
import 'package:kinga/main.dart';
import 'package:kinga/views/about-view.dart';
import 'package:kinga/views/continue-view.dart';
import 'package:kinga/views/credits-view.dart';
import 'package:kinga/views/home-view.dart';
import 'package:kinga/views/lost-view.dart';
import 'package:kinga/views/pause-view.dart';
import 'package:kinga/views/play-view.dart';
import 'package:kinga/views/tutorial-view.dart';

class GameController extends Game with TapDetector {

  GameData gameData;

  Size screenSize;
  double tileSize;

  Backdrop background;

  Random rand;
  EnemySpawner enemySpawner;
  List<Enemy> enemies;

  GameState gameState = GameState.MENU;

  MusicButton musicButton;
  SoundButton soundButton;
  ShareButton shareButton;

  // Game Views
  HomeView homeView;
  PlayView playView;
  PauseView pauseView;
  ContinueView continueView;
  LostView lostView;
  AboutView aboutView;
  CreditsView creditsView;
  TutorialView tutorialView;

  // New HighScore Flag
  bool isNewHighScore;

  // Tap Detection Flag
  bool isHandled;

  GameController() {
    gameData = gameDataStorage;
    initialize();
  }

  void initialize() async {
    resize(await Flame.util.initialDimensions());

    rand = Random();
    background = Backdrop(this);

    musicButton = MusicButton(this);
    soundButton = SoundButton(this);
    shareButton = ShareButton(this);

    enemies = List<Enemy>();
    enemySpawner = EnemySpawner(this);

    homeView = HomeView(this);
    playView = PlayView(this);
    pauseView = PauseView(this);
    continueView = ContinueView(this);
    lostView = LostView(this);
    aboutView = AboutView(this);
    creditsView = CreditsView(this);
    tutorialView = TutorialView(this);

    // Play Menu Music
    if(gameState == GameState.MENU) BGM.play(BGMType.HOME);
    if(gameState == GameState.PLAYING) BGM.play(BGMType.PLAYING);
  }

  void render(Canvas c) {

    background.render(c);

    if(gameState == GameState.MENU) homeView.render(c);
    if(gameState == GameState.PLAYING) playView.render(c);
    if(gameState == GameState.PAUSED) pauseView.render(c);
    if(gameState == GameState.CONTINUE) continueView.render(c);
    if(gameState == GameState.GAME_OVER) lostView.render(c);
    if(gameState == GameState.ABOUT) aboutView.render(c);
    if(gameState == GameState.CREDITS) creditsView.render(c);
    if(gameState == GameState.HELP) tutorialView.render(c);

    musicButton.render(c);
    // Prevent music from playing if disabled
    if(!musicButton.isEnabled) BGM.pause();
    soundButton.render(c);

    if(Device.get().isIos && Device.get().isTablet){
      // Remove share button
    } else {
      if (gameState != GameState.PLAYING) shareButton.render(c);
    }
  }

  void update(double t) {
    if(gameState == GameState.MENU) homeView.update(t);
    if(gameState == GameState.PLAYING) playView.update(t);
    if(gameState == GameState.PAUSED) pauseView.update(t);
    if(gameState == GameState.CONTINUE) continueView.update(t);
    if(gameState == GameState.GAME_OVER) lostView.update(t);
    if(gameState == GameState.ABOUT) aboutView.update(t);
    if(gameState == GameState.CREDITS) creditsView.update(t);
    if(gameState == GameState.HELP) tutorialView.update(t);
  }

  void resize(Size size) {
    screenSize = size;

    if(Device.get().isTablet) {
      tileSize = screenSize.width / 14;
    } else {
      tileSize = screenSize.width / 10;
    }

    background?.resize();

    homeView?.resize();
    playView?.resize();
    pauseView?.resize();
    continueView?.resize();
    lostView?.resize();
    aboutView?.resize();
    creditsView?.resize();
    tutorialView?.resize();

    musicButton?.resize();
    soundButton?.resize();
    shareButton?.resize();
  }

  void onTapDown(TapDownDetails d) {
    // The PlayView requires input to be registered immediately when playing
    playView.onTapDown(d);
  }

  void onTapUp(TapUpDetails d) {
    isHandled = false;

    if(gameState == GameState.MENU) homeView.onTapUp(d);
    if(gameState == GameState.PLAYING) playView.onTapUp(d);
    if(gameState == GameState.PAUSED) pauseView.onTapUp(d);
    if(gameState == GameState.CONTINUE) continueView.onTapUp(d);
    if(gameState == GameState.GAME_OVER) lostView.onTapUp(d);
    if(gameState == GameState.ABOUT) aboutView.onTapUp(d);
    if(gameState == GameState.CREDITS) creditsView.onTapUp(d);
    if(gameState == GameState.HELP) tutorialView.onTapUp(d);

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
    if(!isHandled && shareButton.rect.contains(d.globalPosition)) {
      shareButton.onTapUp();
      isHandled = true;
    }
  }

  // LeaderBoard
  Function() showLeaderBoard;
  // Share
  Function() shareGame;
  // RewardAds
  Function() loadRewardVideo;
  Function() showRewardVideo;
  Function() resetRewardFlag;
  // Feedback
  Function(String) sendFeedback;
  Function() launchDeveloperWebsite;
  // Tutorial/Demo
  Function() openDemoVideo;
}