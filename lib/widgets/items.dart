import 'package:flutter/material.dart';

import 'svg_icons.dart';

class Items {
  static Widget navbarItem({
    required String iconName,
    required String lable,
    required bool navbarOpen,
    required VoidCallback? onPressed,
    required double expandedWidth,
    required double collapsedWidth,
    BorderRadius raduis = const BorderRadius.all(Radius.circular(300)),
    Color backgroundColor = Colors.white,
    Color shadowColor = Colors.black38,
    Duration duration = Durations.medium4,
    Curve curve = Curves.easeInOutCubic,
    double elevation = 5.0,
  }) {
    return InkWell(
      borderRadius: raduis,
      onTap: onPressed,
      child: Card(
        elevation: elevation,
        color: backgroundColor,
        shadowColor: shadowColor,
        margin: EdgeInsets.zero,
        child: AnimatedContainer(
          width: navbarOpen ? expandedWidth : collapsedWidth,
          height: collapsedWidth,
          duration: duration,
          curve: curve,
          child: Row(
            children: [
              Expanded(
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    AnimatedPositioned(
                      left: navbarOpen ? collapsedWidth + 0 : 0.0,
                      duration: duration,
                      curve: curve,
                      child: AnimatedOpacity(
                        opacity: navbarOpen ? 1.0 : 0.0,
                        duration: duration ~/ 2,
                        curve: curve,
                        child: Container(
                          width: collapsedWidth * 2,
                          height: collapsedWidth,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            lable,
                            // maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Card(
                        elevation: 0.0,
                        margin: EdgeInsets.zero,
                        color: backgroundColor,
                        child: SizedBox(
                          width: collapsedWidth,
                          height: collapsedWidth,
                          child: Center(child: SvgIcons.fromAssets(iconName)),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
