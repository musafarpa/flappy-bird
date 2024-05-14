//
// import 'package:flame/collisions.dart';
// import 'package:flame/components.dart';
// import 'package:flame/effects.dart';
// import 'package:flutter/animation.dart';
//
// import '../game/assets.dart';
// import '../game/brid_movement.dart';
// import '../game/configuration.dart';
// import '../game/flappyBird.dart';
//
// class Bird extends SpriteGroupComponent <BridMovement>
// with HasGameRef <FlappyBirdGame> CollisionCallbacks{
// Bird();
//
//   @override
//   Future<void> onLoad() async {
//    final birdMidFlap = await gameRef.loadSprite(Assets.birdMidFlap);
//    final birdUpFlap = await gameRef.loadSprite(Assets.birdUpFlap);
//    final birdDownFlap = await gameRef.loadSprite(Assets.birdDownFlap);
//
//
//     size = Vector2(50, 50);
//     position = Vector2(50, gameRef.size.y / 2 - size.y / 2);
//     current = BridMovement.middle;
//     sprites = {
//       BridMovement.middle : birdMidFlap,
//       BridMovement.up : birdUpFlap,
//       BridMovement.down: birdDownFlap,
//     };
//
//     add(CircleHitbox());
//   }
// void Fly() {
//     add(
//       MoveByEffect(Vector2(0, Config.gravity),
//         EffectController(duration: 0.2, curve: Curves.decelerate),
//         onComplete: () => current = BridMovement.down ,
//       )
//     );
//     current = BridMovement.up;
// }
//   @override
//   void onCollisionStart(
//       Set<Vector2> intersectionPoints,
//       PositionComponent other,
//       ) {
//     super.onCollisionStart(intersectionPoints, other);
//
//
//   }
//
//   @override
//   void update(double dt) {
//     super.update(dt);
//     position.y += Config.birdVelocity * dt;
//   }
//
// }




import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_audio/flame_audio.dart';

import 'package:flutter/material.dart';

import '../game/assets.dart';
import '../game/brid_movement.dart';
import '../game/configuration.dart';
import '../game/flappyBird.dart';

class Bird extends SpriteGroupComponent<BridMovement>
    with HasGameRef<FlappyBirdGame>, CollisionCallbacks {
  Bird();

  int score = 0;

  @override
  Future<void> onLoad() async {
    final birdMidFlap = await gameRef.loadSprite(Assets.birdMidFlap);
    final birdUpFlap = await gameRef.loadSprite(Assets.birdUpFlap);
    final birdDownFlap = await gameRef.loadSprite(Assets.birdDownFlap);


    size = Vector2(50, 50);
    position = Vector2(50, gameRef.size.y / 2 - size.y / 2);
    current = BridMovement.middle;
    sprites = {
      BridMovement.middle : birdMidFlap,
      BridMovement.up : birdUpFlap,
      BridMovement.down: birdDownFlap,
    };

    add(CircleHitbox());
  }


  @override
  void update(double dt) {
    super.update(dt);
    position.y += Config.birdVelocity * dt;
    if (position.y < 1) {

    }
  }

  void Fly() {
    add(
      MoveByEffect(Vector2(0, Config.gravity),
        EffectController(duration: 0.2, curve: Curves.decelerate),
        onComplete: () => current = BridMovement.down ,
      )
    );
    current = BridMovement.up;
    FlameAudio.play(Assets.flying);
}

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints,
      PositionComponent other,
      ) {
    super.onCollisionStart(intersectionPoints, other);
    GameOver();
  }

  void reset(){
    position = Vector2(50,gameRef.size.y / 2 - size.y / 2);
    score = 0;
  }

  void GameOver(){
    FlameAudio.play(Assets.collision);
    gameRef.overlays.add('GameOver');
    gameRef.pauseEngine();
    game.isHit = true;
  }

  // @override
  // void update(double dt) {
  //   super.update(dt);
  //   score.text = 'Score: ${bird.score}';
  // }


// void reset() {
  //   position = Vector2(50, gameRef.size.y / 2 - size.y / 2);
  //   score = 0;
  // }


}
