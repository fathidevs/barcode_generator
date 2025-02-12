import 'package:flutter/services.dart';

class CopySvg {
  static void data(String data) async {
    await Clipboard.setData(ClipboardData(text: data));
  }
}
