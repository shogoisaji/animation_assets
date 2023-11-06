import 'package:animation_assets/theme/color_theme.dart';
import 'package:animation_assets/utils/line_painter.dart';
import 'package:flutter/material.dart';

import 'dart:math' as math;

import 'package:flutter_hooks/flutter_hooks.dart';

class CollisionPage extends HookWidget {
  const CollisionPage({super.key});

  final radius = 25.0;

  @override
  Widget build(BuildContext context) {
    final startX = useState(MediaQuery.of(context).size.width / 2);
    final startY = useState(MediaQuery.of(context).size.height / 2);
    final dragEndX = useState(MediaQuery.of(context).size.width / 2);
    final dragEndY = useState(MediaQuery.of(context).size.height / 2);
    final isTouching = useState(false);
    final dragDistance = useState(20.0);

    return Stack(
      children: [
        isTouching.value
            ? CustomPaint(
                painter: LinePainter(
                  start: Offset(startX.value, startY.value),
                  end: Offset(dragEndX.value, dragEndY.value),
                ),
              )
            : Container(),
        Positioned(
          top: startY.value - radius,
          left: startX.value - radius,
          child: GestureDetector(
            onPanDown: (details) {
              isTouching.value = true;
              startX.value = details.localPosition.dx;
              startY.value = details.localPosition.dy;
              print('Is touching: $isTouching');
            },
            child: CircleAvatar(
              radius: radius,
              backgroundColor: MyTheme.red,
            ),
          ),
        ),
        Positioned(
          top: startY.value - dragDistance.value,
          left: startX.value - dragDistance.value,
          child: Container(
            width: dragDistance.value * 2,
            height: dragDistance.value * 2,
            decoration: BoxDecoration(
              border: Border.all(color: MyTheme.red, width: 2),
              shape: BoxShape.circle,
            ),
          ),
        ),
        GestureDetector(
          onPanDown: (details) {
            isTouching.value = true;
            // startX.value = details.localPosition.dx;
            // startY.value = details.localPosition.dy;
            print('Is touching: $isTouching');
          },
          onPanUpdate: (DragUpdateDetails details) {
            dragEndX.value = details.localPosition.dx;
            dragEndY.value = details.localPosition.dy;

            dragDistance.value = math.sqrt((dragEndX.value - startX.value) *
                    (dragEndX.value - startX.value) +
                (dragEndY.value - startY.value) *
                    (dragEndY.value - startY.value));
            print(dragDistance);
          },
          onPanEnd: (details) {
            isTouching.value = false;
            dragDistance.value = 0;
            print('Is touching: $isTouching');
          },
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.transparent,
          ),
        ),
      ],
    );
  }
}
