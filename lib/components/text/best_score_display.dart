import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:games_services/games_services.dart';
import 'package:games_services/score.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/game_data.dart';
import 'package:kinga/res/Ids.dart';
import 'package:kinga/res/assets.dart';
import 'package:kinga/res/strings.dart';

class BestScoreDisplay {

  final GameController gameController;
  TextPainter painter;
  Offset position;

  BestScoreDisplay(this.gameController) {

    painter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    position = Offset.zero;
  }

  void render(Canvas c) {
    painter.paint(c, position);
  }

  Future<void> update(double t) async {
    int currentScore = await GameData.getLastSubmittedScore();
    int highScore = await GameData.getScore();

    if(currentScore > highScore) {
      gameController.isNewHighScore = true;

      // Update HighScore
      GameData.updateScore(currentScore);

      // Submit HighScore to LeaderBoard
      GamesServices.submitScore(
          score: Score(
              androidLeaderboardID: Ids.androidLeaderBoardID,
              iOSLeaderboardID: Ids.iOSLeaderBoardID,
              value: currentScore)
      );
    }

    Shadow shadow = Shadow(
      blurRadius: gameController.tileSize * .0625,
      color: Colors.black,
      offset: Offset.zero,
    );

    painter.text = TextSpan(
      text: AppStrings.bestScore + ': $highScore',
      style: TextStyle(
        color: Colors.white,
        fontFamily: Assets.fontEquestria,
        fontSize: gameController.tileSize * .75,
        shadows: <Shadow>[shadow, shadow, shadow, shadow, shadow, shadow, shadow, shadow],
      ),
    );
    painter.layout();

    position = Offset(
      (gameController.screenSize.width / 2) - (painter.width / 2),
      gameController.tileSize * 9,
    );
  }
}