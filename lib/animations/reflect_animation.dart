import 'package:animation_assets/models/animate_child.dart';
import 'package:flutter/material.dart';

class ReflectAnimation extends StatefulWidget {
  final AnimateChild animateChild;
  final AnimationController animationController;
  final Rect screen;

  const ReflectAnimation({
    super.key,
    required this.animateChild,
    required this.animationController,
    required this.screen,
  });

  @override
  ReflectAnimationState createState() => ReflectAnimationState();
}

class ReflectAnimationState extends State<ReflectAnimation> {
  @override
  void initState() {
    super.initState();

    widget.animationController.addListener(() {
      setState(() {
        widget.animateChild.move();
        checkVelocityDirection();
      });
    });
  }

  void checkVelocityDirection() {
    if (widget.animateChild.position.dx < 0 ||
        widget.animateChild.position.dx >
            widget.screen.width - widget.animateChild.childWidgetSize.width) {
      widget.animateChild.chengeVelocityDirection('x');
    }
    if (widget.animateChild.position.dy < 0 ||
        widget.animateChild.position.dy >
            widget.screen.height - widget.animateChild.childWidgetSize.height) {
      widget.animateChild.chengeVelocityDirection('y');
    }
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
