import 'package:animation_assets/animations/bounce_animation.dart';
import 'package:animation_assets/models/animate_child.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class BouncePage extends StatefulWidget {
  const BouncePage({Key? key}) : super(key: key);

  @override
  BouncePageState createState() => BouncePageState();
}

class BouncePageState extends State<BouncePage> with TickerProviderStateMixin {
  AnimateChild animateChild = AnimateChild(
    childWidget: Container(
        width: 100,
        height: 100,
        decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/images/elephant.png')),
        )),
    childWidgetSize: const Size(100, 100),
  );

  late AnimationController animationController;
  late Animation<double> animation;

  bool isMoving = false;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1700), vsync: this);
    animation = Tween<double>(begin: 0, end: 1).animate(animationController)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    animationController.stop();
    animationController.dispose();
    super.dispose();
  }

  void animationSwitch() {
    if (isMoving) {
      debugPrint('animation:stop');
      animationController.stop();
      setState(() {
        isMoving = false;
      });
    } else {
      debugPrint('animation:start');
      animationController.repeat();
      setState(() {
        isMoving = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            color: Colors.grey,
            child: Stack(children: [
              Positioned(
                  bottom: 24,
                  left: 24,
                  child: ElevatedButton(
                      child: isMoving
                          ? const Icon(Icons.stop, color: Colors.black)
                          : const Icon(Icons.play_arrow, color: Colors.black),
                      onPressed: () {
                        animationSwitch();
                      })),
              // Positioned(
              //     bottom: 64,
              //     left: 24,
              //     child: ElevatedButton(
              //         child: const Icon(Icons.shuffle, color: Colors.black),
              //         onPressed: () {
              //           setState(() {
              //             animateChild.shuffleVelocity();
              //           });
              //         })),

              BounceAnimation(animation: animation, animateChild: animateChild),
            ]),
          ),
        ),
      ],
    );
  }
}
