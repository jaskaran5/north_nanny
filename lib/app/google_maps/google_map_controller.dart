import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapViewController extends GetxController {
  LatLng currentPosition = const LatLng(0.0, 0.0);

  RxDouble currentLat = 30.7046.obs;
  RxDouble currentLong = 76.7179.obs;

  late GoogleMapController googleMapController;

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
    currentLat.value = latitude;
    currentLong.value = longitude;

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
    googleMapController = contro;
    update();
  }
}
