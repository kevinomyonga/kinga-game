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
  static final String iOSLeaderBoardID        = "kinga_players";
  static final String androidLeaderBoardID    = "CgkI05XRpZoEEAIQBw";

  // Ad Mob
  static final String adMobAppID              = FirebaseAdMob.testAppId;
  static final String rewardAdUnitID          = RewardedVideoAd.testAdUnitId;
}