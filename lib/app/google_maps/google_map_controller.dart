import 'dart:async';
import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:northshore_nanny_flutter/app/data/storage/storage.dart';
import 'package:northshore_nanny_flutter/app/modules/auth/customer/customer_views/create_profile/create_customer_profile_controller.dart';
import 'package:northshore_nanny_flutter/app/modules/auth/nanny/signUp/signup_controller.dart';
import 'package:northshore_nanny_flutter/app/res/constants/string_contants.dart';

class GoogleMapViewController extends GetxController {
  Rxn<LatLng> currentLatLng = Rxn(LatLng(
      Storage.getValue(StringConstants.latitude),
      Storage.getValue(StringConstants.longitude)));

  final Completer<GoogleMapController> googleMapController =
      Completer<GoogleMapController>();

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

  saveLocationCoordinates() {
    Get.find<CreateCustomerProfileController>()
        .updateLocationTextField(
            position:
                "${currentLatLng.value!.latitude},${currentLatLng.value!.longitude}")
        .then((value) {
      Get.back();
    });
  }
}
