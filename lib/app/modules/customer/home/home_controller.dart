import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:northshore_nanny_flutter/app/data/api/api_helper.dart';
import 'package:northshore_nanny_flutter/app/models/dashboard_response_model.dart';
import 'package:northshore_nanny_flutter/app/res/constants/api_urls.dart';
import 'package:northshore_nanny_flutter/app/res/constants/app_constants.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';
import 'package:northshore_nanny_flutter/app/utils/app_utils.dart';
import 'package:northshore_nanny_flutter/app/utils/custom_toast.dart';
import 'package:northshore_nanny_flutter/app/utils/extensions.dart';

class HomeController extends GetxController {
  final ApiHelper _apiHelper = ApiHelper.to;

  RxBool showListView = false.obs;
  RxBool isGoogleMap = true.obs;
  final Set<Marker> markers = {};

  List<String> homeCustomList = [
    'Distance: 3 miles',
    'Age: 40',
    'Experience: 7+ yrs'
  ];

  late GoogleMapController googleMapController;

  static const CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(
        37.42796133580664,
        -122.085749655962,
      ),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  /// UPDATE SCREEN WITH TAP -- GOOGLE MAP/ LIST VIEW

  updateScreen() {
    isGoogleMap.value = !isGoogleMap.value;
    showListView.value = !showListView.value;
    update();
  }

  /// *******---------------------------->>>>>>>>>>> ON MAP CREATED

  void onMapCreated({required GoogleMapController controller}) async {
    googleMapController = controller;

    markers.add(
      Marker(
        markerId: const MarkerId("nanny"),
        position: const LatLng(37.42796133580664, -122.085749655962),
        icon: await BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(devicePixelRatio: 2.0), Assets.iconsMap),
      ),
    );
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    final res = await fi.image.toByteData(format: ui.ImageByteFormat.png);
    if (res != null) {
      return (res).buffer.asUint8List();
    } else {
      return Uint8List(0);
    }
  }

  Future<void> setMarkers() async {
    final Uint8List defaultMarkerImage =
        await getBytesFromAsset('assets/icons/image.png', Get.width ~/ 4);
    const size = Size(50, 50);
    markers.addAll([
      Marker(
        icon: BitmapDescriptor.fromBytes(defaultMarkerImage, size: size),
        markerId: const MarkerId("00"),
        position: const LatLng(37.42796133580664, -122.085749655962),
      ),
      Marker(
        icon: BitmapDescriptor.fromBytes(defaultMarkerImage, size: size),
        markerId: const MarkerId("12"),
        position: const LatLng(30.669583801015502, 76.72269824892282),
      ),
      Marker(
        icon: BitmapDescriptor.fromBytes(defaultMarkerImage, size: size),
        markerId: const MarkerId("1213"),
        position: const LatLng(30.800617977927477, 76.69576685875654),
      ),
    ]);
    await googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        const CameraPosition(
          target: LatLng(37.42796133580664, -122.085749655962),
          zoom: 13.4746,
        ),
      ),
    );
  }

  getDashboardApi() async {
    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }

      _apiHelper.getPosts(ApiUrls.userDashBoard).futureValue((value) {
        var res = DashboardResponseModel.fromJson(value);

        if (res.response == AppConstants.apiResponseSuccess) {
          // toast(msg: "");
        }
      }, retryFunction: getDashboardApi);
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      printError(info: "Contact Us post  API ISSUE $s");
    }
  }

  @override
  void onReady() async {
    // getDashboardApi();
    super.onReady();
    await setMarkers();
  }
}
