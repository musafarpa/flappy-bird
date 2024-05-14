import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flappy_brid/componets/background.dart';
import 'package:flappy_brid/componets/ground.dart';
import 'package:flappy_brid/componets/pipe_group.dart';
import 'package:flappy_brid/game/configuration.dart';

import '../componets/brid.dart';

class FlappyBirdGame extends FlameGame with TapDetector, HasCollisionDetection {
  FlappyBirdGame();

  late Bird bird;
  late TextComponent score;
  bool isHit = false;

  @override
  Future<void> onLoad() async {
    addAll([
      Background(),
      Ground(),
      bird = Bird(),
      score = buildScore(),
    ]);
    // Create the initial PipeGroup
    add(PipeGroup());
    // Start adding PipeGroup periodically
    startAddingPipeGroups();
  }

  void startAddingPipeGroups() {
    addPipeGroup();
    // Delay for Config.pipeInterval seconds and then add another PipeGroup
    Future.delayed(Duration(seconds: Config.pipeInterval.toInt()), () {
      startAddingPipeGroups(); // Recursively call this method to add more PipeGroups
    });
  }

  void addPipeGroup() {
    add(PipeGroup());
  }

  TextComponent buildScore() {
    return TextComponent(
      text: "Score : 0",
      position: Vector2(size.x / 2, size.y / 2 * 0.2),
      anchor: Anchor.center,
    );
  }

  @override
  void onTap() {
    super.onTap();
    bird.Fly();
  }

  @override
  void update(double dt) {
    super.update(dt);
    score.text = 'Score: ${bird.score}';
  }
}
