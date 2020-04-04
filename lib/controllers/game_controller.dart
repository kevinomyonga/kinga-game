import 'dart:math';
import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:kinga/bgm.dart';
import 'package:kinga/components/back-button.dart';
import 'package:kinga/components/backdrop.dart';
import 'package:kinga/components/credits-button.dart';
import 'package:kinga/components/enemy.dart';
import 'package:kinga/components/health_bar.dart';
import 'package:kinga/components/help-button.dart';
import 'package:kinga/components/highscore_display.dart';
import 'package:kinga/components/music-button.dart';
import 'package:kinga/components/player.dart';
import 'package:kinga/components/score_text.dart';
import 'package:kinga/components/sound-button.dart';
import 'package:kinga/components/start_button.dart';
import 'package:kinga/controllers/enemy_spawner.dart';
import 'package:kinga/game_state.dart';
import 'package:kinga/main.dart';
import 'package:kinga/views/home-view.dart';
import 'package:kinga/views/lost-view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameController extends Game with TapDetector {

  SharedPreferences storage;
  Random rand;
  Size screenSize;
  double tileSize;

  Backdrop background;
  Player player;
  HealthBar healthBar;
  int score;
  ScoreDisplay scoreDisplay;
  HighScoreDisplay highScoreDisplay;

  EnemySpawner enemySpawner;
  List<Enemy> enemies;

  GameState gameState = GameState.MENU;
  StartButton startButton;
  BackButton backButton;
  MusicButton musicButton;
  SoundButton soundButton;
  HelpButton helpButton;
  CreditsButton creditsButton;

  HomeView homeView;
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
    highScoreDisplay = HighScoreDisplay(this);
    startButton = StartButton(this);
    backButton = BackButton(this);
    musicButton = MusicButton(this);
    soundButton = SoundButton(this);
    helpButton = HelpButton(this);
    creditsButton = CreditsButton(this);

    rand = Random();
    player = Player(this);
    enemies = List<Enemy>();
    enemySpawner = EnemySpawner(this);

    homeView = HomeView(this);
    lostView = LostView(this);

    // Play Menu Music
    BGM.play(BGMType.HOME);
  }

  void render(Canvas c) {
    /*Rect background = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint backgroundPaint = Paint()..color = Color(0xFFFAFAFA);
    c.drawRect(background, backgroundPaint);*/

    background.render(c);

    if (gameState == GameState.MENU) homeView.render(c);

    if(gameState == GameState.MENU) {
      startButton.render(c);
      highScoreDisplay.render(c);
      helpButton.render(c);
      creditsButton.render(c);
    }

    if(gameState == GameState.PLAYING) {
      // Render Player
      player.render(c);

      enemies.forEach((Enemy enemy) => enemy.render(c));
      scoreDisplay.render(c);
      healthBar.render(c);
    }

    if (gameState == GameState.GAME_OVER) {
      lostView.render(c);
      backButton.render(c);
    }

    musicButton.render(c);
    soundButton.render(c);

    //if (gameState == GameState.HELP) helpView.render(c);
    //if (gameState == GameState.CREDITS) creditsView.render(c);
  }

  void update(double t) {
    if(gameState == GameState.MENU) {
      startButton.update(t);
      highScoreDisplay.update(t);
    }

    if(gameState == GameState.PLAYING) {
      enemySpawner.update(t);
      enemies.forEach((Enemy enemy) => enemy.update(t));
      enemies.removeWhere((Enemy enemy) => enemy.isDead);
      player.update(t);
      scoreDisplay.update(t);
      healthBar.update(t);
    }
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 10;

    background?.resize();

    //highScoreDisplay?.resize();
    //scoreDisplay?.resize();

    homeView?.resize();
    lostView?.resize();

    startButton?.resize();
    backButton?.resize();
    helpButton?.resize();
    creditsButton?.resize();
    musicButton?.resize();
    soundButton?.resize();
  }

  void onTapDown(TapDownDetails d) {
    bool isHandled = false;

    // Start Button
    if (!isHandled && startButton.rect.contains(d.globalPosition)) {
      if (gameState == GameState.MENU) {
        startButton.onTapDown();
        isHandled = true;
      }
    }

    // Back Button
    if (!isHandled && backButton.rect.contains(d.globalPosition)) {
      if (gameState == GameState.GAME_OVER) {
        backButton.onTapDown();
        isHandled = true;
      }
    }

    // Help button
    if (!isHandled && helpButton.rect.contains(d.globalPosition)) {
      if (gameState == GameState.MENU || gameState == GameState.GAME_OVER) {
        helpButton.onTapDown();
        isHandled = true;
      }
    }

    // Credits button
    if (!isHandled && creditsButton.rect.contains(d.globalPosition)) {
      if (gameState == GameState.MENU || gameState == GameState.GAME_OVER) {
        creditsButton.onTapDown();
        isHandled = true;
      }
    }

    // Destroying Enemies
    if(gameState == GameState.PLAYING) {
      enemies.forEach((Enemy enemy) {
        if (enemy.enemyRect.contains(d.globalPosition)) {
          enemy.onTapDown();
          isHandled = true;
        }
      });
    }

    // Music button
    if (!isHandled && musicButton.rect.contains(d.globalPosition)) {
      musicButton.onTapDown();
      isHandled = true;
    }

    // Sound button
    if (!isHandled && soundButton.rect.contains(d.globalPosition)) {
      soundButton.onTapDown();
      isHandled = true;
    }

    // Dialog boxes
    if (!isHandled) {
      if (gameState == GameState.HELP || gameState == GameState.CREDITS) {
        gameState = GameState.MENU;
        isHandled = true;
      }
    }
  }

  void spawnEnemy() {
    double x,y;
    switch(rand.nextInt(4)) {
      case 0:
      // Top
        x = rand.nextDouble() * screenSize.width;
        y = -tileSize * 2.5;
        break;
      case 1:
      // Right
        x = screenSize.width + tileSize * 2.5;
        y = rand.nextDouble() * screenSize.height;
        break;
      case 2:
      // Bottom
        x = rand.nextDouble() * screenSize.width;
        y = screenSize.height + tileSize * 2.5;
        break;
      case 3:
      // Left
        x = -tileSize * 2.5;
        y = rand.nextDouble() * screenSize.height;
        break;
    }
    enemies.add(Enemy(this, x, y));
  }

  Function() showHelp;
  Function() showCredits;
}