import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIcons {
  static Widget fromAssets(
    String iconName, {
    double width = 20.0,
    double height = 20.0,
    Color iconColor = Colors.black,
  }) {
    return SvgPicture.asset(
      width: width,
      height: height,
      colorFilter: ColorFilter.mode(
        iconColor,
        BlendMode.srcIn,
      ),
      'assets/icons/$iconName.svg',
    );
  }
}
