import 'package:flutter/material.dart';

import '../tools/bg_consts.dart';
import 'interactive_btn.dart';
import 'svg_icons.dart';

class Buttons {
  static Widget navbarStateChanger({
    required Widget icon,
    required bool navbarOpen,
    required VoidCallback onPressed,
    required double expandedWidth,
    required double collapsedWidth,
    BorderRadius raduis = const BorderRadius.all(Radius.circular(300)),
    Color backgroundColor = Colors.white,
    Duration duration = Durations.medium4,
    Curve curve = Curves.easeInOutCubic,
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

  static Widget iconTextInterActive({
    required String iconName,
    required String lable,
    required VoidCallback? onPressed,
    String? toolTipMsg,
    Color backgroundColor = Colors.white,
    Color shadowColor = Colors.black12,
    BorderRadius radius =
        const BorderRadius.all(Radius.circular(BgConsts.radius)),
    EdgeInsets padding = const EdgeInsets.symmetric(
        horizontal: BgConsts.hSpace, vertical: BgConsts.hSpace - 5.0),
  }) {
    return Tooltip(
      message: toolTipMsg,
      preferBelow: false,
      verticalOffset: 40.0,
      child: InteractiveBtn(
        backgroundColor: backgroundColor,
        shadowColor: shadowColor,
        radius: radius,
        padding: padding,
        body: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SvgIcons.fromAssets(iconName),
            const SizedBox(width: BgConsts.hSpace - 5.0),
            Text(
              lable.toUpperCase(),
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
        onPressed: onPressed,
      ),
    );
  }
}
