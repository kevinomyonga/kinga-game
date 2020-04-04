import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/widgets.dart';
import 'package:kinga/res/assets.dart';

class BGM {

  static AudioCache home;
  static AudioCache playing;
  static BGMType current;
  static bool isPaused = false;
  static bool isInitialized = false;

  static Future<void> preload() async {
    home = AudioCache(prefix: 'audio/', fixedPlayer: AudioPlayer());
    await home.load(Assets.bgm);
    await home.fixedPlayer.setReleaseMode(ReleaseMode.LOOP);

    playing = AudioCache(prefix: 'audio/', fixedPlayer: AudioPlayer());
    await playing.load(Assets.playing);
    await playing.fixedPlayer.setReleaseMode(ReleaseMode.LOOP);

    isInitialized = true;
  }

  static Future<void> _update() async {
    if (!isInitialized) return;
    if (current == null) return;

    if (isPaused) {
      if (current == BGMType.HOME) await home.fixedPlayer.pause();
      if (current == BGMType.PLAYING) await home.fixedPlayer.pause();
    } else {
      if (current == BGMType.HOME) await home.fixedPlayer.resume();
      if (current == BGMType.PLAYING) await home.fixedPlayer.resume();
    }
  }

  static Future<void> play(BGMType what) async {
    if (current != what) {
      if (what == BGMType.HOME) {
        current = BGMType.HOME;
        await playing.fixedPlayer.stop();
        await home.loop(Assets.bgm, volume: .25);
      }
      if (what == BGMType.PLAYING) {
        current = BGMType.PLAYING;
        await playing.fixedPlayer.stop();
        await home.loop(Assets.playing, volume: .25);
      }
    }
    _update();
  }

  static void pause() {
    isPaused = true;
    _update();
  }

  static void resume() {
    isPaused = false;
    _update();
  }
}

class BGMHandler extends WidgetsBindingObserver {
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      BGM.resume();
    } else {
      BGM.pause();
    }
  }
}

enum BGMType {
  HOME,
  PLAYING,
}