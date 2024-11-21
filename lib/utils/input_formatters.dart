import 'package:flutter/services.dart';

class SriLankanNICFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final int newTextLength = newValue.text.length;
    final StringBuffer formattedText = StringBuffer();

    if (RegExp(r'^[0-9]{9}[VvXx]?$').hasMatch(newValue.text)) {
      for (int i = 0; i < newTextLength; i++) {
        final String char = newValue.text[i];

        if (RegExp(r'[0-9]').hasMatch(char) ||
            ((char == 'V' || char == 'v' || char == 'x' || char == 'X') && i == newTextLength - 1)) {
          formattedText.write(char.toUpperCase());
        }
      }
    } else {
      for (int i = 0; i < newTextLength; i++) {
        final String char = newValue.text[i];

        if (formattedText.length != 12) {
          if (RegExp(r'[0-9]').hasMatch(char)) {
            formattedText.write(char);
          }
        }
      }
    }

    return TextEditingValue(
      text: formattedText.toString(),
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}


class CurrencyBackSpaceClearStopFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '0.00', selection: TextSelection.collapsed(offset: 4));
    } else if (newValue.text == "0.00" && newValue.selection.base == 4) {
      return oldValue;
    } else {
      return newValue;
    }
  }
}