import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/internacionalization.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_en.dart';

class TranslationsFile extends Translations {
  /// List of locales used in the application
  static const listOfLocales = <Locale>[
    Locale('en'),
  ];

  @override
  Map<String, Map<String, String>> get keys => {
        'en': en,
      };
}
