import 'package:animation_assets/animations/reflect_animation.dart';
import 'package:animation_assets/models/animate_child.dart';
import 'package:flutter/material.dart';

class ReflectPage extends StatefulWidget {
  const ReflectPage({Key? key}) : super(key: key);

  @override
  ReflectPageState createState() => ReflectPageState();
}

const int randomMax = 20;

class ReflectPageState extends State<ReflectPage>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  Rect screenSize = Rect.zero;
  bool isMoving = false;
  final GlobalKey _screenContainerKey = GlobalKey();
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

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    Future.microtask(() => getScreenSize());
  }

  @override
  void dispose() {
    animationController.stop();
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
            key: _screenContainerKey,
            color: Colors.grey,
            child: Stack(children: [
              Center(
                child: Text(
                    '${animateChild.velocity.dx.abs().toStringAsFixed(2)} : ${animateChild.velocity.dy.abs().toStringAsFixed(2)}',
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
                      })),
              Positioned(
                  bottom: 64,
                  left: 24,
                  child: ElevatedButton(
                      child: const Icon(Icons.shuffle, color: Colors.black),
                      onPressed: () {
                        setState(() {
                          animateChild.shuffleVelocity();
                        });
                      })),
              Positioned(
                  bottom: 104,
                  left: 24,
                  child: ElevatedButton(
                      child: const Icon(Icons.screenshot_monitor,
                          color: Colors.black),
                      onPressed: () {
                        getScreenSize();
                        animateChild.resetPosition();
                      })),
              ReflectAnimation(
                  animationController: animationController,
                  screen: screenSize,
                  animateChild: animateChild),
            ]),
          ),
        ),
      ],
    );
  }
}
