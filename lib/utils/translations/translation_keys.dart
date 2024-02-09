import '../utils.dart';

/// `TranslationKeys` is a singleton class that will contain all the translation keys
///
/// If need to add another key add it inside this class.
/// For simplicity keep the key (variable) name same as its value
///
/// For example
/// ```dart
/// static const String foo = 'foo';
/// ```
///
/// To add the translated strings check [TranslationsFile]
class TranslationKeys {
  const TranslationKeys._();

  static const String appName = 'appName';
}
