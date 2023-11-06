import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart';

class BallPainter extends CustomPainter {
  final double radius;
  final Vector2 position;
  final Color color;

  BallPainter(this.radius, this.position, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Offset offset = Offset(position.x, position.y);
    var paint = Paint()
      ..isAntiAlias = true
      ..color = color;
    canvas.drawCircle(
      offset,
      radius,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
