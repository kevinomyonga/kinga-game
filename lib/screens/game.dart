import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:games_services/games_services.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/helpers/game_state.dart';
import 'package:kinga/res/Ids.dart';
import 'package:kinga/res/strings.dart';
import 'package:play_games/play_games.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

// You can also test with your own ad unit IDs by registering your device as a
// test device. Check the logs for your device's ID value.
//const String testDevice = '135986D75C1D9E9C63566BD16C02DFD7';
//const String testDevice2 = 'F37D4C1F59184DB1B44E9759A01795EA';

class GameWidget extends StatefulWidget {
  @override
  _GameWidgetState createState() => _GameWidgetState();
}

class _GameWidgetState extends State<GameWidget> {

  ScaffoldState scaffold;

  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  String appVersion;

  String deviceMake;
  String deviceModel;
  String deviceOSVersion;

  // Ad Targeting Info
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    //testDevices: testDevice != null ? <String>[testDevice, testDevice2] : null,
    childDirected: true,
    nonPersonalizedAds: true,
  );

  // Reward Ad Flags
  bool isRewarded = false;
  bool isVideoLoaded = false;

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

    // Set up Firebase AdMob
    FirebaseAdMob.instance.initialize(appId: Ids.adMobAppID);

    RewardedVideoAd.instance.listener =
        (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
      print("RewardedVideoAd event $event");
      if (event == RewardedVideoAdEvent.rewarded) {
        setState(() {
          isRewarded = true;
        });
      }
      if (event == RewardedVideoAdEvent.loaded) {
        setState(() {
          isVideoLoaded = true;
        });
      }
      // Resume the game if the reward has been issued
      if(event == RewardedVideoAdEvent.closed && isRewarded && gameController.gameState == GameState.CONTINUE) {
        gameController.continueView.resumeGame();
      }
      // End the game if the reward has been issued
      if(event == RewardedVideoAdEvent.closed && !isRewarded && gameController.gameState == GameState.CONTINUE) {
        gameController.playView.endGame();
      }
    };

    gameController.resetRewardFlag = () {
      setState(() {
        isRewarded = false;
        isVideoLoaded = false;
      });
    };

    gameController.loadRewardVideo = () {
      _loadRewardVideo();
    };

    gameController.showRewardVideo = () {
      _showRewardVideo();
    };

    // Sign in the user to the Service
    _signInToGameService();

    gameController.showLeaderBoard = () {
      _showLeaderBoard();
    };

    gameController.shareGame = () {
      _inviteFriend();
    };

    gameController.launchDeveloperWebsite = () {
      _launchDeveloperWebsite();
    };

    gameController.openDemoVideo = () {
      _launchDemoOnYoutube();
    };

    initPlatformState();
    gameController.sendFeedback = (appVersion) {
      this.appVersion = appVersion;
      _sendFeedback();
    };

    showRatingDialog();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Builder(
          builder: (BuildContext buildContext) {
            scaffold = Scaffold.of(buildContext);
            return Stack(children: <Widget>[
              gameController.widget,
            ]);
          },
        )
    );
  }

  // Sign in the user to the Service
  _signInToGameService() async {
    if(Platform.isAndroid) {
      SigninResult result = await PlayGames.signIn();
      if (result.success) {
        await PlayGames.setPopupOptions();
        print('Play Games Success: ${result.account}');
      } else {
        print('Play Games Fail: ${result.message}');
      }
    } else if (Platform.isIOS) {
      GamesServices.signIn();
    }
  }

  _showLeaderBoard() {
    if(Platform.isAndroid) {
      PlayGames.showLeaderboard(Ids.androidLeaderBoardID).catchError((e) {
        _signInToGameService();
      });
    } else if (Platform.isIOS) {
      GamesServices.showLeaderboards(
          iOSLeaderboardID: Ids.iOSLeaderBoardID
      ).catchError((e) {
        // Sign in the user just in case the first call failed.
        GamesServices.signIn();
      });
    }
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
  _inviteFriend() async {
    if(Platform.isAndroid) {
      Share.share('Check out the ${AppStrings.appName} Game here: ${AppStrings.url_play_store}');
    } else if (Platform.isIOS) {
      String shareText = 'Check out the ${AppStrings.appName} Game here: ${AppStrings.url_app_store}';
      bool isIpad = await _isIpad();
      if(isIpad) {
        // iPad
        // To be returned after testing on physical iPad
        /*Share.share(
          shareText,
          sharePositionOrigin: Rect.fromLTWH(
              MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height,
              100, 100),
        );*/
        _launchURL('mailto:?subject=${Uri.encodeComponent('KINGA Game')}&body=${Uri.encodeComponent(shareText)}');
      } else {
        // iPhone
        Share.share(shareText);
      }
    }
  }

  // Check if app is running on iPad
  Future<bool> _isIpad() async {
    final iosInfo = await DeviceInfoPlugin().iosInfo;
    return iosInfo.name.toLowerCase().contains('ipad');
  }

  // Load Video
  _loadRewardVideo() {
    RewardedVideoAd.instance.load(
        adUnitId: Ids.rewardAdUnitID,
        targetingInfo: targetingInfo);
  }

  // Show Video
  _showRewardVideo() {
    RewardedVideoAd.instance.show().catchError((e) {
      _loadRewardVideo();
      gameController.playView.player.showContinue(false);
      // Remove Current SnackBar (if any) to avoid having multiple popping up.
      scaffold.removeCurrentSnackBar();
      // Find the Scaffold in the widget tree and use
      // it to show a SnackBar.
      scaffold.showSnackBar(
          SnackBar(
            content: Text(AppStrings.continueErrorMsg),
            backgroundColor: Colors.red,
          )
      );
    });
  }

  // Launch a mail application to be used to send feedback to the developer
  _sendFeedback() {
    String subject = '${AppStrings.appName} Game Feedback';

    String body = "\bFeedback:\b  \n\n" +
        "\n\bApp Version:\b $appVersion " +
        "\n\bManufacturer:\b $deviceMake " +
        "\n\bDevice:\b $deviceModel " +
        "\n\bOS Version:\b $deviceOSVersion ";

    if(Platform.isAndroid) {
      _launchURL('mailto:${AppStrings.companyEmail}?subject=$subject&body=$body');
    } else if (Platform.isIOS) {
      _launchURL('mailto:${AppStrings.companyEmail}?subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}');
    }
  }

  Future<AndroidDeviceInfo> getAndroidDeviceInfo(deviceInfo) async {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return androidInfo;
  }

  Future<IosDeviceInfo> getIosInfo(deviceInfo) async {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    return iosInfo;
  }

  Future<void> initPlatformState() async {

    if(Platform.isAndroid) {
      getAndroidDeviceInfo(deviceInfoPlugin).then((androidInfo) {
        deviceMake = androidInfo.manufacturer;
        deviceModel = androidInfo.model;
        deviceOSVersion = androidInfo.version.sdkInt.toString();
      });
    } else if (Platform.isIOS) {
      getIosInfo(deviceInfoPlugin).then((iosInfo) {
        deviceMake = 'Apple';
        deviceModel = iosInfo.utsname.machine;
        deviceOSVersion = iosInfo.utsname.version;
      });
    }
  }

  // Launch a developer website
  _launchDeveloperWebsite() {
    _launchURL(AppStrings.url_my_website);
  }

  // Launch demo video on YouTube
  _launchDemoOnYoutube() {
    _launchURL(AppStrings.url_youtube_demo);
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}