import 'package:flutter/material.dart';

class Buttons {
  static Widget navbarStateChanger({
    required Widget icon,
    required bool navbarOpen,
    required VoidCallback onPressed,
    required double expandedWidth,
    required double collapsedWidth,
    BorderRadius raduis = const BorderRadius.all(Radius.circular(300)),
    double spacing = 15.0,
    Color backgroundColor = Colors.white,
    Duration duration = Durations.medium4,
    Curve curve = Curves.easeInOutCubic,
    double elevation = 5.0,
  }) {
    return InkWell(
      borderRadius: raduis,
      onTap: onPressed,
      child: AnimatedContainer(
        width: navbarOpen ? expandedWidth : collapsedWidth,
        height: collapsedWidth,
        duration: duration,
        curve: curve,
        alignment: Alignment.centerLeft,
        child: SizedBox(
          width: collapsedWidth,
          height: collapsedWidth,
          child: Card(
            elevation: 0.0,
            shape: RoundedRectangleBorder(borderRadius: raduis),
            margin: EdgeInsets.zero,
            color: backgroundColor,
            child: icon,
          ),
        ),
      ),
    );
  }
}
