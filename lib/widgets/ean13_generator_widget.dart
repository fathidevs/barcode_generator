import 'package:barcode/barcode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../tools/checksum.dart';
import '../tools/copy_svg_data.dart';
import 'text_fields.dart';

class Ean13GeneratorWidget extends StatefulWidget {
  final Barcode barcodType;
  const Ean13GeneratorWidget({super.key, required this.barcodType});

  @override
  State<Ean13GeneratorWidget> createState() => _Ean13GeneratorWidgetState();
}

TextEditingController _ean13Ctrl = TextEditingController();
String? _data;

const int _codeLength = 13;

class _Ean13GeneratorWidgetState extends State<Ean13GeneratorWidget> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.amber.withOpacity(.4),
        width: MediaQuery.sizeOf(context).width * .2,
        child: Form(
          key: _formKey,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _displayBarcode(),
              TextFields.ean13(
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
              ),
              _actionBtn(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _displayBarcode() {
    return Container(
      width: 200.0,
      height: 80.0,
      color: Colors.amber,
      child: _data != null ? SvgPicture.string(_data!) : null,
    );
  }

  Widget _actionBtn() {
    return _data == null
        ? ElevatedButton(onPressed: _generate, child: const Text('Generate'))
        : ElevatedButton(
            onPressed: () => CopySvg.data(_data!),
            // SvgDownloader.single(_data!, fileName: _ean13Ctrl.text.trim()),
            child: const Text('Copy'));
  }

  _generate() {
    if (_formKey.currentState!.validate()) {
      final String input = _ean13Ctrl.text.trim();
      final stringData = widget.barcodType.toSvg(
        input,
        width: 200,
        height: 80,
        fontHeight: 20,
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
