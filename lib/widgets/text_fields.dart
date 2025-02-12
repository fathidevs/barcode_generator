import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFields {
  static Widget ean13({
    required TextEditingController controller,
    required String? Function(String?) validator,
    required Function(String) onChanged,
  }) {
    return TextFormField(
      controller: controller,
      inputFormatters: [
        LengthLimitingTextInputFormatter(13),
      ],
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      style: const TextStyle(
          fontWeight: FontWeight.w900, fontSize: 22.0, letterSpacing: 5.0),
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
      validator: (String? value) => validator(value),
      onChanged: onChanged,
    );
  }
}
