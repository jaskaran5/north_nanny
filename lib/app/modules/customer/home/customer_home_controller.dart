import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'dart:ui' as ui;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:northshore_nanny_flutter/app/data/api/api_helper.dart';
import 'package:northshore_nanny_flutter/app/data/storage/storage.dart';
import 'package:northshore_nanny_flutter/app/models/customer_home_dashboard_response_model.dart';
import 'package:northshore_nanny_flutter/app/models/nanny_favourite_response_model.dart';
import 'package:northshore_nanny_flutter/app/models/nanny_profile_model.dart';
import 'package:northshore_nanny_flutter/app/modules/common/socket/singnal_r_socket.dart';
import 'package:northshore_nanny_flutter/app/modules/customer/get_nanny_profile/get_nanny_profile_view.dart';
import 'package:northshore_nanny_flutter/app/res/constants/api_urls.dart';
import 'package:northshore_nanny_flutter/app/res/constants/app_constants.dart';
import 'package:northshore_nanny_flutter/app/res/constants/enums.dart';
import 'package:northshore_nanny_flutter/app/res/constants/extensions.dart';
import 'package:northshore_nanny_flutter/app/res/constants/string_contants.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/utils/app_utils.dart';
import 'package:northshore_nanny_flutter/app/utils/custom_toast.dart';
import 'package:northshore_nanny_flutter/app/utils/utility.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_dynamic_marker.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

class CustomerHomeController extends GetxController {
  final ApiHelper _apiHelper = ApiHelper.to;

  String? selectedGender = '';
  final _socketHelper = SignalRHelper();

  double distanceLowerValue = Dimens.zero;
  double distanceHigherValue = 25;
  double ageLowerValue = 13;
  double ageHigherValue = 50;
  RxString address = ''.obs;

  final debounce = Debouncer(delay: const Duration(seconds: 1));

  /// SHOW NANNY TILE
  RxString nannyName = ''.obs;
  RxString nannyImage = ''.obs;

  RxBool nannyFavourite = false.obs;
  RxString nannyRatingCount = '0'.obs;
  List<RatingList> nannyRatingList = [];
  RxInt nannyUserId = 0.obs;

  RxString nannyDescription = ''.obs;
  RxString nannyTotalReviews = '0'.obs;
  RxString nannyDistance = ''.obs;
  RxString nannyAge = ''.obs;
  RxString nannyExperience = ''.obs;

  RxBool isNannyDataLoading = true.obs;

  /// FILTER

  RxString filterMinMiles = "0".obs;
  RxString filterMaxMiles = "0".obs;
  RxString filterGender = "0".obs;
  RxString filterMinAge = "0".obs;
  RxString filterMaxAge = "0".obs;
  RxString filterName = "".obs;

  /// use to select Date
  DateTime selectedDate = DateTime.now();

  /// use to select Time
  DateTime selectedTime = DateTime.now();

  Future<void> updateNannyTile({
    required String name,
    required bool isFavourite,
    required String ratingCount,
    required String description,
    required String totalReviews,
    required String distance,
    required String age,
    required String experience,
    required String image,
    required int userId,
    required List<RatingList> ratingList,
  }) async {
    log("exper::->> $experience");
    log("exper is fav::->> $isFavourite");
    log('Tile in map Data : updateNanny');

    nannyName.value = name;
    nannyFavourite.value = isFavourite;
    nannyRatingCount.value = ratingCount;
    nannyDescription.value = description;
    nannyTotalReviews.value = totalReviews;
    nannyDistance.value = distance;
    nannyAge.value = age;
    nannyExperience.value = experience;
    nannyImage.value = image;
    nannyUserId.value = userId;
    nannyRatingList = ratingList;
    update();
  }

  List<String> genderList = GenderConstant.values
      .map((e) => e.genderName.capitalizeFirst.toString())
      .toList();
  RxBool showListView = true.obs;
  RxBool isGoogleMap = false.obs;
  Set<Marker> markers = {};

  RxList<NannyDataList> homeNannyList = <NannyDataList>[].obs;

  // List<String> homeCustomList = ['Distance: ', 'Age: ', 'Experience:'];

  late GoogleMapController googleMapController;

  RxBool isNannyMarkerVisible = false.obs;

  toggleIsNannyMarkerVisible() {
    isNannyMarkerVisible.value = !isNannyMarkerVisible.value;
    update();
  }

  // static const CameraPosition kGooglePlex = CameraPosition(
  //   target: LatLng(30.7046, 76.7179),
  //   zoom: 54.4746,
  // );

  // static const CameraPosition kLake = CameraPosition(
  //     bearing: 192.8334901395799,
  //     target: LatLng(
  //       30.7046,
  //       76.7179,
  //     ),
  //     tilt: 59.440717697143555,
  //     zoom: 19.151926040649414);

  /// UPDATE SCREEN WITH TAP -- GOOGLE MAP/ LIST VIEW

  updateScreen() {
    isGoogleMap.value = !isGoogleMap.value;
    showListView.value = !showListView.value;

    if (showListView.value) {
      isNannyMarkerVisible.value = false;
    }
    update();
  }

  ///------------>>> GET ADDRESS FROM COORDINATES

  Future<String> getAddressFromCoordinates(
      double latitude, double longitude) async {
    log("lat-home--$latitude");
    log("lat-home-long-$longitude");

    try {
      List<Placemark> placeMarks =
          await placemarkFromCoordinates(latitude, longitude);
      Placemark place = placeMarks[0];
      String formattedAddress =
          "${place.street}, ${place.locality}, ${place.country}";

      log("address:-->. $formattedAddress");
      address.value = "${place.locality},${place.country}";
      update();

      return formattedAddress;
    } catch (e) {
      log("Error: $e");
      return '';
    }
  }

  /// *******---------------------------->>>>>>>>>>> ON MAP CREATED

  // void onMapCreated({required GoogleMapController controller}) async {
  //   googleMapController = controller;

  //   // for (int a = 0; a < homeNannyList.length - 1; a++) {
  //   //   markers.add(
  //   //     Marker(
  //   //       markerId: MarkerId("$a"),
  //   //       position: LatLng(
  //   //           double.tryParse(homeNannyList[a].latitude.toString())!,
  //   //           double.tryParse(homeNannyList[a].longitude.toString())!),
  //   //       icon: await TextOnImage(
  //   //         image: homeNannyList[a].image,
  //   //       ).toBitmapDescriptor(
  //   //           logicalSize: const Size(200, 200),
  //   //           imageSize: const Size(200, 200)),
  //   //     ),
  //   //   );
  //   //   update();
  //   // }
  // }

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

  // Future<void> setMarkers() async {
  //   final Uint8List defaultMarkerImage =
  //       await getBytesFromAsset(Assets.imagesNannyMapPin, Get.width ~/ 4);
  //   const size = Size(200, 200);
  //   markers.addAll([
  //     Marker(
  //       icon: BitmapDescriptor.fromBytes(defaultMarkerImage, size: size),
  //       markerId: const MarkerId("00"),
  //       position: const LatLng(30.7046, 76.7179),
  //     ),
  //     Marker(
  //       icon: BitmapDescriptor.fromBytes(defaultMarkerImage, size: size),
  //       markerId: const MarkerId("12"),
  //       position: const LatLng(30.669583801015502, 76.72269824892282),
  //     ),
  //     Marker(
  //       icon: BitmapDescriptor.fromBytes(defaultMarkerImage, size: size),
  //       markerId: const MarkerId("1213"),
  //       position: const LatLng(30.800617977927477, 76.69576685875654),
  //     ),
  //   ]);
  //   await googleMapController.animateCamera(
  //     CameraUpdate.newCameraPosition(
  //       const CameraPosition(
  //         target: LatLng(30.7046, 76.7179),
  //         zoom: 13.4746,
  //       ),
  //     ),
  //   );
  // }

  /// UPDATE FILTER DATA

  /// CONVERT DATE TIME

  String convertDateTimeToString(DateTime dateTime) {
    final dateFormat = DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ');
    return dateFormat.format(dateTime);
  }

  /**  */

  /// GET NANNY LIST DATA WITH LOCATION IN DASHBOARD
  getDashboardApi() async {
    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }
      final dateTime = returnFinalTimeAccordingToDate(
          selectedTime: selectedTime, day: selectedDate);

      debugPrint('final Date Time :$dateTime');
      Map<String, dynamic> body;
      if (isFilterApply.value) {
        body = {
          "minMiles": filterMinMiles.value,
          "maxMiles": filterMaxMiles.value,
          "minAge": filterMinAge.value,
          "maxAge": filterMaxAge.value,
          "dateTime": dateTime.toUtc().toIso8601String(),
          "gender": filterGender.value,
          "name": filterName.value,
        };
      } else {
        body = {
          "minMiles": null,
          "maxMiles": null,
          "minAge": null,
          "maxAge": null,
          "dateTime": null,
          "gender": null,
          "name": null,
        };
      }

      debugPrint('dashboard api body :$body');
      _apiHelper.postApi(ApiUrls.userDashBoard, body).futureValue(
          (value) async {
        Utils.loadingDialog();
        var res = CustomerHomeDashboardResponseModel.fromJson(value);

        if (res.response.toString() ==
            AppConstants.apiResponseSuccess.toString()) {
          log("response success");

          homeNannyList.value = res.data ?? [];
          isNannyDataLoading.value = false;
          update();
          Utils.closeDialog();
          if (res.data != null && res.data!.isNotEmpty) {
            updateNannyMarkers();
          } else {
            Utils.closeDialog();
          }
        }
      }, retryFunction: getDashboardApi);
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      isNannyDataLoading.value = false;
      printError(info: "Get dashboard data post  API ISSUE $s");
    }
  }

  Future<void> updateNannyMarkers() async {
    markers.clear();
    update();
    log("nanny list-->> ${homeNannyList.length}");
    for (int a = 0; a < homeNannyList.length - 1; a++) {
      markers.add(
        Marker(
            markerId: MarkerId("$a"),
            position: LatLng(
                double.tryParse(homeNannyList[a].latitude.toString()) ?? 0.0,
                double.tryParse(homeNannyList[a].longitude.toString()) ?? 0.0),
            icon: await TextOnImage(
              image: homeNannyList[a].image,
            ).toBitmapDescriptor(
                logicalSize: const Size(200, 200),
                imageSize: const Size(200, 200)),
            onTap: () async {
              log("aaaaaaa:-->> $a");
              log("aaaaaaa:-->> ${homeNannyList[a].isFavorite}");
              updateNannyTile(
                      name: homeNannyList[a].name,
                      isFavourite: homeNannyList[a].isFavorite ?? false,
                      ratingCount: homeNannyList[a].rating.toString(),
                      description: homeNannyList[a].aboutMe,
                      totalReviews: homeNannyList[a].reviewCount.toString(),
                      distance:
                          homeNannyList[a].distance?.toInt().toString() ?? '0',
                      age: homeNannyList[a].age.toString(),
                      experience: homeNannyList[a].experience.toString(),
                      image: homeNannyList[a].image.toString(),
                      userId: homeNannyList[a].id ?? 0,
                      ratingList: homeNannyList[a].ratingList ?? [])
                  .then((value) async {
                toggleIsNannyMarkerVisible();

                // markers = markers.difference({markers.elementAt(a)});
                // markers.add(Marker(
                //     markerId: MarkerId("$a"),
                //     position: LatLng(
                //       double.tryParse(
                //           homeNannyList[a].latitude.toString())!,
                //       double.tryParse(
                //           homeNannyList[a].longitude.toString())!,
                //     ),
                //     icon: await TextOnImage(
                //       image: homeNannyList[a].image,
                //       color: AppColors.navyBlue,
                //     ).toBitmapDescriptor(
                //       logicalSize: const Size(200, 200),
                //       imageSize: const Size(200, 200),
                //     )));
                log("on tap on marker");
              });
            }),
      );
    }
    update();
  }

  @override
  void onReady() async {
    super.onReady();
    if (Storage.getValue(StringConstants.loginType) ==
        StringConstants.customer) {
      getDashboardApi();
      // if (isFilterApply.value) {
      //   onClickOnFilterApply(isResetFilters: true);
      // }
      debugPrint('isFilter apply >>>>>>>>>> $isFilterApply');

      var address = getAddressFromCoordinates(
        Storage.getValue(StringConstants.latitude) ?? 0.0,
        Storage.getValue(StringConstants.longitude) ?? 0.0,
      );

      log("customer home address :--->>$address");
    }
    // await setMarkers();
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
          log("response success");
          nannyFavourite.value = !nannyFavourite.value;

          getDashboardApi();

          update();
        }
      }, retryFunction: () {});
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      printError(info: "Get dashboard data post  API ISSUE $s");
    }
  }

  /// used to check filter is applied or not.
  RxBool isFilterApply = false.obs;

  onClickOnFilterApply({required bool isResetFilters}) async {
    var selectedTimeDate = Utility.addTimeToList(
        dates: [selectedDate], addTime: TimeOfDay.fromDateTime(selectedTime));

    log("seleceted datetime -->> $selectedTimeDate");
    log("distacne lower: $distanceLowerValue");
    log("distacne higher: $distanceHigherValue");
    log(" gender: $selectedGender");
    log("age lower: $ageLowerValue");
    log("age higher: $ageHigherValue");

    log("date: $selectedDate");
    log("time: $selectedTime");

    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }
      Map<String, dynamic>? body;
      if (isResetFilters) {
        debugPrint('>>>>>>>>>>>>reset filter Apply');
        body = {
          "minMiles": null,
          "maxMiles": null,
          "minAge": null,
          "maxAge": null,
          "dateTime": null,
          "gender": null,
          "name": '',
        };
        isFilterApply.value = false;
        update();
      } else {
        final dateTime = returnFinalTimeAccordingToDate(
            selectedTime: selectedTime, day: selectedDate);

        debugPrint('final Date Time filter :$dateTime');
        debugPrint('>>>>>>>>>>>>Apply filter ');
        body = {
          "minMiles": distanceLowerValue.toInt(),
          "maxMiles": distanceHigherValue.toInt(),
          "minAge": ageLowerValue.toInt(),
          "maxAge": ageHigherValue.toInt(),
          "dateTime": dateTime.toUtc().toIso8601String(),
          "gender": selectedGender == "Female"
              ? 2
              : selectedGender == "Male"
                  ? 1
                  : 0,
          "name": filterName.value,
        };
        isFilterApply.value = true;
        update();
      }
      log("body apply filter:-->. $body");
      log("isFilter apply >>>>>>>>>>. $isFilterApply");
      _apiHelper.postApi(ApiUrls.userDashBoard, body).futureValue((value) {
        var res = CustomerHomeDashboardResponseModel.fromJson(value);

        if (res.response.toString() ==
            AppConstants.apiResponseSuccess.toString()) {
          log("response success");
          homeNannyList.value = res.data ?? [];
          isNannyDataLoading.value = false;
          update();
          updateNannyMarkers();
          Get.back();
        }
      }, retryFunction: getDashboardApi);
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      isNannyDataLoading.value = false;
      printError(info: "Get dashboard data post  API ISSUE $s");
    }
  }

  /// SEARCH NANNY BY NAME

  _searchNannyByName({required String name}) {
    try {
      // if (!(await Utils.hasNetwork())) {
      //   return;
      // }
      // final dateTime = returnFinalTimeAccordingToDate(
      //     selectedTime: selectedTime, day: selectedDate);

      // debugPrint('final Date Time :$dateTime');
      var body = {
        // "minMiles": filterMinMiles.value,
        // "maxMiles": filterMaxMiles.value,
        // // "minAge": filterMinAge.value,
        // "maxAge": filterMaxAge.value,
        // "dateTime": dateTime.toUtc().toIso8601String(),
        // "gender": filterGender.value,
        "name": name,
      };

      log('body of search api $body');
      _apiHelper.postApi(ApiUrls.userDashBoard, body).futureValue((value) {
        var res = CustomerHomeDashboardResponseModel.fromJson(value);

        if (res.response.toString() ==
            AppConstants.apiResponseSuccess.toString()) {
          log("response success");
          homeNannyList.value = res.data ?? [];
          isNannyDataLoading.value = false;

          update();
          updateNannyMarkers();
        }
      }, retryFunction: getDashboardApi);
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      isNannyDataLoading.value = false;
      printError(info: "Get dashboard data post  API ISSUE $s");
    }
  }

  void searchNanny(String name) {
    debounce.call(() {
      // if (name.trim().isNotEmpty)
      // {
      _searchNannyByName(name: name.trim());
      // }
    });
  }

  @override
  void onInit() {
    socketConnection();
    super.onInit();
  }

  socketConnection() async {
    if (!_socketHelper.isConnected) {
      _socketHelper.init();
    }
    // final signalRHelper = SignalRHelper();
  }

  redirectToGetNannyProfile() async {
    dynamic check =
        await Get.to(const GetNannyProfileView(), arguments: nannyUserId.value);

    if (check != null) {
      getDashboardApi();
      debugPrint("check ---->>>>> $check");
    }
  }

  ///used to get final date with time
  DateTime returnFinalTimeAccordingToDate(
      {required DateTime? selectedTime, required DateTime day}) {
    if (selectedTime != null) {
      log('condition>>>>>>> ${ selectedTime.hour != DateTime.now().hour}');
      return DateTime(
        day.year,
        day.month,
        day.day,
        selectedTime.hour,
        selectedTime.minute,
      );
    } else {
      return DateTime.now();
    }
  }

  /// used for reset filters
  resetFilters() {
    distanceLowerValue = Dimens.zero;
    distanceHigherValue = 25;
    ageLowerValue = 13;
    ageHigherValue = 50;
    selectedGender = '';
    selectedDate = DateTime.now();
    selectedTime = DateTime.now();
    update();
  }
}
