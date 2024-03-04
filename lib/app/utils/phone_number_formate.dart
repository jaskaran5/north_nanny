import 'package:flutter/services.dart';

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final String formattedText = _formatPhoneNumber(newValue.text);
    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }

  String _formatPhoneNumber(String value) {
    // Remove any non-digit characters from the input
    value = value.replaceAll(RegExp(r'\D+'), '');

    // Apply phone number format
    if (value.length >= 4) {
      value = '(${value.substring(0, 3)}) ${value.substring(3)}';
    }
    if (value.length >= 9) {
      value = '${value.substring(0, 8)}-${value.substring(8)}';
    }
    return value;
  }
}
