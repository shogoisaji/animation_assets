import 'dart:math';
import 'dart:ui';

import 'package:animation_assets/config/config.dart';
import 'package:animation_assets/models/ball.dart';
import 'package:animation_assets/models/ball_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vector_math/vector_math.dart' as vector;

const colors = [
  Colors.red,
  Colors.green,
  Colors.blue,
  Colors.yellow,
  Colors.pink
];

class ReflectPage extends HookConsumerWidget {
  ReflectPage({super.key});

  final ball = Ball(
      radius: 20.0,
      velocity: vector.Vector2(
          Random().nextDouble() * 30, Random().nextDouble() * 20),
      position: vector.Vector2(30.0, 30.0),
      color: colors[Random().nextInt(3)]);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final velocity = useState(ball.velocity);
    final position = useState(ball.position);
    final isMoving = useState(false);
    final shuffle = useState(false);

    final animationController = useAnimationController(
        duration: const Duration(seconds: 1), vsync: useSingleTickerProvider());

    void animationSwitch() {
      if (isMoving.value) {
        animationController.stop();
      } else {
        animationController.repeat();
      }
    }

    void objectShuffle() {
      velocity.value = vector.Vector2(
          Random().nextDouble() * 20, Random().nextDouble() * 20);
      ball.color = colors[Random().nextInt(3)];
    }

    void update() {
      Rect bounds = Rect.fromLTRB(
          0,
          0,
          MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height -
              APP_BAR_HEIGHT -
              BOTTOM_NAVIGATION_BAR_HEIGHT);
      position.value += velocity.value;

      if (position.value.x < ball.radius ||
          position.value.x > bounds.width - ball.radius) {
        velocity.value = vector.Vector2(-velocity.value.x, velocity.value.y);
      }

      if (position.value.y < ball.radius ||
          position.value.y > bounds.height - ball.radius) {
        velocity.value = vector.Vector2(velocity.value.x, -velocity.value.y);
      }
    }

    useEffect(() {
      objectShuffle();
      animationController.addListener(() {
        update();
      });
      return null;
    }, [shuffle.value]);

    return Stack(children: [
      Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height -
                APP_BAR_HEIGHT -
                BOTTOM_NAVIGATION_BAR_HEIGHT,
            color: Colors.grey,
            child: CustomPaint(
              painter: BallPainter(ball.radius, position.value, ball.color),
            )),
      ),
      Center(
        child: Text(
            '${velocity.value.x.abs().toStringAsFixed(2)} : ${velocity.value.y.abs().toStringAsFixed(2)}',
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 48,
                color: Colors.white)),
      ),
      Positioned(
          bottom: 24,
          left: 24,
          child: ElevatedButton(
              child: isMoving.value ? const Text('Stop') : const Text('Start'),
              onPressed: () {
                animationSwitch();

                isMoving.value = !isMoving.value;
              })),
      Positioned(
          bottom: 64,
          left: 24,
          child: ElevatedButton(
              child: Text('Shuffle'),
              onPressed: () {
                shuffle.value = !shuffle.value;
              })),
    ]);
  }
}
