import 'dart:async';
import 'dart:developer';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:northshore_nanny_flutter/app/data/storage/storage.dart';
import 'package:northshore_nanny_flutter/app/modules/auth/customer/customer_views/create_profile/create_customer_profile_controller.dart';
import 'package:northshore_nanny_flutter/app/modules/nanny/nanny_views/create_profile/create_nanny_profile_controller.dart';
import 'package:northshore_nanny_flutter/app/res/constants/string_contants.dart';

class GoogleMapViewController extends GetxController {
  Rxn<LatLng> currentLatLng = Rxn(LatLng(
      Storage.getValue(StringConstants.latitude),
      Storage.getValue(StringConstants.longitude)));

  final Completer<GoogleMapController> googleMapController =
      Completer<GoogleMapController>();

  RxBool isFromEdit = false.obs;

  @override
  void onInit() {
    getUserLocation().then((value) async {
      log("location position is:-->> $value");

      await updateCurrentPosition(
        latitude: value!.latitude,
        longitude: value.longitude,
      );
    });
    super.onInit();
  }

  updateCurrentPosition({required double latitude, required double longitude}) {
    currentLatLng.value = LatLng(latitude, longitude);

    update();
  }

  Future<Position?> getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled
      // Request location service
      serviceEnabled = await Geolocator.openLocationSettings();
      if (!serviceEnabled) {
        // Location services are still not enabled, return null
        return null;
      } else {}
    }

    // Check location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Location permission is denied
      // Request location permission
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        // Location permission is still denied, return null
        return null;
      }
    }

    // Get user's current position
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    return position;
  }

  initilizedGoogleMapController({contro}) {
    googleMapController.complete(contro);
    update();
  }

  Future<String> getAddressFromCoordinates(
      double latitude, double longitude) async {
    try {
      List<Placemark> placeMarks =
          await placemarkFromCoordinates(latitude, longitude);
      Placemark place = placeMarks[0];
      String formattedAddress =
          "${place.street}, ${place.locality}, ${place.country}";

      return formattedAddress;
    } catch (e) {
      log("Error: $e");
      return '';
    }
  }

  updateIsFromData() {
    isFromEdit.value = true;
    update();
  }

  saveLocationCoordinates() async {
    var logInType = await Storage.getValue(StringConstants.loginType);
    var address = await getAddressFromCoordinates(
        currentLatLng.value?.latitude ?? 0.0,
        currentLatLng.value?.longitude ?? 0.0);
    if (logInType == StringConstants.customer) {
      Get.find<CreateCustomerProfileController>()
          .updateLocationTextField(
        position: address,
      )
          .then((value) {
        Get.back();
      });
    } else if (logInType == StringConstants.nanny) {
      Get.find<CreateNannyProfileController>()
          .updateLocationTextField(
        formatAddress: address,
      )
          .then((value) {
        Get.back();
      });
    }
  }

  Future<String> getEditLocation() async {
    var address = await getAddressFromCoordinates(
        currentLatLng.value?.latitude ?? 0.0,
        currentLatLng.value?.longitude ?? 0.0);

    return address;
  }
}
