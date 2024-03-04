import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';

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
}
