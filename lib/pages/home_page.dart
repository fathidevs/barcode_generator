import 'package:barcode_generator/widgets/ean13_generator_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    // _key.currentState!.openDrawer();

    return Scaffold(
      key: _key,
      drawer: Drawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _key.currentState!.openDrawer(), // <-- Opens drawer
      ),
      body: Center(child: Ean13GeneratorWidget()),
    );
  }
}
