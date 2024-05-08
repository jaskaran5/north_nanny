import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:northshore_nanny_flutter/app/data/storage/storage.dart';
import 'package:northshore_nanny_flutter/app/models/location_lat_long_model.dart';
import 'package:northshore_nanny_flutter/app/modules/auth/customer/customer_views/create_profile/create_customer_profile_controller.dart';
import 'package:northshore_nanny_flutter/app/modules/nanny/nanny_views/create_profile/create_nanny_profile_controller.dart';
import 'package:northshore_nanny_flutter/app/res/constants/string_contants.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';

class GoogleMapViewController extends GetxController {
  RxBool isFromEdit = false.obs;

  final searchLocationTextEditingController = TextEditingController();

  // Rxn<LatLng> currentLatLng = Rxn(LatLng(
  //     Storage.getValue(StringConstants.latitude) ?? 30.7046,
  //     Storage.getValue(StringConstants.longitude) ?? 76.7179));
  Rx<LatLng> currentLatLng = Rx(const LatLng(0, 0));
//
  GoogleMapController? googleMapController;

  @override
  void onInit() {
    getUserLocation().then((value) async {
      log("location position is:-->> $value");

      // await updateCurrentPosition(
      //   latitude: value!.latitude,
      //   longitude: value.longitude,
      // );
    });
    searchLocationTextEditingController.clear();

    isFromEdit.value = Get.arguments ?? false;

    log("-----isfromEdit--->>>. ${isFromEdit.value}");
    update();
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

  initializeGoogleMapController({required GoogleMapController controller}) {
    googleMapController = controller;
    log('>>>>>>>>>> map Created>>>>>>>>>>>>>>>>');
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

  updateIsFromEdit({required bool isFrom}) {
    isFromEdit.value = isFrom;
    log('isFrom Edit :$isFrom   >>>>>>> ${currentLatLng.value}');
    searchLocationTextEditingController.clear();
    update();
  }

  saveLocationCoordinates() async {
    var logInType = await Storage.getValue(StringConstants.loginType);
    String address = '';
    if (currentLatLng.value.longitude == 0.0) {
      address = await getAddressFromCoordinates(
          Storage.getValue(StringConstants.latitude),
          Storage.getValue(StringConstants.longitude));
      log('current lat long 0.0>>>>>>$address');
    }
    log('address >>>>>> $address   ${searchLocationTextEditingController.text}');
    if (logInType == StringConstants.customer) {
      Get.find<CreateCustomerProfileController>()
          .updateLocationTextField(
        position: currentLatLng.value.longitude != 0.0
            ? searchLocationTextEditingController.text
            : address,
        lat: currentLatLng.value.latitude.toString(),
        long: currentLatLng.value.longitude.toString(),
      )
          .then((value) {
        Get.back();
      });
    } else if (logInType == StringConstants.nanny) {
      Get.find<CreateNannyProfileController>()
          .updateLocationTextField(
        formatAddress: currentLatLng.value.longitude != 0.0
            ? searchLocationTextEditingController.text
            : address,
        lat: currentLatLng.value.latitude.toString(),
        long: currentLatLng.value.longitude.toString(),
      )
          .then((value) {
        Get.back();
      });
    }
  }

  Future<LocationLatLongModel> getEditLocation() async {
    return LocationLatLongModel(
      latitude: currentLatLng.value.latitude.toString(),
      longitude: currentLatLng.value.longitude.toString(),
      location: searchLocationTextEditingController.text,
    );
  }

  /// used to get location on based on search .
  updateCameraPositionOfMapBySearch(
      {required String lat, required String lon}) async {
    if (lat.isNotEmpty && lat != 'null' || lon.isNotEmpty && lon != 'null') {
      var latitude = double.parse(lat);
      var longitude = double.parse(lon);
      log('lat long update:$latitude  , $longitude');
      googleMapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(latitude, longitude),
            zoom: Dimens.ten,
          ),
        ),
      );
      currentLatLng.value = LatLng(latitude, longitude);
    }
    update();
  }

  LatLng returnLatLong() {
    if (currentLatLng.value.longitude == 0.0) {
      var value = currentLatLng.value;
      return value;
    } else {
      return LatLng(Storage.getValue(StringConstants.latitude),
          Storage.getValue(StringConstants.longitude));
    }
  }
}
