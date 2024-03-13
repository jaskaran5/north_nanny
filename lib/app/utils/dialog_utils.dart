import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_button.dart';

class DialogUtils {
  DialogUtils._();
  static showNeedPermissionDialog(
      {required BuildContext context,
      VoidCallback? onAccept,
      VoidCallback? onReject}) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /* AppText(
                    text: "Location Permission",
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w700,
                  ),
                  yHeight(20),*/
                  // Lottie.asset(Assets.locationRequest, height: 150),
                  const Icon(Icons.location_on),
                  const AppText(
                    text:
                        "This app requires access to your location. Please grant the location permission to continue using the app.",
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.center,
                    lineHeight: 1.5,
                  ),
                  Dimens.boxHeight20,
                  CustomButton(
                    width: 120,
                    backGroundColor: AppColors.primaryColor,
                    onTap: onAccept ??
                        () {
                          Get.back();
                        },
                    title: "Enable Location",
                  ),
                  Dimens.boxHeight20,

                  CustomButton(
                    title: "cancel",
                    backGroundColor: AppColors.primaryColor,
                    onTap: onReject ??
                        () {
                          Get.back();
                        },
                  ),
                  // Btn(
                  //   title: "cancel",
                  //   backGroundColor: AppColor.white,
                  //   textColor: AppColor.primary,
                  //   onTap: onReject?? () {
                  //     Get.back();
                  //   },
                  // ),
                ],
              ));
        });
  }

  static openSettingsDialog(
      {required BuildContext context,
      VoidCallback? onAccept,
      VoidCallback? onReject}) {
    return showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Lottie.asset(Assets.locationRequest, height: 150),
                  const Icon(Icons.location_on),
                  const AppText(
                    text:
                        "This app requires location services. Please enable location services in your device settings.",
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.center,
                    lineHeight: 1.5,
                  ),
                  Dimens.boxHeight20,
                  CustomButton(
                    width: 120,
                    backGroundColor: AppColors.primaryColor,
                    onTap: onAccept ??
                        () {
                          Get.back();
                        },
                    title: "Enable Location",
                  ),
                  Dimens.boxHeight20,

                  CustomButton(
                    title: "cancel",
                    backGroundColor: AppColors.primaryColor,
                    onTap: onReject ??
                        () {
                          Get.back();
                        },
                  ),
                  // Btn(
                  //   title: "cancel",
                  //   backGroundColor: AppColor.white,
                  //   textColor: AppColor.primary,
                  //   onTap:onReject?? () {
                  //     Get.back();
                  //   },
                  // ),
                ],
              ));
        });
  }

  static openAlwaysAllowDialog(
      {required BuildContext context,
      VoidCallback? onAccept,
      VoidCallback? onReject}) {
    return showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Lottie.asset(Assets.locationRequest, height: 150),
                  const Icon(Icons.location_on),
                  const AppText(
                    text:
                        "Enable always location access to receive personalized notifications about nearby basketball courts and events",
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.center,
                    lineHeight: 1.5,
                  ),
                  Dimens.boxHeight20,
                  CustomButton(
                    width: 120,
                    backGroundColor: AppColors.primaryColor,
                    onTap: onAccept ??
                        () {
                          Get.back();
                        },
                    title: "Enable Location",
                  ),

                  // Btn(
                  //   title: "Enable Location",
                  //   onTap: onAccept??() {
                  //     Get.back();
                  //   },
                  // ),
                  Dimens.boxHeight20,

                  CustomButton(
                    width: 120,
                    backGroundColor: AppColors.primaryColor,
                    onTap: onReject ??
                        () {
                          Get.back();
                        },
                    title: "Done",
                  ),
                  // Btn(
                  //   title: "cancel",
                  //   backGroundColor: AppColor.white,
                  //   textColor: AppColor.primary,
                  //   onTap:onReject?? () {
                  //     Get.back();
                  //   },
                  // ),
                ],
              ));
        });
  }

  static showSuccessDialog(
      {required BuildContext context,
      VoidCallback? onDoneButtonPress,
      String? message,
      bool? barrierDismissible}) {
    return showDialog(
        context: Get.context!,
        barrierDismissible: barrierDismissible ?? false,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Lottie.asset(Assets.successAnimation, height: 120),
                  const Icon(Icons.location_on),
                  Dimens.boxHeight20,
                  AppText(
                    text: message,
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.center,
                    lineHeight: 1.5,
                  ),
                  Dimens.boxHeight20,

                  CustomButton(
                    title: 'Done',
                    onTap: onDoneButtonPress ??
                        () {
                          Get.back();
                        },
                  ),
                  // Btn(
                  //   width: 130,
                  //   title: "Done",
                  //   onTap: onDoneButtonPress??() {
                  //     Get.back();
                  //   },
                  // ),
                  Dimens.boxHeight20,
                ],
              ));
        });
  }

  static showErrorDialog(
      {required BuildContext context,
      VoidCallback? onDoneButtonPress,
      String? message}) {
    return showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Lottie.asset(Assets.error, height: 120),
                  Dimens.boxHeight20,

                  AppText(
                    text: message,
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.center,
                    lineHeight: 1.5,
                  ),
                  Dimens.boxHeight20,

                  CustomButton(
                    width: 120,
                    onTap: onDoneButtonPress ??
                        () {
                          Get.back();
                        },
                    title: "Done",
                  ),
                  // Btn(
                  //   width: 120,
                  //   title: "Done",
                  //   onTap: onDoneButtonPress??() {
                  //     Get.back();
                  //   },
                  // ),
                  Dimens.boxHeight20,
                ],
              ));
        });
  }

  static Future<void> customInfoDialog({
    required BuildContext context,
    required String title,
    required String content,
    required VoidCallback onTapYes,
    VoidCallback? onNoTap,
    String? yesText,
    String? noText,
  }) async {
    await showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        insetAnimationCurve: Curves.linearToEaseOut,
        title: AppText(
          text: title,
          textSize: 20.sp,
          fontWeight: FontWeight.w600,
        ),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AppText(
            text: content,
            textSize: 15.sp,
            fontWeight: FontWeight.w400,
            lineHeight: 1.2,
          ),
        ),
        actions: [
          CupertinoButton(
            onPressed: onNoTap ?? () => Navigator.pop(context),
            child: Text(
              noText ?? "Cancel",
              style: const TextStyle(
                  fontSize: 15,
                  color: CupertinoColors.systemBlue,
                  fontWeight: FontWeight.w600),
            ),
          ),
          CupertinoButton(
            onPressed: onTapYes,
            child: Text(
              yesText ?? "Log Out",
              style: const TextStyle(
                  color: CupertinoColors.systemRed,
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  static showCustomDialog({
    required BuildContext context,
    required Widget child,
    bool? barrierDismissible,
  }) {
    return showDialog(
        context: context,
        barrierDismissible: barrierDismissible ?? false,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              content: child);
        });
  }
}
