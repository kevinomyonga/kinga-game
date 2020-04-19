import 'dart:io';

import 'package:firebase_admob/firebase_admob.dart';

class Ids {

  // App Identifiers
  static final String appStoreIdentifier      = "1506422810";
  static final String googlePlayIdentifier    = "com.knoeyes.games.kinga";

  // Shared Prefs Keys
  static final String sharedPrefHighScore     = 'highscore';
  static final String sharedPrefLastScore     = 'lastSubmittedScore';
  static final String sharedPrefMusic         = 'music';
  static final String sharedPrefSound         = 'sound';

  // Hero Tags
  static final String feedbackHeroTag         = "FeedbackTag";
  static final String shareAppHeroTag         = "ShareTag";

  // LeaderBoards
  static final String iOSLeaderBoardID        = "kinga_top_scorers";
  static final String androidLeaderBoardID    = "CgkI05XRpZoEEAIQBw";

  // Ad Mob
  //static final String adMobAppID              = FirebaseAdMob.testAppId;
  static final String adMobAppID              = Platform.isAndroid ? adMobAppIDAndroid : adMobAppIDiOS;
  static final String adMobAppIDAndroid       = 'ca-app-pub-9277082169404949~9918933766';
  static final String adMobAppIDiOS           = 'ca-app-pub-9277082169404949~8522091610';
  //static final String rewardAdUnitID          = RewardedVideoAd.testAdUnitId;
  static final String rewardAdUnitID          = Platform.isAndroid ? rewardAdUnitIDAndroid : rewardAdUnitIDiOS;
  static final String rewardAdUnitIDAndroid   = 'ca-app-pub-9277082169404949/1992982918';
  static final String rewardAdUnitIDiOS       = 'ca-app-pub-9277082169404949/8347472423';
}