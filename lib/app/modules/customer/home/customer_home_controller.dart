import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'dart:ui' as ui;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:northshore_nanny_flutter/app/data/api/api_helper.dart';
import 'package:northshore_nanny_flutter/app/models/customer_home_dashboard_response_model.dart';
import 'package:northshore_nanny_flutter/app/models/dashboard_response_model.dart';
import 'package:northshore_nanny_flutter/app/models/nanny_favourite_response_model.dart';
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
  final debounce = Debouncer(delay: const Duration(milliseconds: 10));

  /// FILTER

  RxString filterMinMiles = "0".obs;
  RxString filterMaxMiles = "0".obs;
  RxString filterGender = "0".obs;
  RxString filterMinAge = "0".obs;
  RxString filterMaxAge = "0".obs;
  RxString filterDateTime = "".obs;
  RxString filterName = "".obs;

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

  RxList<NannyDataList> homeNannyList = <NannyDataList>[].obs;

  // List<String> homeCustomList = ['Distance: ', 'Age: ', 'Experience:'];

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

  /// UPDATE FILTER DATA

  /// CONVERT DATE TIME

  String convertDateTimeToString(DateTime dateTime) {
    final dateFormat = DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ');
    return dateFormat.format(dateTime);
  }

  /// GET NANNY LIST DATA WITH LOCATION IN DASHBOARD
  getDashboardApi(
      // {
      //   minMiles,
      //   maxMiles,
      //   minAge,
      //   maxAge,
      //   dateTime,
      //   gender,
      //   name,
      // }
      ) async {
    // String newDateTime = convertDateTimeToString(DateTime.now());
    try {
      // if (!(await Utils.hasNetwork())) {
      //   return;
      // }

      var body = {
        "minMiles": filterMinMiles.value,
        "maxMiles": filterMaxMiles.value,
        "minAge": filterMinAge.value,
        "maxAge": filterMaxAge.value,
        "dateTime": filterDateTime.value,
        "gender": filterGender.value,
        "name": filterName.value,
      };

      _apiHelper.postApi(ApiUrls.userDashBoard, body).futureValue((value) {
        var res = CustomerHomeDashboardResponseModel.fromJson(value);

        if (res.response.toString() ==
            AppConstants.apiResponseSuccess.toString()) {
          print("response success");
          homeNannyList.value = res.data ?? [];
          update();
        }
      }, retryFunction: getDashboardApi);
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      printError(info: "Get dashboard data post  API ISSUE $s");
    }
  }

  @override
  void onReady() async {
    getDashboardApi();
    super.onReady();
    await setMarkers();
  }

  toggleFavouriteAndUnFavouriteApi(
      {required int userId, required bool isFavourite}) {
    try {
      var body = {
        "toUserId": userId,
        "isFavorite": isFavourite,
      };

      _apiHelper.postApi(ApiUrls.addOrRemoveFavoriteNanny, body).futureValue(
          (value) {
        var res = NannyFavouriteResponseModel.fromJson(value);

        if (res.response.toString() ==
            AppConstants.apiResponseSuccess.toString()) {
          print("response success");

          getDashboardApi();

          update();
        }
      }, retryFunction: () {});
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      printError(info: "Get dashboard data post  API ISSUE $s");
    }
  }

  onClickOnFilterApply() async {
    log("distacne lower: $distanceLowerValue");
    log("distacne higher: $distanceHigherValue");
    log(" gender: $selectedGender");
    log("age lower: $ageLowerValue");
    log("age higher: $ageHigherValue");

    log("date: $selectedDate");
    log("time: $selectedTime");

    try {
      // if (!(await Utils.hasNetwork())) {
      //   return;
      // }

      var body = {
        "minMiles": distanceLowerValue.toInt(),
        "maxMiles": distanceHigherValue.toInt(),
        "minAge": ageLowerValue.toInt(),
        "maxAge": ageHigherValue.toInt(),
        "dateTime": filterDateTime.value,
        "gender": selectedGender == "female"
            ? 2
            : selectedGender == "male"
                ? 1
                : 0,
        "name": filterName.value,
      };

      _apiHelper.postApi(ApiUrls.userDashBoard, body).futureValue((value) {
        var res = CustomerHomeDashboardResponseModel.fromJson(value);

        if (res.response.toString() ==
            AppConstants.apiResponseSuccess.toString()) {
          print("response success");
          homeNannyList.value = res.data ?? [];

          update();

          Get.back();
        }
      }, retryFunction: getDashboardApi);
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      printError(info: "Get dashboard data post  API ISSUE $s");
    }
  }

  /// SEARCH NANNY BY NAME

  _searchNannyByName({required String name}) {
    try {
      // if (!(await Utils.hasNetwork())) {
      //   return;
      // }

      var body = {
        "minMiles": filterMinMiles.value,
        "maxMiles": filterMaxMiles.value,
        "minAge": filterMinAge.value,
        "maxAge": filterMaxAge.value,
        "dateTime": filterDateTime.value,
        "gender": filterGender.value,
        "name": name,
      };

      _apiHelper.postApi(ApiUrls.userDashBoard, body).futureValue((value) {
        var res = CustomerHomeDashboardResponseModel.fromJson(value);

        if (res.response.toString() ==
            AppConstants.apiResponseSuccess.toString()) {
          print("response success");
          homeNannyList.value = res.data ?? [];
          update();
        }
      }, retryFunction: getDashboardApi);
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      printError(info: "Get dashboard data post  API ISSUE $s");
    }
  }

  void searchNanny(String name) {
    debounce.call(() {
      if (name.trim().isNotEmpty) {
        _searchNannyByName(name: name);
      }
    });
  }
}
