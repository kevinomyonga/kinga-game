import 'package:kinga/res/Ids.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameData {

  final SharedPreferences prefs;

  GameData(this.prefs);

  // HighScore
  void updateHighScore(int score) {
    int currentScore = prefs.getInt(Ids.sharedPrefHighScore) ?? 0;

    if (score > currentScore) {
      prefs.setInt(Ids.sharedPrefHighScore, score);
    }
  }

  int getHighScore() {
    return prefs.getInt(Ids.sharedPrefHighScore) ?? 0;
  }

  // Recent Score
  int getLastSubmittedScore() {
    return prefs.getInt(Ids.sharedPrefLastScore) ?? 0;
  }

  void setLastSubmittedScore(int score) {
    prefs.setInt(Ids.sharedPrefLastScore, score);
  }

  // Music
  bool isMusicEnabled() {
    bool soundsEnabled = prefs.getBool(Ids.sharedPrefMusic);
    if (soundsEnabled == null) return true;
    return soundsEnabled;
  }

  void setMusicEnabled(bool soundsEnabled) {
    prefs.setBool(Ids.sharedPrefMusic, soundsEnabled);
  }

  // SFX
  bool isSoundEnabled() {
    bool soundsEnabled = prefs.getBool(Ids.sharedPrefSound);
    if (soundsEnabled == null) return true;
    return soundsEnabled;
  }

  void setSoundEnabled(bool soundsEnabled) {
    prefs.setBool(Ids.sharedPrefSound, soundsEnabled);
  }
}