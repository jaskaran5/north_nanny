import 'dart:async';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeController extends GetxController {
  RxBool showListView = false.obs;
  RxBool isGoogleMap = true.obs;

  List<String> homeCustomList = [
    'Distance: 3 miles',
    'Age: 40',
    'Experience: 7+ yrs'
  ];

  final Completer<GoogleMapController> googleMapController =
      Completer<GoogleMapController>();

  static const CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  /// UPDATE SCREEN WITH TAP -- GOOGLE MAP/ LIST VIEW

  updateScreen() {
    isGoogleMap.value = !isGoogleMap.value;
    showListView.value = !showListView.value;
    update();
  }
}
