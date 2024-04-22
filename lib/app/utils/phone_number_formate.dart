import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  // TextEditingValue formatEditUpdate(
  //     TextEditingValue oldValue, TextEditingValue newValue) {
  //   final String formattedText = _formatPhoneNumber(newValue.text);
  //   return newValue.copyWith(
  //     text: formattedText,
  //     selection: TextSelection.collapsed(offset: formattedText.length),
  //   );
  // }
  //
  // String _formatPhoneNumber(String value) {
  //   // Remove any non-digit characters from the input
  //   value = value.replaceAll(RegExp(r'\D+'), '');
  //
  //   // Apply phone number format
  //   if (value.length >= 4) {
  //     value = '(${value.substring(0, 3)}) ${value.substring(3)}';
  //   }
  //   if (value.length >= 9) {
  //     value = '${value.substring(0, 8)}-${value.substring(8)}';
  //   }
  //   return value;
  // }
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newString = _getFormattedString(newValue.text);
    return newValue.copyWith(
        text: newString, selection: _getSelectionText(newString));
  }

  String _getFormattedString(String value) {
    debugPrint('Phone Number Text>>>>>>>>>>$value>>>');
    value = value.replaceAll("(", '').replaceAll(")", '');
    if (value.isNotEmpty) {
      if (value.length <= 3) {
        return '($value';
      } else if (value.length <= 6) {
        return '(${value.substring(0, 3)}) ${value.substring(3)}';
      } else if (value.length <= 10) {
        return '(${value.substring(0, 3)}) ${value.substring(3, 6)} ${value.substring(6)}';
      } else {
        return '(${value.substring(0, 3)}) ${value.substring(3, 6)} ${value.substring(6, 10)}';
      }
    }
    return '';
  }

  TextSelection _getSelectionText(String value) {
    final selectionIndex = value.length;
    return TextSelection.collapsed(offset: selectionIndex);
  }
}
