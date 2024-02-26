import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_button.dart';

import '../res/theme/colors.dart';

class Utility {
  const Utility._();

  static void hideKeyboard() => FocusManager.instance.primaryFocus?.unfocus();

  static bool? isNannyInterFace() {
    return null;
  }

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
  }) async {
    await Get.dialog(
      AlertDialog(
          alignment: Alignment.center,
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimens.twenty),
            borderSide:const  BorderSide(color: AppColors.primaryColor)
          ),
          backgroundColor: AppColors.primaryColor,
          contentPadding: Dimens.edgeInsets16,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
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
                backGroundColor: AppColors.navyBlue,
                onTap: onTapButton,
              )
            ],
          )),
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

  /// Show a message to the user.
  ///
  /// [message] : Message you need to show to the user.
  /// [type] : Type of the message for different background color.
  /// [onTap] : An event for onTap.
  /// [actionName] : The name for the action.

// static void showMessage({
//   String? message,
//   MessageType type = MessageType.information,
//   Function()? onTap,
//   String? actionName,
// }) {
//   if (message == null || message.isEmpty) return;
//   closeDialog();
//   closeSnackbar();
//   var backgroundColor = Colors.black;
//   switch (type) {
//     case MessageType.error:
//       backgroundColor = Colors.red;
//       break;
//     case MessageType.information:
//       backgroundColor = Colors.blue;
//       break;
//     case MessageType.success:
//       backgroundColor = Colors.green;
//       break;
//     default:
//       backgroundColor = Colors.black;
//       break;
//   }
//   Future.delayed(
//     const Duration(seconds: 0),
//     () {
//       Get.rawSnackbar(
//         messageText: Text(
//           message,
//           style: Styles.white16,
//         ),
//         mainButton: actionName != null
//             ? TextButton(
//                 onPressed: onTap ?? Get.back,
//                 child: Text(
//                   actionName,
//                   style: Styles.white16,
//                 ),
//               )
//             : null,
//         backgroundColor: backgroundColor,
//         margin: Dimens.edgeInsets10,
//         borderRadius: Dimens.ten + Dimens.five,
//         snackStyle: SnackStyle.FLOATING,
//       );
//     },
//   );
// }
}
