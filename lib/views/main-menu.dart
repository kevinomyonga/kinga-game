import 'package:flutter/material.dart';
import 'package:kinga/controllers/game_controller.dart';
import 'package:kinga/game.dart';
import 'package:kinga/views/about.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {

  //GameController gameController;

  @override
  void initState() {
    super.initState();
    //gameController = GameController(startView: GameView.MainMenuBackground);
    //gameController.blockResize = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          //gameController.widget,
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Kinga",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      letterSpacing: 6,
                      color: Colors.white),
                ),
                RaisedButton(
                    child: Text("Play"),
                    onPressed: () async {
                      //gameController.pauseGame = true; //Stop anything in our background
                      await Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => GameWidget()));
                      //gameController.pauseGame = false; //Restart it when the screen finishes
                    }),
                RaisedButton(
                    child: Text("Options"),
                    onPressed: () async {
                      //gameController.pauseGame = true; //Stop anything in our background
                      /*await Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => OptionScreen()));*/
                      //gameController.pauseGame = false;
                    }),
                RaisedButton(
                    child: Text("About"),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext buildContext) {
                            return AboutGameDialog();
                          });
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }
}