import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast({required String message, Color? color}) {
  Fluttertoast.showToast(
      gravity: ToastGravity.TOP,
      backgroundColor: color ?? Colors.black,
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      timeInSecForIosWeb: 1);
}

String addStringsWithSpace(String str1, String str2) {
  return '$str1 $str2';
}
