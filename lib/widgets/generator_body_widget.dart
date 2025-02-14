import 'package:barcode/barcode.dart';
import 'package:flutter/material.dart';

import 'generators/ean13_generator_widget.dart';

class GeneratorBodyWidget extends StatefulWidget {
  final Barcode barcodType;
  const GeneratorBodyWidget({super.key, required this.barcodType});

  @override
  State<GeneratorBodyWidget> createState() => _GeneratorBodyWidgetState();
}

TextEditingController ean13Ctrl = TextEditingController();

class _GeneratorBodyWidgetState extends State<GeneratorBodyWidget> {
  // final Barcode _barcode = Barcode.fromType(BarcodeType.CodeEAN13);
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Ean13GeneratorWidget(
      barcodType: widget.barcodType,
    ));
  }
}
