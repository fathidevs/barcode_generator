import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../tools/bg_consts.dart';

class TextFields {
  static Widget code({
    required TextEditingController controller,
    required String? Function(String?) validator,
    required Function(String) onChanged,
    required int inputLength,
    BorderRadius radius =
        const BorderRadius.all(Radius.circular(BgConsts.radius)),
  }) {
    return TextFormField(
      controller: controller,
      inputFormatters: [
        LengthLimitingTextInputFormatter(inputLength),
      ],
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      style: const TextStyle(
          fontWeight: FontWeight.w900, fontSize: 22.0, letterSpacing: 5.0),
      decoration: InputDecoration(
        isDense: false,
        errorStyle: const TextStyle(height: 1.0),

        border: OutlineInputBorder(
          borderRadius: radius,
        ),
        // errorText: null,
      ),
      validator: (String? value) => validator(value),
      onChanged: onChanged,
    );
  }
}
