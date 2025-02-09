import 'package:flutter/material.dart';

import 'buttons.dart';

class Navbar extends StatefulWidget {
  final double expandedWidth;
  final double collapsedWidth;

  const Navbar({
    super.key,
    required this.expandedWidth,
    required this.collapsedWidth,
  });

  @override
  State<Navbar> createState() => _NavbarState();
}

bool _open = true;

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Buttons.navbarStateChanger(
            collapsedWidth: widget.collapsedWidth,
            expandedWidth: widget.expandedWidth,
            icon: const Icon(Icons.close),
            lable: 'lable',
            navbarOpen: _open,
            onPressed: navbarStateChanger,
          ),
          const Text('navbar'),
        ],
      ),
    );
  }

  void navbarStateChanger() => setState(() => _open = !_open);
}
