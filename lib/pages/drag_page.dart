import 'package:animation_assets/theme/color_theme.dart';
import 'package:flutter/material.dart';

import 'dart:math' as math;

import 'package:flutter_hooks/flutter_hooks.dart';

class DragPage extends HookWidget {
  const DragPage({super.key});

  final radius = 25.0;

  @override
  Widget build(BuildContext context) {
    final currentX = useState(MediaQuery.of(context).size.width / 2);
    final currentY = useState(MediaQuery.of(context).size.height / 2);

    return Stack(
      children: [
        Transform.translate(
          offset: Offset(currentX.value - radius, currentY.value - radius),
          child: Draggable(
            feedback: CircleAvatar(
              radius: radius,
              backgroundColor: MyTheme.red,
            ),
            onDragUpdate: (DragUpdateDetails details) {
              currentX.value = details.localPosition.dx;
              currentY.value = details.localPosition.dy;
              // ドラッグ中の位置を取得します
              Offset position = details.globalPosition;
              // 初期位置からの距離を計算します
              double distance = math
                  .sqrt(position.dx * position.dx + position.dy * position.dy);
              print('Distance  : $distance');
              print('X position: ${currentX.value}');
              print('Y position: ${currentY.value}');
            },
            child: CircleAvatar(
              radius: 25,
              backgroundColor: MyTheme.blue,
            ),
          ),
        ),
      ],
    );
  }
}
