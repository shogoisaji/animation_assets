import 'package:animation_assets/models/animate_child.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class BounceAnimation extends StatefulWidget {
  final AnimateChild animateChild;
  final Animation<double> animation;
  const BounceAnimation(
      {super.key, required this.animateChild, required this.animation});

  @override
  BounceAnimationState createState() => BounceAnimationState();
}

class BounceAnimationState extends State<BounceAnimation> {
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    widget.animation.addListener(() {
      setState(() {
        // widget.animateChild.move();
      });
    });
  }

  double calculateY(double value, double maxHeight, int bounceCount) {
    int currentBounce = (value * bounceCount).floor();
    double fraction = (value * bounceCount) % 1;
    num heightDecay = math.pow(0.7, currentBounce); // 減衰率を設定
    double height =
        maxHeight * heightDecay * (1 - math.pow(fraction * 2 - 1, 2)); // 放物線の式
    return height;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    double x = screenWidth * widget.animation.value;
    double maxHeight = screenHeight * 0.3; // 初回のバウンドの最大高さ
    double y = screenHeight -
        calculateY(widget.animation.value, maxHeight, 3) -
        50; // 3回バウンド

    return AnimatedBuilder(
        animation: widget.animation,
        builder: (context, child) =>
            // Container(width: 100, height: 100, color: Colors.green));
            Positioned(
              top: y - 250,
              left: x,
              child: widget.animateChild.childWidget,
            ));
  }
}
