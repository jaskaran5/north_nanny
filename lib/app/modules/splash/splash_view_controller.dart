import 'dart:developer';
import 'package:location/location.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/data/storage/storage.dart';
import 'package:northshore_nanny_flutter/app/res/constants/string_contants.dart';
import 'package:northshore_nanny_flutter/app/utils/app_utils.dart';
import 'package:northshore_nanny_flutter/navigators/routes_management.dart';

class SplashController extends GetxController {
  RxBool isLogin = false.obs;

  Location location = Location();
  bool _serviceEnabled = false;
  PermissionStatus _permissionGranted = PermissionStatus.denied;
  LocationData? _locationData;
  @override
  void onInit() {
    super.onInit();

    startOnInit();
  }

  checkSession() {
    if (Storage.hasData(StringConstants.isLogin)) {
      if (Storage.getValue(StringConstants.isLogin)) {
        RouteManagement.goToOffAllDashboard(isFromSetting: false);
      }
    } else {
      RouteManagement.goChooseBabySitter();
    }
  }

  Future<void> getCurrentLocation() async {
    final hasLocationPermission = await Utils.getlocationPermissionStatus();

    log("has location permission: $hasLocationPermission");

    if (hasLocationPermission) {
      try {
        _serviceEnabled = await location.serviceEnabled();
        if (!_serviceEnabled) {
          _serviceEnabled = await location.requestService();
          if (!_serviceEnabled) {
            return;
          }
        }

        _permissionGranted = await location.hasPermission();
        if (_permissionGranted == PermissionStatus.denied) {
          _permissionGranted = await location.requestPermission();
          if (_permissionGranted != PermissionStatus.granted) {
            return;
          }
        }

        _locationData = await location.getLocation();
        log("Latitude: ${_locationData!.latitude}, Longitude: ${_locationData!.longitude}");

        if (_locationData != null) {
          Storage.saveValue(StringConstants.latitude, _locationData!.latitude);
          Storage.saveValue(
              StringConstants.longitude, _locationData!.longitude);
        }
      } catch (e) {
        log("Error getting location: $e");
      }
    }
  }

  saveDeviceTypeAndToken() async {
    if (GetPlatform.isAndroid) {
      Storage.saveValue(StringConstants.deviceType, 'android');
    } else if (GetPlatform.isIOS) {
      Storage.saveValue(StringConstants.deviceType, 'ios');
    }
  }

  // var isLoggedIn = false;

  void startOnInit() async {
    await Future.delayed(
      const Duration(seconds: 5),
    );

    checkSession();

    // RouteManagement.goToOffAllHome(ChooseInterface.customer);
    // if (isLoggedIn) {

    // } else {
    //   RouteManagement.goToSignIn();
    // }
  }

  @override
  void onReady() {
    saveDeviceTypeAndToken();
    getCurrentLocation();
    super.onReady();
  }
}
