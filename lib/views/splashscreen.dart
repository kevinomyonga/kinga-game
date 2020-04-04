import 'package:flame_splash_screen/flame_splash_screen.dart';
import 'package:flutter/material.dart';

class SplashScreenGame extends StatefulWidget {
  @override
  _SplashScreenGameState createState() => _SplashScreenGameState();
}

class _SplashScreenGameState extends State<SplashScreenGame> {

  FlameSplashController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlameSplashScreen(
        showBefore: (BuildContext context) {
          return const Text("Before logo");
        },
        showAfter: (BuildContext context) {
          return const Text("After logo");
        },
        theme: FlameSplashTheme.dark,
        onFinish: (context) => Navigator.pop(context),
      ),
    );
  }
}