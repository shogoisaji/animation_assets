import 'dart:math';

import 'package:animation_assets/animations/reflect_animation.dart';
import 'package:flutter/material.dart';

class ReflectPage extends StatefulWidget {
  const ReflectPage({Key? key}) : super(key: key);

  @override
  ReflectPageState createState() => ReflectPageState();
}

const Size animationObjectSize = Size(100, 100);
const int randomMax = 20;

class ReflectPageState extends State<ReflectPage> {
  // late AnimationController animationController;
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

  final GlobalKey<ReflectAnimationState> _key =
      GlobalKey<ReflectAnimationState>();

  // @override
  // void initState() {
  //   super.initState();
  //   // build後にスクリーンサイズを取得
  //   // WidgetsBinding.instance.addPostFrameCallback((_) {
  //   //   getScreenSize();
  //   // });
  //   // animationController =
  //   //     AnimationController(duration: const Duration(seconds: 1), vsync: this);
  // }

  // @override
  // void dispose() {
  //   // animationController.stop();
  //   // animationController.dispose();
  //   super.dispose();
  // }

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
      _key.currentState?.animationController.stop();
    } else {
      _key.currentState?.animationController.repeat();
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
                      child: isMoving
                          ? const Icon(Icons.stop, color: Colors.black)
                          : const Icon(Icons.play_arrow, color: Colors.black),
                      onPressed: () {
                        animationSwitch();
                        getScreenSize();
                        setState(() {
                          isMoving = !isMoving;
                        });
                      })),
              Positioned(
                  bottom: 64,
                  left: 24,
                  child: ElevatedButton(
                      child: const Icon(Icons.shuffle, color: Colors.black),
                      onPressed: () {
                        getScreenSize();
                        shuffleVelocity();
                        animationObjectVelocity = Offset(
                            Random().nextDouble() * randomMax,
                            Random().nextDouble() * randomMax);
                      })),
              Positioned(
                  bottom: 104,
                  left: 24,
                  child: ElevatedButton(
                      child: const Icon(Icons.screenshot_monitor,
                          color: Colors.black),
                      onPressed: () {
                        getScreenSize();
                      })),
              ReflectAnimation(
                  key: _key,
                  screen: screenSize,
                  // animationController: AnimationController(
                  //     duration: const Duration(seconds: 1),),
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
