import 'dart:math';
import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flutter/widgets.dart';
import 'package:kinga/components/buttons/pause-button.dart';
import 'package:kinga/components/enemy.dart';
import 'package:kinga/components/flies/agile-fly.dart';
import 'package:kinga/components/flies/drooler-fly.dart';
import 'package:kinga/components/flies/house-fly.dart';
import 'package:kinga/components/flies/hungry-fly.dart';
import 'package:kinga/components/flies/macho-fly.dart';
import 'package:kinga/components/player-health-bar.dart';
import 'package:kinga/components/player.dart';
import 'package:kinga/components/text/score-display.dart';
import 'package:kinga/controllers/enemy_spawner.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/game_state.dart';
import 'package:kinga/res/assets.dart';

class PlayView {

  final GameController gameController;

  Player player;
  HealthBar healthBar;
  int score;
  ScoreDisplay scoreDisplay;

  Random rand;
  EnemySpawner enemySpawner;
  List<Enemy> enemies;

  PauseButton pauseButton;

  PlayView(this.gameController) {
    resize();

    initialize();
  }

  void initialize() {
    healthBar = HealthBar(gameController);
    score = 0;
    scoreDisplay = ScoreDisplay(gameController);
    player = Player(gameController);

    rand = gameController.rand;
    enemies = gameController.enemies;
    enemySpawner = gameController.enemySpawner;

    pauseButton = PauseButton(gameController);
  }

  void render(Canvas c) {
    // Render Player
    player.render(c);

    // Render Enemies
    enemies.forEach((Enemy enemy) => enemy.render(c));

    // Render Health And Score Displays
    scoreDisplay.render(c);
    healthBar.render(c);

    // Render Pause Game Button
    pauseButton.render(c);
  }

  void update(double t) {
    // Check if game is paused
    if (gameController.gameState == GameState.PAUSED) {
      return;
    }

    // Update Player
    player.update(t);

    // Update Enemies
    enemySpawner.update(t);
    enemies.forEach((Enemy enemy) => enemy.update(t));
    enemies.removeWhere((Enemy enemy) => enemy.isDead && enemy.isOffScreen);

    // Update Health And Score Displays
    scoreDisplay.update(t);
    healthBar.update(t);

    // Render Pause Game Button
    pauseButton.update(t);
  }

  void resize() {
    pauseButton?.resize();
  }

  void onTapDown(TapDownDetails d) {

    // Destroying Enemies
    if(gameController.gameState == GameState.PLAYING) {
      enemies.forEach((Enemy enemy) {
        if (enemy.enemyRect.contains(d.globalPosition)) {
          enemy.onTapDown();
        }
      });
    }
  }

  void onTapUp(TapUpDetails d) {

    // Pause/Resume Button
    if(!gameController.isHandled && pauseButton.rect.contains(d.globalPosition)) {
      pauseButton.onTapUp();
      gameController.isHandled = true;
    }
  }

  void spawnEnemy() {
    // Set where enemy will spawn from
    double x,y;
    switch(rand.nextInt(4)) {
      case 0:
      // Top
        x = rand.nextDouble() * gameController.screenSize.width;
        y = -gameController.tileSize * 2.5;
        break;
      case 1:
      // Right
        x = gameController.screenSize.width + gameController.tileSize * 2.5;
        y = rand.nextDouble() * gameController.screenSize.height;
        break;
      case 2:
      // Bottom
        x = rand.nextDouble() * gameController.screenSize.width;
        y = gameController.screenSize.height + gameController.tileSize * 2.5;
        break;
      case 3:
      // Left
        x = -gameController.tileSize * 2.5;
        y = rand.nextDouble() * gameController.screenSize.height;
        break;
    }

    // Type of enemy spawned
    switch (rand.nextInt(5)) {
      case 0:
        enemies.add(HouseFly(gameController, x, y));
        break;
      case 1:
        enemies.add(DroolerFly(gameController, x, y));
        break;
      case 2:
        enemies.add(AgileFly(gameController, x, y));
        break;
      case 3:
        enemies.add(MachoFly(gameController, x, y));
        break;
      case 4:
        enemies.add(HungryFly(gameController, x, y));
        break;
    }
  }

  void endGame() {
    // End game
    gameController.gameState = GameState.GAME_OVER;

    // Reset game
    gameController.initialize();
    if (gameController.soundButton.isEnabled) {
      Flame.audio.play(Assets.enemyHaha);
    }
  }
}