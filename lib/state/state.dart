import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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
