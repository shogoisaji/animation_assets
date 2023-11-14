import 'package:animation_assets/config/config.dart';
import 'package:animation_assets/models/animate_child.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class DragAnimation extends StatefulWidget {
  final AnimateChild animateChild;
  final AnimationController animationController;
  final Offset velocity;
  const DragAnimation({
    super.key,
    required this.animateChild,
    required this.animationController,
    required this.velocity,
  });

  @override
  DragAnimationState createState() => DragAnimationState();
}

class DragAnimationState extends State<DragAnimation> {
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    widget.animateChild.velocity = widget.velocity;

    widget.animationController.addListener(() {
      setState(() {
        widget.animateChild.move();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: widget.animationController,
        builder: (context, child) => Transform.translate(
              offset: widget.animateChild.position,
              child: widget.animateChild.childWidget,
            ));
  }
}
