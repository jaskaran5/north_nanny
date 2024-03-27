import 'package:auto_size_text/auto_size_text.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as map;
import 'package:lottie/lottie.dart';
import 'package:northshore_nanny_flutter/app/data/storage/storage.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';
import 'package:northshore_nanny_flutter/app/res/constants/string_contants.dart';
import 'package:northshore_nanny_flutter/app/utils/dialog_utils.dart';
import 'package:permission_handler/permission_handler.dart' as permission;
import 'package:tuple/tuple.dart';

import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/utils/custom_toast.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_inkwell_widget.dart';

class Utils {
  Utils._();

  static Future<bool> hasNetwork({bool? showToast}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      toast(msg: "Please check your Internet Connection", isError: true);
      return false;
    } else {
      return true;
    }
  }

  static bool emailValidation(String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    return regex.hasMatch(email);
  }

  static String getHeightsInInches(String height) {
    if (height.isNotEmpty) {
      List<String> splitList = height.runes.map((rune) {
        return String.fromCharCode(rune);
      }).toList();

      return "${splitList.first} feet | ${splitList.last} inches";
    } else {
      return "";
    }
  }

  static Future<void> showLoadingWithText({String? message}) async {
    BotToast.cleanAll();
    BotToast.showCustomLoading(
        useSafeArea: true,
        allowClick: false,
        clickClose: false,
        ignoreContentClick: true,
        align: Alignment.center,
        toastBuilder: (void Function() cancelFunc) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimens.five),
            ),
            margin: EdgeInsets.symmetric(horizontal: Dimens.sixty),
            child: Padding(
              padding: Dimens.edgeInsets10,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: Dimens.fifty,
                    width: Dimens.fifty,
                    child: Center(
                      child: CircularProgressIndicator(
                        backgroundColor: AppColors.chatTimeColor,
                        valueColor: const AlwaysStoppedAnimation(
                            AppColors.primaryColor),
                        strokeWidth: Dimens.seven,
                      ),
                    ),
                  ),
                  Dimens.boxWidth32,
                  Expanded(
                      child: AppText(
                    text: message ?? "Please wait...",
                    textSize: Dimens.sixteen,
                    color: AppColors.blackColor,
                  ))
                ],
              ),
            ),
          );
        });
  }

  static void hideLoader() {
    BotToast.closeAllLoading();
  }

  static void printLog(dynamic log, {String tag = "log---->"}) {
    printLog("\n/***********\n\n $tag $log \n\n*************/\n");
  }

  static void hideKeyboard(context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static void loadingDialog() {
    closeDialog();

    Get.dialog(
      barrierDismissible: false,
      const Center(
          // name: 'loadingDialog',
          child:
              //  Lottie.asset(Assets.animationNannyAni,
              //     width: Get.width / 2, height: Get.width / 2, fit: BoxFit.cover)

              SizedBox(
                  height: 50, width: 50, child: CircularProgressIndicator())),
    );
  }

  static void closeDialog() {
    if (Get.isDialogOpen == true) {
      Get.back();
    }
  }

  static void closeSnackbar() {
    if (Get.isSnackbarOpen == true) {
      Get.back();
    }
  }

  static void showSnackbar(String? message) {
    closeSnackbar();

    Get.rawSnackbar(
        padding: const EdgeInsets.symmetric(
          vertical: 15.0,
          horizontal: 16.0,
        ),
        borderColor: Colors.black,
        backgroundColor: AppColors.greenColor05B016,
        // backgroundGradient: LinearGradient(
        //   colors: AppColors.btnGradient,
        //   begin: Alignment.centerLeft,
        //   end: Alignment.centerRight,
        // ),
        title: 'Alert',
        borderRadius: 20.0,
        messageText: AutoSizeText(
          message!,
        ),

        // message: message,
        snackPosition: SnackPosition.TOP,
        forwardAnimationCurve: Curves.easeOutBack,
        duration: const Duration(seconds: 2));
  }

  static void showDialog(
    String? message, {
    String title = "error",
    bool success = false,
    VoidCallback? onTap,
  }) =>
      Get.defaultDialog(
        barrierDismissible: false,
        onWillPop: () async {
          Get.back();

          onTap?.call();

          return true;
        },
        title: success ? "success" : title,
        content: Text(message ?? 'somethingWentWrong',
            textAlign: TextAlign.center,
            maxLines: 6,
            style: AppStyles.navyBlue15UbW600
            //  AppTextStyle.semiBoldStyle.copyWith(
            //   color: AppColors.chatTimeColor,
            //   fontSize: Dimens.sixteen,
            // ),
            ),
        confirm: Align(
          alignment: Alignment.centerRight,
          child: CustomInkwellWidget.text(
              onTap: () {
                Get.back();

                onTap?.call();
              },
              title: "Ok",
              textStyle: AppStyles.navyBlue15UbW600
              // AppTextStyle.buttonTextStyle.copyWith(
              //   fontSize: Dimens.fontSize18,
              // ),
              ),
        ),
      );

  static Future<Tuple2<map.LatLng, String>?> getCurrentLocation() async {
    try {
      final permissionStatus = await getlocationPermissionStatus();
      if (permissionStatus) {
        var location = await Geolocator.getCurrentPosition(
          desiredAccuracy:
              LocationAccuracy.high, //    forceAndroidLocationManager: true,
        );

        Storage.saveValue(
            StringConstants.latitude, location.latitude.toString());
        Storage.saveValue(
            StringConstants.latitude, location.longitude.toString());

        printLog(location.latitude);
        printLog(location.longitude);
        hideLoader();
        // return Tuple2<map.LatLng, String>(map.LatLng(location.latitude, location.longitude), address);
      } else {
        hideLoader();
        return null;
      }
    } catch (e) {
      //    hideLoader();
      return null;
    }
    return null;
  }

  static Future<bool> getlocationPermissionStatus() async {
    try {
      var permissionStatus = await permission.Permission.location.request();
      if (permissionStatus == permission.PermissionStatus.granted) {
        return true;
      } else if (permissionStatus == permission.PermissionStatus.denied) {
        return false;
      } else if (permissionStatus ==
          permission.PermissionStatus.permanentlyDenied) {
        hideLoader();
        await DialogUtils.openSettingsDialog(
            context: Get.context!,
            onAccept: () async {
              Get.back();
              var res = await permission.openAppSettings();
              if (res) {
                getCurrentLocation();
              }
            });

        // errorredSnackBar("App location permission is denied forever, Please enable it first");
        return false;
      } else {
        // errorredSnackBar("Location permission is need to run this app");
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
