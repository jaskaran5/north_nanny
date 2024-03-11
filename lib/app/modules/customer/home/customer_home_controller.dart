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
import 'package:northshore_nanny_flutter/app/res/constants/enums.dart';
import 'package:northshore_nanny_flutter/app/res/constants/extensions.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/utils/app_utils.dart';
import 'package:northshore_nanny_flutter/app/utils/custom_toast.dart';
import 'package:northshore_nanny_flutter/app/utils/extensions.dart';

class CustomerHomeController extends GetxController {
  final ApiHelper _apiHelper = ApiHelper.to;

  String? selectedGender = '';

  double distanceLowerValue = Dimens.zero;
  double distanceHigherValue = Dimens.ten;
  double ageLowerValue = Dimens.thirteen;
  double ageHigherValue = Dimens.fifty;

  /// use to select Date
  DateTime selectedDate = DateTime.now();

  /// use to select Time
  DateTime selectedTime = DateTime.now();

  List<String> genderList = GenderConstant.values
      .map((e) => e.genderName.capitalizeFirst.toString())
      .toList();
  RxBool showListView = false.obs;
  RxBool isGoogleMap = true.obs;
  final Set<Marker> markers = {};

  RxList homeNannyList = [].obs;

  List<String> homeCustomList = [
    'Distance: 3 miles',
    'Age: 40',
    'Experience: 7+ yrs'
  ];

  late GoogleMapController googleMapController;

  static const CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(30.7046, 76.7179),
    zoom: 14.4746,
  );

  static const CameraPosition kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(
        30.7046,
        76.7179,
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
        position: const LatLng(30.7046, 76.7179),
        icon: await BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(devicePixelRatio: 2.0),
            Assets.imagesNannyMapPin),
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
        await getBytesFromAsset(Assets.imagesNannyMapPin, Get.width ~/ 4);
    const size = Size(200, 200);
    markers.addAll([
      Marker(
        icon: BitmapDescriptor.fromBytes(defaultMarkerImage, size: size),
        markerId: const MarkerId("00"),
        position: const LatLng(30.7046, 76.7179),
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
          target: LatLng(30.7046, 76.7179),
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

      var body = {
        "minMiles": 0,
        "maxMiles": 0,
        "minAge": 0,
        "maxAge": 0,
        "dateTime": "2024-03-08T05:51:50.263Z",
        "gender": 0,
        "name": "string"
      };

      _apiHelper.postApi(ApiUrls.userDashBoard, body).futureValue((value) {
        var res = DashboardResponseModel.fromJson(value);

        if (res.response == AppConstants.apiResponseSuccess) {
          homeNannyList.value = res.data ?? [];
          update();
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
    getDashboardApi();
    super.onReady();
    await setMarkers();
  }
}
