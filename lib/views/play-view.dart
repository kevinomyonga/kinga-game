import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kinga/components/enemy.dart';
import 'package:kinga/components/flies/agile-fly.dart';
import 'package:kinga/components/flies/drooler-fly.dart';
import 'package:kinga/components/flies/house-fly.dart';
import 'package:kinga/components/flies/hungry-fly.dart';
import 'package:kinga/components/flies/macho-fly.dart';
import 'package:kinga/components/health_bar.dart';
import 'package:kinga/components/player.dart';
import 'package:kinga/components/score_text.dart';
import 'package:kinga/controllers/enemy_spawner.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/game_state.dart';

class PlayView {

  final GameController gameController;

  PlayView(this.gameController) {
    resize();
  }

  void render(Canvas c) {
    // Render Player
    gameController.player.render(c);

    gameController.enemies.forEach((Enemy enemy) => enemy.render(c));
    gameController.scoreDisplay.render(c);
    gameController.healthBar.render(c);
  }

  void update(double t) {
    gameController.enemySpawner.update(t);
    gameController.enemies.forEach((Enemy enemy) => enemy.update(t));
    gameController.enemies.removeWhere((Enemy enemy) => enemy.isDead && enemy.isOffScreen);
    gameController.player.update(t);
    gameController.scoreDisplay.update(t);
    gameController.healthBar.update(t);
  }

  void resize() {
  }

  void onTapDown(TapDownDetails d) {
    bool isHandled = false;

    // Destroying Enemies
    if(gameController.gameState == GameState.PLAYING) {
      gameController.enemies.forEach((Enemy enemy) {
        if (enemy.enemyRect.contains(d.globalPosition)) {
          enemy.onTapDown();
          isHandled = true;
        }
      });
    }
  }

  void spawnEnemy() {
    // Set where enemy will spawn from
    double x,y;
    switch(gameController.rand.nextInt(4)) {
      case 0:
      // Top
        x = gameController.rand.nextDouble() * gameController.screenSize.width;
        y = -gameController.tileSize * 2.5;
        break;
      case 1:
      // Right
        x = gameController.screenSize.width + gameController.tileSize * 2.5;
        y = gameController.rand.nextDouble() * gameController.screenSize.height;
        break;
      case 2:
      // Bottom
        x = gameController.rand.nextDouble() * gameController.screenSize.width;
        y = gameController.screenSize.height + gameController.tileSize * 2.5;
        break;
      case 3:
      // Left
        x = -gameController.tileSize * 2.5;
        y = gameController.rand.nextDouble() * gameController.screenSize.height;
        break;
    }

    // Type of enemy spawned
    switch (gameController.rand.nextInt(5)) {
      case 0:
        gameController.enemies.add(HouseFly(gameController, x, y));
        break;
      case 1:
        gameController.enemies.add(DroolerFly(gameController, x, y));
        break;
      case 2:
        gameController.enemies.add(AgileFly(gameController, x, y));
        break;
      case 3:
        gameController.enemies.add(MachoFly(gameController, x, y));
        break;
      case 4:
        gameController.enemies.add(HungryFly(gameController, x, y));
        break;
    }
  }
}