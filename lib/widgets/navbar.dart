import 'package:flutter/material.dart';

import '../tools/bg_consts.dart';
import 'buttons.dart';
import 'items.dart';

class Navbar extends StatefulWidget {
  final int activePagePosition;
  final double expandedWidth;
  final double collapsedWidth;
  final Color backgroundColor;
  final Color shadowColor;
  final BorderRadius radius;
  final List<VoidCallback> pageJumpList;

  const Navbar({
    super.key,
    required this.activePagePosition,
    required this.expandedWidth,
    required this.collapsedWidth,
    required this.pageJumpList,
    this.backgroundColor = Colors.white,
    this.shadowColor = Colors.black12,
    this.radius = const BorderRadius.horizontal(
      right: Radius.circular(BgConsts.radius),
    ),
  });

  @override
  State<Navbar> createState() => _NavbarState();
}

bool _open = false;

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: BgConsts.hSpace,
      ),
      decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: widget.radius,
          boxShadow: [
            BoxShadow(
              color: widget.shadowColor,
              offset: Offset.zero,
              spreadRadius: 3.0,
              blurRadius: 10.0,
            )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Buttons.navbarStateChanger(
            collapsedWidth: widget.collapsedWidth,
            expandedWidth: widget.expandedWidth,
            icon: const Icon(Icons.menu_rounded),
            navbarOpen: _open,
            onPressed: navbarStateChanger,
          ),
          const SizedBox(height: 50.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Items.navbar(
                iconName: 'home',
                lable: 'Home',
                navbarOpen: _open,
                onPressed: widget.pageJumpList[0],
                expandedWidth: widget.expandedWidth,
                collapsedWidth: widget.collapsedWidth,
                elevation: _elevation(0),
              ),
              const SizedBox(height: BgConsts.hSpace * 1.5),
              Items.navbar(
                iconName: 'dashboard',
                lable: 'Projects',
                navbarOpen: _open,
                onPressed: widget.pageJumpList[1],
                expandedWidth: widget.expandedWidth,
                collapsedWidth: widget.collapsedWidth,
                elevation: _elevation(1),
              ),
              const SizedBox(height: BgConsts.hSpace),
            ],
          ),
        ],
      ),
    );
  }

  void navbarStateChanger() => setState(() => _open = !_open);
  double _elevation(int activePagePosition) {
    return widget.activePagePosition == activePagePosition ? 1.0 : 5.0;
  }
}
