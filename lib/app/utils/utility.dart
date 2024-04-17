import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';
import 'package:northshore_nanny_flutter/app/res/constants/enums.dart';
import 'package:northshore_nanny_flutter/app/res/constants/extensions.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/utils/custom_toast.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_button.dart';

import '../google_maps/direction_helper.dart';
import '../res/theme/colors.dart';

class Utility {
  const Utility._();

  static void hideKeyboard() => FocusManager.instance.primaryFocus?.unfocus();

  /// Returns true if the internet connection is available.
  // static Future<bool> get isNetworkAvailable async {
  //   final result = await Connectivity().checkConnectivity();
  //   return [
  //     ConnectivityResult.mobile,
  //     ConnectivityResult.wifi,
  //     ConnectivityResult.ethernet
  //   ].contains(result);
  // }

  static Future<T?> openBottomSheet<T>(
    Widget child, {
    Color? backgroundColor,
    bool isDismissible = true,
    ShapeBorder? shape,
  }) async =>
      await Get.bottomSheet<T>(
        child,
        barrierColor: AppColors.greyColor.withOpacity(.2),
        backgroundColor: backgroundColor,
        isDismissible: isDismissible,
        shape: shape,
        isScrollControlled: true,
      );

  static Future<TimeOfDay> pickTime({
    required BuildContext context,
    required TimeOfDay initialTime,
  }) async =>
      (await showTimePicker(
        context: context,
        initialTime: initialTime,
        initialEntryMode: TimePickerEntryMode.inputOnly,
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        ),
      )) ??
      initialTime;

  /// Show loader
  // static void showLoader() async {
  //   await Get.dialog(
  //     const AppLoader(),
  //     barrierDismissible: false,
  //   );
  // }

  /// Close loader
  static void closeLoader() {
    closeDialog();
  }

  // /// Show error dialog from response model
  // static Future<void> showInfoDialog(ResponseModel data, [
  //   bool isSuccess = false,
  //   String? title,
  // ]) async {
  //   await Get.dialog(
  //     CupertinoAlertDialog(
  //       title: Text(
  //         title ?? (isSuccess ? 'Success' : 'Error'),
  //       ),
  //       content: Text(
  //         jsonDecode(data.data)['message'] as String,
  //       ),
  //       actions: [
  //         CupertinoDialogAction(
  //           onPressed: Get.back,
  //           isDefaultAction: true,
  //           child: Text(
  //             'Okay',
  //             style: Styles.black16,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  /// Show info dialog
  static void showDialog({
    required String assetName,
    required String title,
    required String subTitle,
    required String buttonTitleText,
    required double assetWidth,
    required double assetHeight,
    required int titleMaxLine,
    required int subTitleMaxLine,
    required Function() onTapButton,
    required bool isImage,
    required bool showCrossSvg,
    Color? buttonColor,
    TextStyle? buttonStyle,
  }) async {
    await Get.dialog(
      Padding(
        padding: Dimens.edgeInsetsL16R16,
        child: Center(
          child: Material(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(Dimens.twenty),
            child: Container(
              padding: Dimens.edgeInsets16,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(Dimens.twenty),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (showCrossSvg) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: SvgPicture.asset(
                                Assets.iconsRemoveBottomSheet)),
                      ],
                    ),
                    Dimens.boxHeight2,
                  ],
                  isImage
                      ? Image.asset(assetName)
                      : SvgPicture.asset(
                          assetName,
                          alignment: Alignment.center,
                          width: assetWidth,
                          height: assetHeight,
                        ),
                  Dimens.boxHeight20,
                  AppText(
                    text: title,
                    style: AppStyles.ubBlack0B0B18W700,
                    maxLines: titleMaxLine,
                  ),
                  Dimens.boxHeight10,
                  AppText(
                    text: subTitle,
                    style: AppStyles.ub5E5F60Grey14W400,
                    maxLines: subTitleMaxLine,
                  ),
                  Dimens.boxHeight16,
                  CustomButton(
                    title: buttonTitleText,
                    backGroundColor: buttonColor ?? AppColors.navyBlue,
                    titleStyle: buttonStyle,
                    onTap: onTapButton,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Show alert dialog
  static void showAlertDialog({
    String? message,
    String? title,
    String? firstButtonTitle,
    String? secondButtonTitle,
    Color? secondButtonBackgroundColor,
    Color? firstButtonBackgroundColor,
    String assetName = '',
    String imageName = '',
    String secondButtonSvg = '',
    required Function() onTapFirstButton,
    required Function() onTapSecondButton,
    TextStyle? secondButtonStyle,
    TextStyle? firstButtonStyle,
    bool showContentSvg = false,
    bool isSvgImage = false,
    bool showButtonSvg = false,
  }) async {
    await Get.dialog(
      Padding(
        padding: Dimens.edgeInsetsL16R16,
        child: Center(
          child: Material(
            borderRadius: BorderRadius.circular(Dimens.twenty),
            type: MaterialType.card,
            child: Container(
              padding: Dimens.edgeInsets16,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(Dimens.twenty),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (showContentSvg) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: SvgPicture.asset(
                                Assets.iconsRemoveBottomSheet)),
                      ],
                    ),
                    Dimens.boxHeight4,
                    isSvgImage
                        ? SvgPicture.asset(assetName)
                        : Image(image: AssetImage(imageName)),
                  ],
                  Dimens.boxHeight16,
                  AppText(
                    text: title,
                    style: AppStyles.ubBlack0B0B18W700,
                    maxLines: 1,
                  ),
                  Dimens.boxHeight16,
                  Flexible(
                    child: AppText(
                      text: message,
                      style: AppStyles.ub5E5F60Grey14W400,
                      maxLines: 4,
                    ),
                  ),
                  Dimens.boxHeight26,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Utility.closeDialog();
                          onTapFirstButton();
                        },
                        child: Container(
                          height: Dimens.forty,
                          width: Dimens.hundredForty,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: firstButtonBackgroundColor,
                            borderRadius: BorderRadius.circular(Dimens.eight),
                          ),
                          child: AppText(
                            text: firstButtonTitle,
                            style: firstButtonStyle,
                            maxLines: 1,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Utility.closeDialog();
                          onTapSecondButton();
                        },
                        child: Container(
                          height: Dimens.forty,
                          width: Dimens.hundredForty,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: secondButtonBackgroundColor,
                            borderRadius: BorderRadius.circular(Dimens.eight),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AppText(
                                text: secondButtonTitle,
                                style: secondButtonStyle,
                                maxLines: 1,
                              ),
                              if (showButtonSvg) ...[
                                Dimens.boxWidth4,
                                SvgPicture.asset(
                                  secondButtonSvg,
                                  height: Dimens.sixteen,
                                  width: Dimens.sixteen,
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Close any open dialog.
  static void closeDialog() {
    if (Get.isDialogOpen ?? false) Get.back<void>();
  }

  /// Close any open snackbar
  static void closeSnackbar() {
    if (Get.isSnackbarOpen) Get.back<void>();
  }

  /// SHOW IMAGE PICKER
  static Future<void> showImagePicker({
    required Function(CroppedFile image) onGetImage,
  }) {
    return showModalBottomSheet<void>(
      context: Get.context!,
      builder: (_) {
        return Padding(
          padding: Dimens.edgeInsets10,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    getImage(source: 2).then((v) {
                      if (v != null) {
                        onGetImage(v);
                        Get.back();
                      }
                    });
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.image,
                        size: Dimens.sixty,
                      ),
                      Dimens.boxHeight10,
                      Text("Gallery",
                          textAlign: TextAlign.center,
                          style: AppStyles.b0b0fairPlay15w600)
                    ],
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    getImage().then((v) {
                      if (v != null) {
                        onGetImage(v);
                        Get.back();
                      }
                    });
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.camera, size: Dimens.sixty),
                      Dimens.boxHeight10,
                      Text("Camera",
                          textAlign: TextAlign.center,
                          style: AppStyles.b0b0fairPlay15w600)
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  static Future<CroppedFile?> getImage({int source = 1}) async {
    CroppedFile? croppedFile;
    final picker = ImagePicker();

    final pickedFile = await picker.pickImage(
      source: source == 1 ? ImageSource.camera : ImageSource.gallery,
      imageQuality: 60,
    );

    if (pickedFile != null) {
      final image = File(pickedFile.path);

      croppedFile = await ImageCropper().cropImage(
        compressQuality: 50,
        sourcePath: image.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
        ],
        //   uiSettings: IOSUiSettings(
        //     minimumAspectRatio: 0.1,
        //     aspectRatioLockDimensionSwapEnabled: true,
        //   ),
      );
    }

    return croppedFile;
  }

  /// used to convert 24 hours format to 12 hours
  static String convertTo12HourFormat(String time24) {
    // Split the time string into hours and minutes
    List<String> parts = time24.split(":");
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);

    // Convert hour to 12-hour format
    if (hour > 12) {
      hour -= 12;
    } else if (hour == 0) {
      hour = 12;
    }

    // Return the formatted time
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }

  /// used to convert date time to this format '[February 2024, Friday']
  static String convertDateToMMMMYYYEEE(DateTime date) {
    return DateFormat('MMMM yyyy, EEEE').format(date);
  }

  /// used to convert date time to this format '[February 2024, Friday']
  static String convertDatetimeToMMMMddYYYY(DateTime date) {
    return DateFormat('MMMM dd, yyyy').format(date);
  }

  /// used to convert date time to this format '[01/03/2024']
  static String convertStringToDateFormatDDMMYY(String date) {
    // print("date-- $date");
    return DateFormat('dd/MM/yyyy').format(DateTime.parse(date));
  }

  /// used to convert date time to Time of day
  static TimeOfDay convertDateTimeToTimeOfDay(DateTime dateTime) {
    var formatDate =
        DateFormat("yyyy-MM-dd HH:mm:ss").parse(dateTime.toString(), true);
    var value = TimeOfDay.fromDateTime(formatDate.toLocal());
    log('time of day:$value');
    return value;
  }

  /// this is used to show format in date time.
  static String formatTimeTo12Hour(String? dateTimeString) {
    if ((dateTimeString == null) || (dateTimeString.isEmpty)) {
      return "";
    }
    var dateTime =
        DateFormat("yyyy-MM-dd HH:mm:ss").parse(dateTimeString, true);
    var dateLocal = dateTime.toLocal();
    String formattedTime = DateFormat('hh:mm a').format(dateLocal);
    return formattedTime;
  }

  /// this is used to get a day from date
  static String getDay({required DateTime? dateTime}) {
    return dateTime?.day.toString().padLeft(2, '0') ?? '';
  }

  /// used to get days  according to start time and end time
  static List<DateTime> getDaysInBetween(
      {required DateTime startDate, required DateTime endDate}) {
    List<DateTime> days = [];
    DateTime currentDate = startDate;
    while (!currentDate.isAfter(endDate)) {
      days.add(currentDate);
      currentDate = currentDate.add(const Duration(days: 1));
    }
    return days;
  }

  /// this method used to return the list by add the timing to the list.
  static List<DateTime> addTimeToList(
      {required List<DateTime> dates, required TimeOfDay? addTime}) {
    List<DateTime> updatedList = [];
    for (DateTime date in dates) {
      DateTime updatedDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        addTime!.hour,
        addTime.minute,
      );
      updatedList.add(updatedDateTime);
    }
    return updatedList;
  }

  /// this method is used to return price according to minutes
  static returnPriceAccordingToMinuetBasis(
      {required int childCount, required int minuets}) {
    if (minuets != 0) {
      if (childCount == 1) {
        return ((HourlyChildrenRateList.oneChild.ratePricePerChildren / 60) *
                minuets)
            .toStringAsFixed(2);
      } else if (childCount == 2) {
        return ((HourlyChildrenRateList.twoChildren.ratePricePerChildren / 60) *
                minuets)
            .toStringAsFixed(2);
      } else if (childCount == 3) {
        return ((HourlyChildrenRateList.threeChildren.ratePricePerChildren /
                    60) *
                minuets)
            .toStringAsFixed(2);
      } else if (childCount == 4) {
        return ((HourlyChildrenRateList.forChildren.ratePricePerChildren / 60) *
                minuets)
            .toStringAsFixed(2);
      } else if (childCount > 4) {
        return ((HourlyChildrenRateList.forPlusChildren.ratePricePerChildren /
                    60) *
                minuets)
            .toStringAsFixed(2);
      } else {
        return '0.0';
      }
    }
  }

  /// this is used to return a minutes according to time
  static int calculateTotalMinutesDifference(
      TimeOfDay startTime, TimeOfDay endTime) {
    // Convert start time to minutes
    int startMinutes = startTime.hour * 60 + startTime.minute;

    // Convert end time to minutes
    int endMinutes = endTime.hour * 60 + endTime.minute;

    // Calculate the difference in minutes
    int differenceInMinutes = endMinutes - startMinutes;

    // Return the absolute value to handle cases where end time is before start time
    return differenceInMinutes.abs();
  }

  /// this method is used to get greeting message.
  static String getGreetingMessage() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good morning';
    } else if (hour < 17) {
      return 'Good afternoon';
    } else {
      return 'Good evening';
    }
  }

  /// this method is used to return the hour, minutes, and seconds according to second.
  static String returnHMS({required int second}) {
    // Convert seconds to hours, minutes, and seconds
    int hours = second ~/ 3600;
    int minutes = (second ~/ 60) % 60;
    int seconds = second % 60;
    return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  /// this method is used to return seconds difference according to dateTime
  static int calculateDifferenceInSeconds(DateTime givenTime) {
    DateTime now = DateTime.now().toLocal();

    // Convert given time to local time
    var test =
        DateFormat("yyyy-MM-dd HH:mm:ss").parse(givenTime.toString(), true);

    var localGivenTime = test.toLocal();
    debugPrint('local difference :$localGivenTime');
    Duration difference = localGivenTime.difference(now);
    int differenceInSeconds = difference.inSeconds;
    log('difference in seconds -: $differenceInSeconds');
    return differenceInSeconds;
  }

  /// used to return the actual time.
  static String calculateTotalTimeDifference(
      DateTime? startTime, DateTime? endTime) {
    DateTime localStartTime = DateFormat("yyyy-MM-dd HH:mm:ss")
        .parse(startTime.toString(), true)
        .toLocal();

    DateTime localEndTime = DateFormat("yyyy-MM-dd HH:mm:ss")
        .parse(endTime.toString(), true)
        .toLocal();

    // Calculate the difference
    Duration difference = localEndTime.difference(localStartTime);

    return '${difference.inHours}:${difference.inMinutes}:${difference.inSeconds}';
  }

  /// used to get the time zone
  static Future<String> getTimeZone() async {
    var timeZone = await FlutterTimezone.getLocalTimezone();
    debugPrint('timeZone:$timeZone');
    return timeZone;
  }

  /// used to check the opening time a closing time is between the given time.
  static Future<bool> checkTimeRange(
      DateTime selectedTime, DateTime openingTime, DateTime closingTime) async {
    var selectedDateTime =
        DateTime.parse(DateFormat('yyyy-MM-dd HH:mm').format(selectedTime));
    var openingDateTime =
        DateTime.parse(DateFormat('yyyy-MM-dd HH:mm').format(openingTime));
    var closingDateTime =
        DateTime.parse(DateFormat('yyyy-MM-dd HH:mm').format(closingTime));
    log('selected Time:$selectedDateTime');
    log('Opening Time:$openingDateTime');
    log('Closing Time:$closingDateTime');
    if (selectedDateTime.isBefore(openingDateTime) ||
        selectedDateTime.isAfter(closingDateTime)) {
      log(" Start time is before opening time or end time is after closing time.");
      toast(
          msg:
              'Start time is before opening time or end time is after closing time.',
          isError: true);
      return false;
    } else {
      log("Start time and end time are within the opening hours.");
      return true;
    }
  }

  /// used to convert time of day to date time
  static DateTime timeOfDayToDateTime(TimeOfDay time, DateTime date) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  /// used to return the polyLine according to origin and designation.
static setPolylineDirection(LatLng origin, LatLng destination) async {
  List<LatLng> polylineCoordinates = [];

  log("polyline :${origin.latitude}");
  log("polyline :${destination.longitude}");
  final result=await DirectionHelper()
      .getRouteBetweenCoordinates(origin.latitude, origin.longitude,
      destination.latitude, destination.longitude);
  log("result.toString()---->${result.toString()}");
  if (result.isNotEmpty) {

    for (PointLatLng point in result) {
      polylineCoordinates.add(LatLng(point.latitude, point.longitude));
    }

    return Polyline(
      polylineId: const PolylineId('line'),
      color: AppColors.navyBlue3288DE,
      points: polylineCoordinates,
      width: 6,
      startCap: Cap.squareCap,
      endCap: Cap.roundCap,
    );
  }
}
}
