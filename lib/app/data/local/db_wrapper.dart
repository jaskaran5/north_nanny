import 'package:get/get.dart';

import 'managers/shared_preferences_manager.dart';

class DBWrapper {
  // final _flutterSecureStorage = const FlutterSecureStorageManager();
  //
  // /// Get data from secure storage
  //
  // Future<String> getSecuredValue(String key, {String defaultValue = ''}) async {
  //   try {
  //     return await _flutterSecureStorage.getSecuredValue(key);
  //   } catch (error) {
  //     return defaultValue;
  //   }
  // }
  //
  // /// Save data in secure storage
  // Future<void> saveValueSecurely(String key, String value) async =>
  //     _flutterSecureStorage.saveValueSecurely(key, value);
  //
  // /// Delete data from secure storage
  // Future<void> deleteSecuredValue(String key) async =>
  //     _flutterSecureStorage.deleteSecuredValue(key);
  //
  // /// Delete all data from secure storage
  // Future<void> deleteAllSecuredValues() async =>
  //     _flutterSecureStorage.deleteAllSecuredValues();
  final _preference = Get.find<SharedPreferencesManager>();
  Future<void> init() async => await _preference.init();

  void clearData(String key) => _preference.delete(key);

  /// Delete the box
  void deleteBox() => _preference.clear();

  /// Returns stored string value
  String getStringValue(String key, {String defaultValue = ''}) =>
      _preference.getStringValue(key, defaultValue);

  /// store the data
  void saveValue<T>(String key, T value) =>
      _preference.saveSharedValue(key, value);

  /// return bool value
  bool? getBoolValue(
    String key,
  ) =>
      _preference.getBoolValue(
        key,
      );

  /// return bool value
  int getIntValue(String key, {int defaultValue = 0}) =>
      _preference.getIntValue(key, defaultValue);
}
