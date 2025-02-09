import 'package:barcode_generator/widgets/ean13_generator_widget.dart';
import 'package:flutter/material.dart';

import '../widgets/navbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: Row(
        children: [
          Navbar(
            collapsedWidth: 60.0,
            expandedWidth: width * .2,
          )
        ],
      ),
    );
  }
}
