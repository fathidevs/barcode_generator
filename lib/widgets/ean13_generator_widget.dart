import 'dart:convert';
import 'dart:io';
import 'dart:html'
    as html; // or package:universal_html/prefer_universal/html.dart
import 'dart:math';

import 'package:barcode/barcode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../tools/checksum.dart';

class Ean13GeneratorWidget extends StatefulWidget {
  const Ean13GeneratorWidget({super.key});

  @override
  State<Ean13GeneratorWidget> createState() => _Ean13GeneratorWidgetState();
}

String? barcodData;

class _Ean13GeneratorWidgetState extends State<Ean13GeneratorWidget> {
  final String _code = '1234567890123';
  final Barcode _barcode = Barcode.fromType(BarcodeType.CodeEAN13);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (barcodData != null) SvgPicture.string(barcodData!),
        SizedBox(height: 25.0),
        ElevatedButton(
            onPressed: () {
              _generateBarcode();
            },
            child: Text('GENERATE')),
        SizedBox(height: 25.0),
        ElevatedButton(
            onPressed: () {
              _download();
            },
            child: Text('DOWNLOAD')),
        ElevatedButton(
            onPressed: () {
              // generateBulk();
              _downloadBulk();
            },
            child: Text('DOWNLOAD BULK')),
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

  void _generateBarcode() {
    try {
      // String svgString = _buildSvgString(_code);
      String svgString = _buildSvgString('6290864031307');
      setState(() {
        barcodData = svgString;
      });
    } on BarcodeException catch (e) {
      // _checksum(_code);
      if (e.message.contains('checksum')) {
        // FIX LAST DIGIT
        // Checksum(code: _code).checksum;
      }
      print(Checksum(code: _code).checksum);
      print('opss! ${e.message}');
    }
  }

  void _download() async {
    // String directory = (await getApplica()).path;
    // String filename =
    //     _barcode.name.replaceAll(RegExp(r'\s'), '-').toLowerCase();
    // File('filename.svg').writeAsStringSync(_buildSvgString(_code));

    // final text = 'this is the text file';

// prepare
    // final bytes = utf8.encode(_buildSvgString(_code));
    final bytes = utf8.encode(_buildSvgString('6290864088519'));
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

  void _downloadBulk() async {
//     for (String barcode in sait) {
// // prepare
//       final bytes = utf8.encode(_buildSvgString(barcode));
//       final blob = html.Blob([bytes]);
//       final url = html.Url.createObjectUrlFromBlob(blob);
//       final anchor = html.document.createElement('a') as html.AnchorElement
//         ..href = url
//         ..style.display = 'none'
//         ..download = '$barcode.svg';
//       html.document.body?.children.add(anchor);

// // download
//       anchor.click();

// // cleanup
//       html.document.body?.children.remove(anchor);
//       html.Url.revokeObjectUrl(url);
//       await Future.delayed(Duration(seconds: 1));
//     }
// print(sait.)
  }

  _checksum(String code) {
    List<int> digits = code
        .split('')
        .map(
          (digit) => int.parse(digit),
        )
        .toList();
    int lastDigit = digits.last;
    int odd = 0;
    for (int i = 0; i < digits.length - 1; i += 2) {
      odd += digits[i];
    }
    int even = 0;
    for (int i = 1; i < digits.length - 1; i += 2) {
      even += digits[i];
    }
    int sum = odd + (even * lastDigit);
    int modulo = sum % 10;
    int checkSum = 10 - modulo;
    print(checkSum);
  }

  generateBulk() {
    String countryCode = '629';
    String manufacturarCode = '0864';

    int len = 75;
    int checkSum = 0;
    // for (int i = 0; i < 10; i++) {
    //   String productCode = Random().nextInt(10000).toString().padLeft(5, '0');
    //   print("productCode = $productCode");
    //   String s = countryCode + manufacturarCode + productCode;
    //   print("s = $s");
    //   String checkSum = Checksum(code: s).checksum.toString();
    //   print("checkSum = $checkSum");
    //   String barcode = s += checkSum;
    //   print("barcode = $barcode");
    //   print('\n');
    // }

    List<String> barcodes = [];
    do {
      String productCode = Random().nextInt(10000).toString().padLeft(5, '0');

      String s = countryCode + manufacturarCode + productCode;

      int checkSum = Checksum(code: s).calculateChecksum(s);

      if (checkSum < 10) {
        String barcode = '$s$checkSum';
        barcodes.add(barcode);
      }
    } while (barcodes.length < len);
    print('list : $barcodes');
  }
}

const List<String> sait = [
  '6290864036763',
  '6290864015256',
  '6290864017007',
  '6290864052879',
  '6290864021066',
  '6290864054019',
  '6290864008524',
  '6290864045154',
  '6290864035773',
  '6290864046755',
  '6290864033939',
  '6290864061505',
  '6290864051780',
  '6290864004755',
  '6290864085327',
  '6290864027976',
  '6290864030983',
  '6290864089448',
  '6290864004748',
  '6290864099317',
  '6290864026344',
  '6290864086515',
  '6290864021028',
  '6290864027471',
  '6290864070354',
  '6290864086553',
  '6290864049886',
  '6290864045710',
  '6290864064407',
  '6290864051537',
  '6290864090840',
  '6290864084580',
  '6290864014136',
  '6290864088519',
  '6290864037081',
  '6290864092332',
  '6290864009125',
  '6290864056440',
  '6290864083507',
  '6290864097009',
  '6290864044904',
  '6290864080841',
  '6290864072860',
  '6290864065640',
  '6290864092097',
  '6290864025675',
  '6290864036978',
  '6290864092165',
  '6290864003215',
  '6290864093711',
  '6290864059854',
  '6290864019681',
  '6290864001471',
  '6290864017557',
  '6290864055276',
  '6290864099423',
  '6290864092417',
  '6290864056655',
  '6290864030143',
  '6290864049404',
  '6290864035766',
  '6290864065473',
  '6290864060690',
  '6290864068467',
  '6290864057669',
  '6290864079241',
  '6290864026276',
  '6290864050851',
  '6290864024432',
  '6290864008531',
  '6290864010411',
  '6290864075410',
  '6290864008975',
  '6290864014716',
  '6290864019384'
];
