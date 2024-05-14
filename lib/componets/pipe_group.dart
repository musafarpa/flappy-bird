import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flappy_brid/componets/pipe.dart';
import 'package:flappy_brid/game/configuration.dart';
import 'package:flappy_brid/game/flappyBird.dart';

import '../game/assets.dart';
import '../game/pipe_position.dart';
import 'dart:math';

class PipeGroup extends PositionComponent with HasGameRef<FlappyBirdGame> {
  PipeGroup();



  final _random = Random();

  @override
  Future<void> onLoad() async {
    position.x = gameRef.size.x;

    final heightMinusGround = gameRef.size.y - Config.groundHeight;
    final Spacing = 100 + _random.nextDouble() *(heightMinusGround / 4);
    final centerY = Spacing + _random.nextDouble() * (heightMinusGround - Spacing);
    addAll([
      pipe(pipePosition: PipePosition.top, height: centerY - Spacing / 2),
      pipe(pipePosition: PipePosition.bottom,
          height: heightMinusGround- (centerY + Spacing / 2)),

    ]);
  }
  @override
  void update(double dt){
    super.update(dt);
    position.x -=Config.gameSpeed * dt;

    if (position.x < -10) {
      removeFromParent();
      UpdateScore();
    }
    if (gameRef.isHit){
      removeFromParent();
      gameRef.isHit = false;
    }

  }
  void UpdateScore(){
    gameRef.bird.score += 1;
    FlameAudio.play(Assets.point);
  }
}



