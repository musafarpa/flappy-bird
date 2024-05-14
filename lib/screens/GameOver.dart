import 'package:flappy_brid/game/flappyBird.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../game/assets.dart';

class GameOverScreen extends StatelessWidget {
  final FlappyBirdGame game;
  static const String id = 'gameOver';
  const GameOverScreen({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(Assets.gameOver),
          const SizedBox(height: 20,),
            ElevatedButton(onPressed: onRestart,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text("Restart",style: TextStyle(fontSize: 20)),)
          ],
        ),
      ),
    );
  }
  void onRestart(){
    game.bird.reset();
    game.overlays.remove('GameOver');
    game.resumeEngine();
  }
}
