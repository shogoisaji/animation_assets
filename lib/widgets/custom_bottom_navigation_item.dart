import 'package:animation_assets/theme/color_theme.dart';
import 'package:flutter/material.dart';

BottomNavigationBarItem customBottomNavigationItem(Icon icon) {
  return BottomNavigationBarItem(
    icon: icon,
    activeIcon: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(47 / 2),
          // color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: MyTheme.beige.withOpacity(0.9),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 0),
            ),
          ]),
      width: 47,
      height: 47,
      child: icon,
    ),
    label: '',
  );
}
