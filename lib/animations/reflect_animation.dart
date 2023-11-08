import 'package:flutter/material.dart';

class ReflectAnimation extends StatefulWidget {
  final Widget child;
  final Size size;
  final Rect screen;
  final Offset defaultVelocity;
  final AnimationController animationController;

  ReflectAnimation(
      {super.key,
      required this.child,
      required this.screen,
      required this.animationController,
      required this.defaultVelocity,
      required this.size});

  @override
  _ReflectAnimationState createState() => _ReflectAnimationState();
}

class _ReflectAnimationState extends State<ReflectAnimation> {
  late Animation<Offset> animation;
  Offset position = Offset.zero;
  late Offset velocity;

  @override
  void initState() {
    super.initState();
    velocity = widget.defaultVelocity;

    widget.animationController.addListener(() {
      setState(() {
        if (position.dx < 0 ||
            position.dx > widget.screen.width - widget.size.width) {
          velocity = Offset(-velocity.dx, velocity.dy);
        }
        if (position.dy < 0 ||
            position.dy > widget.screen.height - widget.size.height) {
          velocity = Offset(velocity.dx, -velocity.dy);
        }

        position += velocity;
      });
    });

    print('animation widget : ${velocity}');
  }

  @override
  void didUpdateWidget(ReflectAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.defaultVelocity != oldWidget.defaultVelocity) {
      setState(() {
        velocity = widget.defaultVelocity;
      });
    }
    print('animation widget : ${velocity}');
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: widget.animationController,
        builder: (context, child) => Transform.translate(
              offset: position,
              child: widget.child,
            ));
  }
}
