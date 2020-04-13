import 'package:kinga/res/Ids.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameData {

  static void updateScore(int score) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int currentScore = prefs.getInt(Ids.sharedPrefHighScore) ?? 0;

    if (score > currentScore) {
      await prefs.setInt(Ids.sharedPrefHighScore, score);
    }
  }

  static Future<int> getScore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(Ids.sharedPrefHighScore) ?? 0;
  }

  static void updateCoins(int coins) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("coins", coins);
  }

  static Future<int> getCoins() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt("coins") ?? 0;
  }

  static Future<bool> isMusicEnabled() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool soundsEnabled = prefs.getBool(Ids.sharedPrefMusic);

    if (soundsEnabled == null) return true;

    return soundsEnabled;
  }

  static Future<void> setMusicEnabled(bool soundsEnabled) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(Ids.sharedPrefMusic, soundsEnabled);
  }

  static Future<bool> isSoundsEnabled() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool soundsEnabled = prefs.getBool(Ids.sharedPrefSound);

    if (soundsEnabled == null) return true;

    return soundsEnabled;
  }

  static Future<void> setSoundsEnabled(bool soundsEnabled) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(Ids.sharedPrefSound, soundsEnabled);
  }

  static Future<String> playerId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("playerId");
  }

  static Future<void> setPlayerId(String playerId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString("playerId", playerId);
  }

  static Future<int> getLastSubmittedScore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getInt(Ids.sharedPrefCurrentScore) ?? 0;
  }

  static Future<void> setLastSubmittedScore(int score) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setInt(Ids.sharedPrefCurrentScore, score);
  }
}