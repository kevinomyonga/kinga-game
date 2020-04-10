import 'dart:math';
import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:kinga/bgm.dart';
import 'package:kinga/components/backdrop.dart';
import 'package:kinga/components/buttons/music-button.dart';
import 'package:kinga/components/buttons/sound-button.dart';
import 'package:kinga/components/enemy.dart';
import 'package:kinga/components/health_bar.dart';
import 'package:kinga/components/player.dart';
import 'package:kinga/components/score_text.dart';
import 'package:kinga/controllers/enemy_spawner.dart';
import 'package:kinga/game_state.dart';
import 'package:kinga/main.dart';
import 'package:kinga/views/home-view.dart';
import 'package:kinga/views/lost-view.dart';
import 'package:kinga/views/play-view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameController extends Game with TapDetector {

  SharedPreferences storage;

  Size screenSize;
  double tileSize;

  Backdrop background;
  Player player;
  HealthBar healthBar;
  int score;
  ScoreDisplay scoreDisplay;

  Random rand;
  EnemySpawner enemySpawner;
  List<Enemy> enemies;

  GameState gameState = GameState.MENU;

  MusicButton musicButton;
  SoundButton soundButton;

  HomeView homeView;
  PlayView playView;
  LostView lostView;

  GameController() {
    storage = sharedPrefs;
    initialize();
  }

  void initialize() async {
    resize(await Flame.util.initialDimensions());

    background = Backdrop(this);
    healthBar = HealthBar(this);
    score = 0;
    scoreDisplay = ScoreDisplay(this);

    musicButton = MusicButton(this);
    soundButton = SoundButton(this);

    rand = Random();
    player = Player(this);
    enemies = List<Enemy>();
    enemySpawner = EnemySpawner(this);

    homeView = HomeView(this);
    playView = PlayView(this);
    lostView = LostView(this);

    // Play Menu Music
    BGM.play(BGMType.HOME);
  }

  void render(Canvas c) {
    /*Rect background = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint backgroundPaint = Paint()..color = Color(0xFFFAFAFA);
    c.drawRect(background, backgroundPaint);*/

    background.render(c);

    if(gameState == GameState.MENU) homeView.render(c);

    if(gameState == GameState.PLAYING) playView.render(c);

    if(gameState == GameState.GAME_OVER) lostView.render(c);

    musicButton.render(c);
    // Prevent music from playing if disabled
    if(!musicButton.isEnabled) BGM.pause();
    soundButton.render(c);

    //if (gameState == GameState.HELP) helpView.render(c);
    //if (gameState == GameState.CREDITS) creditsView.render(c);
  }

  void update(double t) {
    if(gameState == GameState.MENU) homeView.update(t);

    if(gameState == GameState.PLAYING) playView.update(t);
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 10;

    background?.resize();

    //highScoreDisplay?.resize();
    //scoreDisplay?.resize();

    homeView?.resize();
    lostView?.resize();

    musicButton?.resize();
    soundButton?.resize();
  }

  void onTapDown(TapDownDetails d) {
    bool isHandled = false;

    homeView.onTapDown(d);
    playView.onTapDown(d);
    lostView.onTapDown(d);

    // Music button
    if(!isHandled && musicButton.rect.contains(d.globalPosition)) {
      musicButton.onTapDown();
      isHandled = true;
    }

    // Sound button
    if(!isHandled && soundButton.rect.contains(d.globalPosition)) {
      soundButton.onTapDown();
      isHandled = true;
    }
  }

  Function() showHelp;
  Function() showCredits;
}