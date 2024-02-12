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
  static const String findTheBestBabySitter = "findTheBestBabySitter";
  static const String needASitter = 'needASitter';
  static const String iAmSitter = 'iAmSitter';
  static const String helloRegistration = 'helloRegistration';
  static const String creatingAnAccount = 'creatingAnAccount';
  static const String enterEmail = 'enterEmail';
  static const String enterPassword = 'enterPassword';
  static const String confirmPassword = 'confirmPassword';
  static const String bySignUp = 'bySignUp';
  static const String termAndConditions = 'termAndConditions';
  static const String and = 'and';
  static const String privacyPolicy = 'privacyPolicy';
  static const String register = 'register';
  static const String alreadyHaveAccount = 'alreadyHaveAccount';
  static const String signIn = 'signIn';
  static const String welComeBackGlad = 'welComeBackGlad';
  static const String enterLogInInfo = 'enterLogInInfo';
  static const String rememberMe = 'rememberMe';
  static const String forgotPassword = 'forgotPassword';
  static const String orLoginWith = 'orLoginWith';
  static const String doNotHaveAnAccount = 'doNotHaveAnAccount';
  static const String registerNow = 'registerNow';
  static const String doNotWorryEnterEmail = 'doNotWorryEnterEmail';
  static const String sendCode = 'sendCode';
}
