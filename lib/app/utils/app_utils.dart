import 'package:auto_size_text/auto_size_text.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_inkwell_widget.dart';

class Utils {
  Utils._();

  // static Future<bool> hasNetwork({bool? showToast}) async {
  //   var connectivityResult = await (Connectivity().checkConnectivity());
  //   if (connectivityResult == ConnectivityResult.none) {
  //     toast(msg: "Please check your Internet Connection", isError: true);
  //     return false;
  //   } else {
  //     return true;
  //   }
  // }

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
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            margin: const EdgeInsets.symmetric(horizontal: 60),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 50,
                    width: 50,
                    child: Center(
                      child: CircularProgressIndicator(
                        backgroundColor: AppColors.chatTimeColor,
                        valueColor:
                            AlwaysStoppedAnimation(AppColors.primaryColor),
                        strokeWidth: 7,
                      ),
                    ),
                  ),
                  Dimens.boxWidth32,
                  Expanded(
                      child: AppText(
                    text: message ?? "Please wait...",
                    textSize: 16.sp,
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
    print("\n/***********\n\n $tag $log \n\n*************/\n");
  }

  static void hideKeyboard(context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static void loadingDialog() {
    closeDialog();

    Get.dialog(
      const Center(
          child: SizedBox(
              height: 150, width: 150, child: CircularProgressIndicator()

              //  Image.asset('assets/icons/new_app_logo.png')

              )),
      name: 'loadingDialog',
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
}
