import 'package:animation_assets/models/ball.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vector_math/vector_math.dart' as vector;

part 'state.g.dart';

enum PageTitle { drag, bounce, reflect, pop, collision }

extension PageTitleExtension on PageTitle {
  String get title {
    switch (this) {
      case PageTitle.drag:
        return 'Drag';
      case PageTitle.bounce:
        return 'Bounce';
      case PageTitle.reflect:
        return 'Reflect';
      case PageTitle.pop:
        return 'Pop';
      case PageTitle.collision:
        return 'Collision';
      default:
        return '';
    }
  }
}

@riverpod
class BottomNavigationBarIndex extends _$BottomNavigationBarIndex {
  @override
  int build() => 0;

  void setIndex(int index) => state = index;

  String getTitle() {
    // return PageTitle.values[state].toString();
    return PageTitle.values[state].toString().split('.').last;
  }
}

@riverpod
String getTitle(GetTitleRef ref) {
  return PageTitle.values[ref.watch(bottomNavigationBarIndexProvider)].title;
}

@riverpod
class CountDownState extends _$CountDownState {
  @override
  bool build() => false;

  void start() => state = true;
  void stop() => state = false;
}

@riverpod
class BallModel extends _$BallModel {
  @override
  Ball build() => Ball(
      radius: 20.0,
      velocity: vector.Vector2(10.0, 10.0),
      position: vector.Vector2(30.0, 30.0),
      color: Colors.red);

  void update(Ball ball) => state = ball;
  void chengeVelocity(vector.Vector2 velocity) => state.velocity = velocity;
  void chengePosition(vector.Vector2 position) => state.position = position;
}
