import 'package:barcode/barcode.dart';
import 'package:flutter/material.dart';

import '../widgets/generator_body_widget.dart';
import '../widgets/navbar.dart';
import 'projects_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

final PageController _pageController = PageController(initialPage: 1);

class _HomePageState extends State<HomePage> {
  int _activePagePosition = 0;
  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: Row(
        children: [
          Navbar(
            collapsedWidth: 60.0,
            expandedWidth: 150.0,
            pageJumpList: _pageJumpList,
            activePagePosition: _activePagePosition,
          ),
          Expanded(
              child: PageView(
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            onPageChanged: (value) =>
                setState(() => _activePagePosition = value),
            children: [
              GeneratorBodyWidget(
                  barcodType: Barcode.fromType(BarcodeType.CodeEAN13)),
              const ProjectsPage(),
            ],
          )),
        ],
      ),
    );
  }

  final List<VoidCallback> _pageJumpList = [
    () => _pageController.jumpToPage(0),
    () => _pageController.jumpToPage(1),
  ];
}
