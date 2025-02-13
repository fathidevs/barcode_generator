import 'package:flutter/material.dart';

import '../tools/bg_consts.dart';
import 'buttons.dart';
import 'items.dart';

class Navbar extends StatefulWidget {
  final double expandedWidth;
  final double collapsedWidth;
  final Color backgroundColor;
  final Color shadowColor;
  final BorderRadius radius;

  const Navbar({
    super.key,
    required this.expandedWidth,
    required this.collapsedWidth,
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
              Items.navbarItem(
                iconName: 'dashboard',
                lable: 'Projects',
                navbarOpen: _open,
                onPressed: () {
                  // print('object');
                },
                expandedWidth: widget.expandedWidth,
                collapsedWidth: widget.collapsedWidth,
              ),
              const SizedBox(height: BgConsts.hSpace),
              // Items.navbarItem(
              //   icon: const Icon(Icons.abc),
              //   lable: 'lable',
              //   navbarOpen: _open,
              //   onPressed: () {},
              //   expandedWidth: widget.expandedWidth,
              //   collapsedWidth: widget.collapsedWidth,
              // ),
            ],
          ),
        ],
      ),
    );
  }

  void navbarStateChanger() => setState(() => _open = !_open);
}
