import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart';

class Ball {
  Vector2 position;
  Vector2 velocity;
  double radius;
  Color color;

  Ball({
    required this.radius,
    required this.velocity,
    required this.position,
    required this.color,
  });

  void update(Rect bounds) {
    position += velocity;

    if (position.x < radius || position.x > bounds.width - radius) {
      velocity = Vector2(-velocity.x, velocity.y);
    }

    if (position.y < radius || position.y > bounds.height - radius) {
      velocity = Vector2(velocity.x, -velocity.y);
    }
  }

  void render(Canvas canvas) {
    Offset offset = Offset(position.x, position.y);
    canvas.drawCircle(offset, radius, Paint()..color = color);
  }
}
