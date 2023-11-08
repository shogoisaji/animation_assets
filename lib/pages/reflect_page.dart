import 'dart:math';

import 'package:animation_assets/animations/reflect_animation.dart';
import 'package:flutter/material.dart';

class ReflectPage extends StatefulWidget {
  const ReflectPage({super.key});

  @override
  ReflectPageState createState() => ReflectPageState();
}

const Size animationObjectSize = Size(100, 100);
const int randomMax = 20;

class ReflectPageState extends State<ReflectPage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  Rect screenSize = Rect.zero;
  Offset animationObjectVelocity = const Offset(10, 10);
  bool isMoving = false;
  final GlobalKey _screenContainerKey = GlobalKey();
  final Widget animationObject = Container(
      width: animationObjectSize.width,
      height: animationObjectSize.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.fill, image: AssetImage('assets/images/elephant.png')),
      ));

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getScreenSize();
    });
    animationController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void getScreenSize() {
    final RenderBox? renderBox =
        _screenContainerKey.currentContext?.findRenderObject() as RenderBox?;
    final getScreenSize = renderBox?.size ?? Size.zero;
    setState(() {
      screenSize =
          Rect.fromLTRB(0, 0, getScreenSize.width, getScreenSize.height);
    });
  }

  void animationSwitch() {
    if (isMoving) {
      animationController.reset();
      animationController.stop();
    } else {
      animationController.repeat();
    }
  }

  void shuffleVelocity() {
    setState(() {
      animationObjectVelocity =
          Offset(Random().nextDouble() * 30, Random().nextDouble() * 30);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            key: _screenContainerKey,
            color: Colors.grey,
            child: Stack(children: [
              Center(
                child: Text(
                    '${animationObjectVelocity.dx.abs().toStringAsFixed(2)} : ${animationObjectVelocity.dy.abs().toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 48,
                        color: Colors.white)),
              ),
              Positioned(
                  bottom: 24,
                  left: 24,
                  child: ElevatedButton(
                      child:
                          isMoving ? const Text('Stop') : const Text('Start'),
                      onPressed: () {
                        animationSwitch();
                        isMoving = !isMoving;
                      })),
              Positioned(
                  bottom: 64,
                  left: 24,
                  child: ElevatedButton(
                      child: const Text('Shuffle'),
                      onPressed: () {
                        shuffleVelocity();
                        animationObjectVelocity = Offset(
                            Random().nextDouble() * randomMax,
                            Random().nextDouble() * randomMax);
                      })),
              ReflectAnimation(
                  screen: screenSize,
                  animationController: animationController,
                  defaultVelocity: animationObjectVelocity,
                  size: animationObjectSize,
                  child: animationObject),
            ]),
          ),
        ),
      ],
    );
  }
}
