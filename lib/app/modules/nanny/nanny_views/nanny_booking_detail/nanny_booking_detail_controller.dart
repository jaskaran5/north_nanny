import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:northshore_nanny_flutter/app/models/booking_details_model.dart';
import 'package:northshore_nanny_flutter/app/models/booking_status_model.dart';
import 'package:northshore_nanny_flutter/app/modules/common/rating_and_review/rating_and_review_binding.dart';
import 'package:northshore_nanny_flutter/app/modules/common/rating_and_review/rating_and_review_controller.dart';
import 'package:northshore_nanny_flutter/app/modules/common/socket/singnal_r_socket.dart';
import 'package:northshore_nanny_flutter/app/res/constants/extensions.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/navigators/routes_management.dart';

import '../../../../data/api/api_helper.dart';
import '../../../../models/nanny_booking_details.dart';
import '../../../../res/constants/api_urls.dart';
import '../../../../res/constants/app_constants.dart';
import '../../../../res/constants/assets.dart';
import '../../../../res/constants/enums.dart';
import '../../../../utils/app_utils.dart';
import '../../../../utils/custom_toast.dart';
import '../../../../utils/utility.dart';
import 'package:permission_handler/permission_handler.dart' as permission;

class NannyBookingDetailController extends GetxController {
  final ApiHelper _apiHelper = ApiHelper.to;

  /// used to initiate socket
  final SignalRHelper socketHelper = SignalRHelper();

  NannyBookingDetailStatus? nannyBookingDetailStatus;
  Timer? timer;
  int seconds = 0;
  Polyline? nannyPolyLine;
  BookingDetailsModel? bookingDetailsModel;

  RxBool isArrivedButtonEnable = false.obs;

  /// used to check google map controller is Initialize or not
  bool isGoogleControllerInitialize = false;

  // initBooking() async {
  //   if (nannyBookingDetailStatus ==
  //       NannyBookingDetailStatus.waitingForApproval) {
  //     Timer(
  //       const Duration(seconds: 3),
  //       () {
  //         Utility.showDialog(
  //           title: 'Congratulations! ',
  //           assetName: Assets.imagesStar,
  //           subTitle: 'Please rate your experience with this family!',
  //           buttonTitleText: 'Rate Now',
  //           assetWidth: Dimens.ninety,
  //           assetHeight: Dimens.hundredTen,
  //           titleMaxLine: 1,
  //           subTitleMaxLine: 1,
  //           onTapButton: () {
  //             Utility.closeDialog();
  //             if (!Get.isRegistered<RatingAndReviewController>()) {
  //               RatingAndReviewBinding().dependencies();
  //             }
  //             Get.find<RatingAndReviewController>().storeUserData(
  //                 name: bookingDetailsModel?.data?.userDetails?.name ?? '',
  //                 image: bookingDetailsModel?.data?.userDetails?.image ?? '',
  //                 userReviews:
  //                 bookingDetailsModel?.data?.userDetails?.reviewCount ?? 0,
  //                 toUserId: bookingDetailsModel?.data?.userDetails?.userId ?? 0,
  //                 bookedId: bookingDetailsModel?.data?.bookingId ?? 0,
  //                 userRating:
  //                 bookingDetailsModel?.data?.userDetails?.rating ?? 0.0);
  //             RouteManagement.goToRatingReviewScreen();
  //           },
  //           isImage: true,
  //           showCrossSvg: true,
  //         );
  //       },
  //     );
  //   }
  //   // if (isGoogleControllerInitialize && bookingDetailsModel!=null) {
  //   //   log('map initialize:$isGoogleControllerInitialize');
  //   //   await getCurrentLocation();
  //   // }
  // }

  /// report list
  var reportList = [
    'Unavailable for this day/time',
    'Job is too far away',
    'Other'
  ];

  @override
  void dispose() {
    super.dispose();
    seconds = 0;
    timer?.cancel();
    googleMapController?.dispose();
  }

  /// used to store the rejected reason.
  String? rejectionReason;

  /// used to store the other rejection
  final otherRejectionTextEditingController = TextEditingController();

  /// selected index store for report dialog
  int? selectedIndex;

  /// method which is used to return the type of booking.
  typeOfBooking({required int bookingStatus}) {
    if (bookingStatus == 1) {
      nannyBookingDetailStatus = NannyBookingDetailStatus.present;
    } else if (bookingStatus == 2) {
      nannyBookingDetailStatus = NannyBookingDetailStatus.onMyWay;
      // getCurrentLocation();
    } else if (bookingStatus == 3) {
      nannyBookingDetailStatus = NannyBookingDetailStatus.rejected;
    } else if (bookingStatus == 4) {
      nannyBookingDetailStatus = NannyBookingDetailStatus.arrived;
    } else if (bookingStatus == 5) {
      nannyBookingDetailStatus = NannyBookingDetailStatus.endJob;
    } else if (bookingStatus == 6) {
      nannyBookingDetailStatus = NannyBookingDetailStatus.waitingForApproval;
      seconds = 0;
      timer?.cancel();
      update(['timerView']);
    } else if (bookingStatus == 7) {
      nannyBookingDetailStatus = NannyBookingDetailStatus.approvedByAdmin;
    } else if (bookingStatus == 8) {
      nannyBookingDetailStatus = NannyBookingDetailStatus.disputeRaised;
    } else if (bookingStatus == 9) {
      nannyBookingDetailStatus = NannyBookingDetailStatus.givenReviewByCustomer;
    }
    log('Booking Status Nanny Side :$bookingStatus');
    update();
  }

  /// accept or reject booking detail
  acceptOrRejectBookingDetail(
      {required int bookingId,
      required int bookingStatus,
      int? rejectionStatus,
      String? rejectionReason}) async {
    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }
      var body = {
        "bookingId": bookingId,
        "status": bookingStatus,
        "rejectReasonStatus": rejectionStatus,
        "utcDatetTime": DateTime.now().toUtc().toIso8601String(),
        "rejectReason": rejectionReason,
      };
      debugPrint('Accept or reject body:${body.toString()}');
      _apiHelper
          .postApi(
        ApiUrls.acceptOrRejectBooking,
        jsonEncode(body),
      )
          .futureValue((value) {
        printInfo(
            info:
                "  Nanny accept or reject  booking dates in nanny booking details $value");
        var response = NannyBookingDetails.fromJson(value);
        if (response.response == AppConstants.apiResponseSuccess) {
          typeOfBooking(bookingStatus: bookingStatus);
          getBookingDetailOfCustomer(bookingId: bookingId);
          update();
        } else {
          toast(msg: response.message.toString(), isError: true);
        }
      }, retryFunction: () {});
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      printError(info: "Nanny accept or reject   post  API ISSUE $s");
    }
  }

  /// update status
  updateStatus({
    required int bookingId,
    required int bookingStatus,
    DateTime? startTime,
    DateTime? endTime,
  }) async {
    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }
      var body = {
        "bookingId": bookingId,
        "status": bookingStatus,
        if (startTime != null)
          "utcStartTime": startTime.toUtc().toIso8601String(),
        if (endTime != null) "utcEndTime": endTime.toUtc().toIso8601String(),
      };
      log('update status body -> $body');
      _apiHelper
          .postApi(
        ApiUrls.updateBookingStatus,
        jsonEncode(body),
      )
          .futureValue((value) {
        printInfo(info: "Update booking status $value");
        var response = BookingStatusModel.fromJson(value);
        if (response.response == AppConstants.apiResponseSuccess) {
          log('booking Type-:${response.data?.bookingStatus}');
          if (response.data?.bookingStatus == 6) {
            seconds = 0;
            showTimer(
              startTime: DateTime.now(),
            );
          }
          // typeOfBooking(bookingStatus: (response.data?.bookingStatus ?? 0) - 1);
          getBookingDetailOfCustomer(bookingId: response.data?.bookingId ?? 0);
          update(['timerView']);
        } else {
          toast(msg: response.message.toString(), isError: true);
        }
      }, retryFunction: () {});
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      printError(info: "update booking status  API ISSUE $s");
    }
  }

  /// get booking details of customer
  Future<void> getBookingDetailOfCustomer({required int bookingId}) async {
    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }
      var body = {
        "bookingId": bookingId,
        "currentUtcTime": DateTime.now().toUtc().toIso8601String(),
      };
      debugPrint('body of booking details:$body');

      _apiHelper
          .postApi(
        ApiUrls.customerBookedNannyDetail,
        jsonEncode(body),
      )
          .futureValue((value) {
        printInfo(info: " Customer book nanny Customer details   $value");
        var response = BookingDetailsModel.fromJson(value);
        if (response.response == AppConstants.apiResponseSuccess) {
          bookingDetailsModel = response;
          if (response.data?.bookingStatus == 5) {
            seconds = 0;
            showTimer(
              startTime: DateTime.now().add(
                Duration(
                  seconds: Utility.calculateDifferenceInSeconds(
                      response.data?.startTime ?? DateTime.now()),
                ),
              ),
            );
            update();
          }
          if (response.data?.bookingStatus == 7) {
            seconds == 0;
            timer?.cancel();
            update(['timerView']);
            Future.delayed(const Duration(seconds: 4));
            Utility.showDialog(
              title: 'Congratulations! ',
              assetName: Assets.imagesStar,
              subTitle: 'Please rate your experience with this family!',
              buttonTitleText: 'Rate Now',
              assetWidth: Dimens.ninety,
              assetHeight: Dimens.hundredTen,
              titleMaxLine: 1,
              subTitleMaxLine: 1,
              onTapButton: () {
                Utility.closeDialog();
                if (!Get.isRegistered<RatingAndReviewController>()) {
                  RatingAndReviewBinding().dependencies();
                }
                Get.find<RatingAndReviewController>().storeUserData(
                    name: bookingDetailsModel?.data?.userDetails?.name ?? '',
                    image: bookingDetailsModel?.data?.userDetails?.image ?? '',
                    userReviews:
                        bookingDetailsModel?.data?.userDetails?.reviewCount ??
                            0,
                    toUserId:
                        bookingDetailsModel?.data?.userDetails?.userId ?? 0,
                    bookedId: bookingDetailsModel?.data?.bookingId ?? 0,
                    userRating:
                        bookingDetailsModel?.data?.userDetails?.rating ?? 0.0);
                RouteManagement.goToRatingReviewScreen();
              },
              isImage: true,
              showCrossSvg: true,
            );
          }
          typeOfBooking(bookingStatus: response.data?.bookingStatus ?? 0);
          addPolyLine(
              currentPosition: currentPosition, bookingDetailsModel: response);
          getCurrentLocation();
        } else {
          toast(msg: response.message.toString(), isError: true);
        }
        update();
      }, retryFunction: () {});
      //
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      printError(
          info: "Customer book nanny Customer details get  API ISSUE $s");
    }
  }

  /// used to show the start time.
  showTimer({required DateTime startTime}) {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      seconds = DateTime.now().difference(startTime).inSeconds;
      update(['timerView']);
    });
  }

  /// ------------------- Tracking things start here --------------------
  ///
  /// used to initialize google Map
  GoogleMapController? googleMapController;

  void onMapCreated(GoogleMapController controller) async {
    googleMapController = controller;
    isGoogleControllerInitialize = true;
    update(['tracking']);
  }

  /// current position
  Position? currentPosition;

  /// used to stop the tracking and enable
  StreamSubscription<Position>? locationStream;

  /// used to update current location on basis of tracking
  Future<void> getCurrentLocation() async {
    try {
      var status = await getLocationPermissionStatus();
      if (status != null && status) {
        try {
          var permissionStatus = await permission.Permission.location.request();
          if (permissionStatus == permission.PermissionStatus.granted) {
            LocationSettings locationSettings = const LocationSettings();

            if (Platform.isAndroid) {
              locationSettings = AndroidSettings(
                  accuracy: LocationAccuracy.bestForNavigation,
                  distanceFilter: 10,
                  forceLocationManager: false,
                  // intervalDuration: const Duration(seconds: 5),
                  foregroundNotificationConfig:
                      const ForegroundNotificationConfig(
                          notificationText:
                              "Location is being used for navigation",
                          notificationTitle: "North-Nanny",
                          enableWakeLock: true,
                          setOngoing: true,
                          notificationIcon:
                              AndroidResource(name: "@mipmap/ic_launcher")));
            } else if (Platform.isIOS) {
              locationSettings = AppleSettings(
                  accuracy: LocationAccuracy.bestForNavigation,
                  activityType: ActivityType.automotiveNavigation,
                  distanceFilter: 10,
                  // timeLimit: const Duration(seconds: 5),
                  showBackgroundLocationIndicator: true,
                  allowBackgroundLocationUpdates: true);
            } else {
              locationSettings = const LocationSettings(
                accuracy: LocationAccuracy.high,
                distanceFilter: 10,
                // timeLimit: Duration(seconds: 5),
              );
            }
            log('nanny Booking Status  :$nannyBookingDetailStatus and ${(nannyBookingDetailStatus == NannyBookingDetailStatus.onMyWay || nannyBookingDetailStatus == NannyBookingDetailStatus.arrived)}');
            if ((nannyBookingDetailStatus == NannyBookingDetailStatus.onMyWay ||
                    nannyBookingDetailStatus ==
                        NannyBookingDetailStatus.arrived) &&
                bookingDetailsModel?.data?.openingDate?.day ==
                    DateTime.now().day &&
                bookingDetailsModel?.data?.openingDate?.month ==
                    DateTime.now().month &&
                bookingDetailsModel?.data?.openingDate?.year ==
                    DateTime.now().year) {
              locationStream = Geolocator.getPositionStream(
                      locationSettings: locationSettings)
                  .listen((Position? position) async {
                log('-----------------------position --- $position -------------------> ');
                if (position != null) {
                  currentPosition = position;
                  log("**************** POSITION :  -->> ${currentPosition!.latitude},${currentPosition!.longitude}");
                  final distance = Geolocator.distanceBetween(
                    position.latitude,
                    position.longitude,
                    double.parse(
                        bookingDetailsModel?.data?.userDetails?.latitude ??
                            '0.0'),
                    double.parse(
                        bookingDetailsModel?.data?.userDetails?.longitude ??
                            '0.0'),
                  );

                  log('distance>>>>>>>>>>>>>>>>>>>> $distance');
                  if (distance <= 50.0) {
                    isArrivedButtonEnable.value = true;
                    update();
                  }

                  /// used to send the data according to lat long.
                  updateLatLong(
                      toUserId:
                          bookingDetailsModel?.data?.userDetails?.userId ?? 0,
                      bookingId: bookingDetailsModel?.data?.bookingId ?? 0,
                      latitude: position.latitude,
                      longitude: position.longitude);

                  /// used to add poly Line according to the road or route.
                  addPolyLine(
                    currentPosition: currentPosition,
                    bookingDetailsModel: bookingDetailsModel,
                  );

                  /// used to animate the controller based on lat long.
                  googleMapController?.animateCamera(
                      CameraUpdate.newCameraPosition(CameraPosition(
                          target: LatLng(position.latitude, position.longitude),
                          zoom: 10)));
                  log('-----------------------tracking on -------------------> ');
                }

                update(['tracking-view']);
              });
            } else if (nannyBookingDetailStatus ==
                    NannyBookingDetailStatus.waitingForApproval ||
                nannyBookingDetailStatus == NannyBookingDetailStatus.endJob) {
              locationStream?.pause();
              log('-----------------------tracking off -------------------> ');
            }
            update(['tracking-view']);
          }
        } catch (e) {
          log(e.toString());
        }
      } else {}
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// used to get current location
  Future<bool?> getLocationPermissionStatus() async {
    try {
      var permissionStatus = await permission.Permission.location.request();
      if (permissionStatus == permission.PermissionStatus.granted) {
        return true;
      } else if (permissionStatus == permission.PermissionStatus.denied) {
        return false;
      } else if (permissionStatus ==
          permission.PermissionStatus.permanentlyDenied) {
        return false;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  /// socket method which is use to update the  lat long
  updateLatLong({
    required int toUserId,
    required int bookingId,
    required double latitude,
    required double longitude,
  }) async {
    log('latitude:${latitude.toString()} ,longitude:${longitude.toString()} ,  bookingId:$bookingId, toUserId:$toUserId');

    await socketHelper.hubConnection.invoke('TrackNanny', args: [
      toUserId,
      bookingId,
      latitude.toString(),
      longitude.toString(),
    ]);
    log('lat long sent');
  }

  /// used  for create poly Line with the road by route.
  addPolyLine(
      {required Position? currentPosition,
      required BookingDetailsModel? bookingDetailsModel}) async {
    var fistCoordinate = LatLng(
        currentPosition?.latitude ??
            double.parse(bookingDetailsModel?.data?.latitude ?? '0.0'),
        currentPosition?.longitude ??
            double.parse(bookingDetailsModel?.data?.longitude ?? '0.0'));
    var secondCoordinate = LatLng(
        double.parse(bookingDetailsModel?.data?.userDetails?.latitude ?? '0.0'),
        double.parse(
            bookingDetailsModel?.data?.userDetails?.longitude ?? '0.0'));
    nannyPolyLine =
        await Utility.setPolylineDirection(fistCoordinate, secondCoordinate);
    update(['tracking-view']);
  }
}
