import 'dart:io';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:games_services/games_services.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/res/Ids.dart';
import 'package:kinga/res/strings.dart';
import 'package:kinga/views/about-view.dart';
import 'package:kinga/views/help-view.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:share/share.dart';

// You can also test with your own ad unit IDs by registering your device as a
// test device. Check the logs for your device's ID value.
const String testDevice = '135986D75C1D9E9C63566BD16C02DFD7';

class GameWidget extends StatefulWidget {
  @override
  _GameWidgetState createState() => _GameWidgetState();
}

class _GameWidgetState extends State<GameWidget> {

  // Ad Targeting Info
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevice != null ? <String>[testDevice] : null,
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    childDirected: true,
    nonPersonalizedAds: true,
  );

  int _coins = 0;

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
    appStoreIdentifier: Ids.appStoreIdentifier,
    googlePlayIdentifier: Ids.googlePlayIdentifier,
  );

  @override
  void initState() {
    super.initState();

    FirebaseAdMob.instance.initialize(appId: Ids.adMobAppID);

    RewardedVideoAd.instance.listener =
        (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
      print("RewardedVideoAd event $event");
      if (event == RewardedVideoAdEvent.rewarded) {
        setState(() {
          _coins += rewardAmount;
          print("RewardedVideoAd rewardAmount: $_coins");

          gameController.continueView.resumeGame();
        });
      }
    };

    gameController.loadRewardVideo = () {
      _loadRewardVideo();
    };

    gameController.showRewardVideo = () {
      _showRewardVideo();
    };

    // Sign in the user
    GamesServices.signIn();

    gameController.showHelp = () {
      showDialog(
          context: context,
          builder: (BuildContext buildContext) {
            return HelpDialog();
          });
    };
    /*gameController.showCredits = () {
      showDialog(
          context: context,
          builder: (BuildContext buildContext) {
            return AboutGameDialog();
          });
    };*/
    gameController.shareGame = () {
      _inviteFriend();
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

  // Launch an app selection popup to select the app to be used for sharing a link to KINGA
  _inviteFriend() {
    if(Platform.isAndroid) {
      Share.share('Check out the ${AppStrings.appName} Game here: ${AppStrings.url_play_store}');
    } else if (Platform.isIOS) {
      Share.share('Check out the ${AppStrings.appName} Game here: ${AppStrings.url_app_store}');
    }
  }

  _loadRewardVideo() {
    // Load Video
    RewardedVideoAd.instance.load(
        adUnitId: Ids.rewardAdUnitID,
        targetingInfo: targetingInfo);
  }

  _showRewardVideo() {
    // Show Video
    RewardedVideoAd.instance.show();
  }
}