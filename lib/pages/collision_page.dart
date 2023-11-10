import 'package:animation_assets/models/animate_child.dart';
import 'package:flutter/material.dart';

class CollisionPage extends StatefulWidget {
  const CollisionPage({super.key});

  @override
  State<CollisionPage> createState() => _CollisionPageState();
}

final List<AnimateChild> animateChildList = <AnimateChild>[
  AnimateChild(
    childWidget: Container(
        width: 100,
        height: 100,
        decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/images/elephant.png')),
        )),
    childWidgetSize: const Size(100, 100),
  ),
  AnimateChild(
    childWidget: Container(
        width: 100,
        height: 100,
        decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill, image: AssetImage('assets/images/pen.png')),
        )),
    childWidgetSize: const Size(100, 100),
  )
];

class _CollisionPageState extends State<CollisionPage>
    with TickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
          child: Container(
              color: Colors.grey,
              child: Stack(children: [
                const Center(
                  child: Text('collision',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 48,
                          color: Colors.white)),
                ),
                Positioned(
                  top: 100,
                  left: 100,
                  child: animateChildList[0].childWidget,
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: animateChildList[1].childWidget,
                ),
              ])))
    ]);
  }
}
