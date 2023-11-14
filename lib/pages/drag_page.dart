import 'dart:math';

import 'package:animation_assets/animations/drag_animation.dart';
import 'package:animation_assets/models/animate_child.dart';
import 'package:flutter/material.dart';

class DragPage extends StatefulWidget {
  const DragPage({Key? key}) : super(key: key);

  @override
  _DragPageState createState() => _DragPageState();
}

const Offset defaultPosition = Offset(100, 100);
const double defaultSize = 100;

class _DragPageState extends State<DragPage> with TickerProviderStateMixin {
  late AnimationController animationController;
  final AnimateChild animateChild = AnimateChild(
    childWidget: Container(
      width: defaultSize,
      height: defaultSize,
      decoration: const BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.fill, image: AssetImage('assets/images/elephant.png')),
      ),
    ),
    childWidgetSize: const Size(defaultSize, defaultSize),
    position: defaultPosition,
  );

  bool isDragged = true;

  late Offset newPosition;
  late double delta;

  void reset() {
    newPosition = defaultPosition;
    delta = 0;
    animationController.reset();
    animateChild.position = Offset(0, 0);
  }

  double calculateHypotenuse(double x, double y) {
    return sqrt(pow(x, 2) + pow(y, 2));
  }

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: const Duration(seconds: 5), vsync: this);
    reset();
    newPosition = animateChild.position;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
                child: Container(
              color: Colors.grey,
            )),
          ],
        ),
        Center(
          child: Text(delta.toStringAsFixed(0),
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 48,
                  color: Colors.white)),
        ),
        Positioned(
          top: animateChild.position.dy,
          left: animateChild.position.dx,
          child: GestureDetector(
            onPanStart: (details) {
              setState(() {
                // isDragged = true;
              });
              debugPrint('pan start');
            },
            onPanEnd: (details) {
              setState(() {
                animationController.forward();
                // isDragged = false;
                // reset();
              });
              debugPrint('pan end');
            },
            onPanUpdate: (details) {
              setState(() {
                newPosition = Offset(newPosition.dx + details.delta.dx,
                    newPosition.dy + details.delta.dy);
                delta = calculateHypotenuse(
                    newPosition.dx - animateChild.position.dx,
                    newPosition.dy - animateChild.position.dy);
                animateChild.childWidgetSize =
                    Size(defaultSize + delta / 2, defaultSize + delta / 2);
              });
            },
            child: animateChild.childWidget,
          ),
        ),
        isDragged
            ? Positioned(
                top: newPosition.dy,
                left: newPosition.dx,
                child: DragAnimation(
                  velocity: newPosition,
                  animationController: animationController,
                  animateChild: animateChild,
                ),
              )
            : Container(),
        Positioned(
            bottom: 24,
            left: 24,
            child: ElevatedButton(
                child: const Icon(Icons.restart_alt, color: Colors.black),
                onPressed: () {
                  setState(() {
                    reset();
                  });
                })),
      ],
    );
  }
}
