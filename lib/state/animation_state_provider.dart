import 'package:flutter/material.dart';

enum AnimationStateController {
  start,
  stop,
}

class AnimationStateControllerProvider extends ChangeNotifier {
  late AnimationStateController animationControllerState;

  AnimationStateControllerProvider() {
    animationControllerState = AnimationStateController.stop;
    notifyListeners();
  }

  changeStatus() {
    if (animationControllerState == AnimationStateController.start) {
      animationControllerState = AnimationStateController.stop;
    } else {
      animationControllerState = AnimationStateController.start;
    }
  }
}
