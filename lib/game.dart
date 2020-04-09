import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/res/strings.dart';
import 'package:kinga/views/about-view.dart';
import 'package:kinga/views/help-view.dart';
import 'package:rate_my_app/rate_my_app.dart';

class GameWidget extends StatefulWidget {
  @override
  _GameWidgetState createState() => _GameWidgetState();
}

class _GameWidgetState extends State<GameWidget> {

  GameController gameController;

  _GameWidgetState() {
    gameController = new GameController();
  }

  RateMyApp _rateMyApp = RateMyApp(
    preferencesPrefix: 'rateMyApp_',
    minDays: 3,
    minLaunches: 7,
    remindDays: 2,
    remindLaunches: 5,
    appStoreIdentifier: '1506422810',
    googlePlayIdentifier: 'com.knoeyes.games.kinga',
  );

  @override
  void initState() {
    super.initState();
    gameController.showHelp = () {
      showDialog(
          context: context,
          builder: (BuildContext buildContext) {
            return HelpDialog();
          });
    };
    gameController.showCredits = () {
      showDialog(
          context: context,
          builder: (BuildContext buildContext) {
            return AboutGameDialog();
          });
    };

    showRatingDialog();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Stack(children: <Widget>[
        gameController.widget,
      ]),
    );
  }

  void showRatingDialog() {
    _rateMyApp.init().then((_) {
      if(_rateMyApp.shouldOpenDialog) {
        _rateMyApp.showRateDialog(
          context,
          title: AppStrings.ard_title,
          message: AppStrings.ard_message, // The dialog message.
          rateButton: AppStrings.ard_rateButton, // The dialog "rate" button text.
          noButton: AppStrings.ard_noButton, // The dialog "no" button text.
          laterButton: AppStrings.ard_laterButton, // The dialog "later" button text.
          listener: (button) { // The button click listener (useful if you want to cancel the click event).
            switch(button) {
              case RateMyAppDialogButton.rate:
                //print('Clicked on "Rate".');
                break;
              case RateMyAppDialogButton.later:
                //print('Clicked on "Later".');
                break;
              case RateMyAppDialogButton.no:
                //print('Clicked on "No".');
                break;
            }

            return true; // Return false if you want to cancel the click event.
          },
          ignoreIOS: false, // Set to false if you want to show the native Apple app rating dialog on iOS.
          dialogStyle: DialogStyle(), // Custom dialog styles.
          onDismissed: () => _rateMyApp.callEvent(RateMyAppEventType.laterButtonPressed), // Called when the user dismissed the dialog (either by taping outside or by pressing the "back" button).
          // actionsBuilder: (_) => [], // This one allows you to use your own buttons.
        );
      }
    });
  }
}