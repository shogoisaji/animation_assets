import 'dart:math';

import 'package:flutter/material.dart';

class AnimateChild {
  final Widget childWidget;
  final Size childWidgetSize;
  Offset position;
  Offset velocity;

  AnimateChild({
    required this.childWidget,
    required this.childWidgetSize,
    this.position = Offset.zero,
    this.velocity = const Offset(10.0, 10.0),
  });

  void resetPosition() {
    position = Offset.zero;
  }

  void move() {
    position += velocity;
  }

  void shuffleVelocity() {
    velocity = Offset(Random().nextDouble() * 30, Random().nextDouble() * 30);
    debugPrint(
        'shuffle velocity:${velocity.dx.abs().toStringAsFixed(2)}:${velocity.dy.abs().toStringAsFixed(2)}');
  }

  void chengeVelocityDirection(String direction) {
    switch (direction) {
      case 'x':
        velocity = Offset(-velocity.dx, velocity.dy);
        break;
      case 'y':
        velocity = Offset(velocity.dx, -velocity.dy);
        break;
      default:
    }
  }
}
