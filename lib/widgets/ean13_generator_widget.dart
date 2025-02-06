import 'dart:convert';
import 'dart:io';
import 'dart:html'
    as html; // or package:universal_html/prefer_universal/html.dart

import 'package:barcode/barcode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Ean13GeneratorWidget extends StatefulWidget {
  const Ean13GeneratorWidget({super.key});

  @override
  State<Ean13GeneratorWidget> createState() => _Ean13GeneratorWidgetState();
}

class _Ean13GeneratorWidgetState extends State<Ean13GeneratorWidget> {
  final String _data = '1234567890123';
  final Barcode _barcode = Barcode.fromType(BarcodeType.CodeEAN13);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.string(_buildSvgString(_data)),
        SizedBox(height: 25.0),
        ElevatedButton(
            onPressed: () {
              _download();
            },
            child: Text('DOWNLOAD'))
      ],
    );
  }

  String _buildSvgString(String data) {
    final svg = _barcode.toSvg(
      data,
      width: 200,
      height: 80,
      fontHeight: 20,
      fontFamily: 'Arial',
    );
    return svg;
  }

  _download() async {
    // String directory = (await getApplica()).path;
    // String filename =
    //     _barcode.name.replaceAll(RegExp(r'\s'), '-').toLowerCase();
    // File('filename.svg').writeAsStringSync(_buildSvgString(_data));

    // final text = 'this is the text file';

// prepare
    final bytes = utf8.encode(_buildSvgString(_data));
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = 'some_name.svg';
    html.document.body?.children.add(anchor);

// download
    anchor.click();

// cleanup
    html.document.body?.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
  }
}
