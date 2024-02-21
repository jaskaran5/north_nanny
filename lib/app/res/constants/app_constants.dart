/// `AppConstants` is a singleton class with all static variables.
///
/// It contains all constants that are to be used within the project
///
/// If need to check the translated strings that are used in UI (Views) of the app, check [TranslationKeys]
class AppConstants {
  const AppConstants._();

  static const String appName = 'NorthShore Nanny';
  static const String fontFamilyPlayfairDisplay = 'PlayfairDisplay';
  static const String fontFamilyUrbanist = 'Urbanist';
  static const String isNanny = 'isNanny';

  static const Duration timeOutDuration = Duration(seconds: 60);
}
