import 'package:flame/game.dart';
import 'package:flappy_brid/screens/GameOver.dart';
import 'package:flappy_brid/screens/menu_screen.dart';
import 'package:flutter/material.dart';

import 'game/flappyBird.dart';

void main() {

  final game = FlappyBirdGame();
  runApp(
    GameWidget(game: game,
      initialActiveOverlays: const [MainMenuScreen.id],
      overlayBuilderMap: {
        'mainMenu': (context, _) => MainMenuScreen(game: game),
        'GameOver': (context, _) => GameOverScreen(game: game),

      },),


  );
}

