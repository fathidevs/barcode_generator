import 'package:barcode/barcode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../tools/bg_consts.dart';
import '../../tools/checksum.dart';
import '../../tools/copy_svg_data.dart';
import '../../tools/svg_downloader.dart';
import '../buttons.dart';
import '../text_fields.dart';

class Ean13GeneratorWidget extends StatefulWidget {
  final Barcode barcodType;
  const Ean13GeneratorWidget({super.key, required this.barcodType});

  @override
  State<Ean13GeneratorWidget> createState() => _Ean13GeneratorWidgetState();
}

TextEditingController _ean13Ctrl = TextEditingController();
String? _data;

const int _codeLength = 13;
const double _fieldMaxWidth = 300.0;
const double _barcodeWidth = 200.0;
const double _barcodeHeight = 80.0;
const double _barcodeFontHeight = 20.0;

class _Ean13GeneratorWidgetState extends State<Ean13GeneratorWidget> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // final d = MediaQuery.sizeOf(context).width * .3;
    return Center(
      child: Form(
        key: _formKey,
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _displayBarcode(),
            Container(
              width: _fieldMaxWidth,
              height: 120.0,
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.only(top: 12.5),
              child: _barcodeInputField(),
            ),
            SizedBox(
              // color: Colors.amber,
              width: _fieldMaxWidth * 2,
              child: _actionBtn(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _displayBarcode() {
    return Container(
      width: _fieldMaxWidth - 20,
      height: _barcodeHeight + 40.0,
      alignment: Alignment.center,
      padding: const EdgeInsets.only(right: _barcodeFontHeight * .4),
      decoration:
          BoxDecoration(border: Border.all(color: Colors.black, width: 1.0)),
      child: _data != null ? SvgPicture.string(_data!) : null,
    );
  }

  Widget _barcodeInputField() {
    return TextFields.code(
      inputLength: _codeLength,
      controller: _ean13Ctrl,
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'field cannot be empty!';
        }
        if (value.length != _codeLength) {
          return 'must be 13 numbers!';
        }
        if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
          return 'must be numbers only!';
        }
        if (_isValidChecksum(value) != null) {
          return _isValidChecksum(value);
        }
        return null;
      },
      onChanged: (String value) {
        _resetData();
      },
    );
  }

  Widget _actionBtn() {
    if (_data == null) {
      return Center(
          child: Buttons.iconTextInterActive(
        toolTipMsg: '',
        iconName: 'barcode',
        lable: 'Generate',
        onPressed: _generate,
      ));
    }
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Buttons.iconTextInterActive(
          toolTipMsg: '',
          iconName: 'download',
          lable: 'Download',
          onPressed: () =>
              SvgDownloader.single(_data!, fileName: _ean13Ctrl.text.trim()),
        ),
        const SizedBox(width: BgConsts.hSpace),
        Buttons.iconTextInterActive(
          toolTipMsg: '',
          iconName: 'copy',
          lable: 'Copy',
          onPressed: () => CopySvg.data(_data!),
        ),
        const SizedBox(width: BgConsts.hSpace),
        Buttons.iconTextInterActive(
          iconName: 'add_to_sheet',
          lable: 'Save to Sheet',
          toolTipMsg: 'Connect to sheet in settings',
          onPressed: null,
        ),
      ],
    );
  }

  _generate() {
    if (_formKey.currentState!.validate()) {
      final String input = _ean13Ctrl.text.trim();
      final stringData = widget.barcodType.toSvg(
        input,
        width: _barcodeWidth,
        height: _barcodeHeight,
        fontHeight: _barcodeFontHeight,
        fontFamily: 'Arial',
      );

      setState(() {
        _data = stringData;
      });
    } else {}
  }

  void _resetData() {
    if (_data != null) {
      setState(() {
        _data = null;
      });
    }
  }

  String? _isValidChecksum(String input) {
    final int checksum = Checksum(code: input).ean13Checksum();
    final int lastDigit = int.parse(input.split('').last);
    if (checksum != lastDigit) {
      return 'The last number should be "$checksum" instead of "$lastDigit"';
    }
    return null;
  }
}
