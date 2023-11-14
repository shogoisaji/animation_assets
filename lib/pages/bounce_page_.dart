import 'package:animation_assets/animations/bounce_animation.dart';
import 'package:animation_assets/models/animate_child.dart';
import 'package:flutter/material.dart';

class BouncePage extends StatefulWidget {
  const BouncePage({Key? key}) : super(key: key);

  @override
  BouncePageState createState() => BouncePageState();
}

const double defaultSize = 100;

class BouncePageState extends State<BouncePage> with TickerProviderStateMixin {
  final AnimateChild animateChild = AnimateChild(
    childWidget: Container(
        width: defaultSize,
        height: defaultSize,
        decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/images/elephant.png')),
        )),
    childWidgetSize: const Size(defaultSize, defaultSize),
  );

  double maxBounce = 300;
  int bounceCount = 3;

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
              Center(
                child: Text('$bounceCount回  H:$maxBounce',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 48,
                        color: Colors.white)),
              ),
              Positioned(
                  bottom: 24,
                  right: 24,
                  child: ElevatedButton(
                      child: isMoving
                          ? const Icon(Icons.stop, color: Colors.black)
                          : const Icon(Icons.play_arrow, color: Colors.black),
                      onPressed: () {
                        animationSwitch();
                      })),
              Positioned(
                  bottom: 64,
                  right: 24,
                  child: ElevatedButton(
                      child: const Icon(Icons.restart_alt, color: Colors.black),
                      onPressed: () {
                        setState(() {
                          isMoving = false;
                          animationController.reset();
                        });
                      })),
              BounceAnimation(
                  animation: animation,
                  animateChild: animateChild,
                  maxBounce: maxBounce,
                  bounceCount: bounceCount),
            ]),
          ),
        ),
      ],
    );
  }
}
