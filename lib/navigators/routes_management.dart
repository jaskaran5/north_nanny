import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/widgets/success_un_success.dart';
import 'app_routes.dart';

abstract class RouteManagement {
  /// Go to the choose baby Sitter Screen
  static void goChooseBabySitter() {
    Get.offAllNamed<void>(
      Routes.chooseBabySitter,
    );
  }

  static void goToSetting() {
    Get.offAllNamed<void>(
      Routes.settingView,
    );
  }

  /// Go to the SignIn Screen
  static void goToSignUp() {
    Get.toNamed<void>(
      Routes.signUp,
    );
  }

  /// Go to the LogIn Screen
  static void goToLogIn() {
    Get.offAllNamed<void>(
      Routes.logIn,
    );
  }

  /// Go to the forgot Password Screen
  static void goToForgotPassword() {
    Get.toNamed<void>(
      Routes.forgotPassword,
    );
  }

  /// Go to the Email Verification  Screen
  static void goToEmailVerification() {
    Get.toNamed<void>(
      Routes.emailVerification,
    );
  }

  /// Go To Create new Password screen
  static void goToCreateNewPassword() {
    Get.offNamed<void>(
      Routes.newPasswordView,
    );
  }

  /// Go to the  create Sitter Profile  Screen
  static void goToCreateNannyProfile() {
    Get.toNamed<void>(
      Routes.createNannyProfile,
    );
  }

  /// Go to the  create  Profile  Screen
  static void goToCreateProfile() {
    Get.toNamed<void>(
      Routes.createProfileView,
    );
  }

  /// Go to the Home Screen
  static void goToOffAllHome() {
    Get.offAllNamed<void>(
      Routes.home,
    );
  }

  /// Go to the Filter Screen
  static void goToFilterView() {
    Get.toNamed<void>(
      Routes.filterView,
    );
  }

  /// Go to the Nanny Profile Screen
  static void goToNannyProfileView() {
    Get.toNamed<void>(
      Routes.nannyProfileView,
    );
  }

  /// Go to the Nanny Profile Screen
  static void goToOffAllDashboard({required bool isFromSetting}) {
    Get.offAllNamed<void>(Routes.dashboard, arguments: isFromSetting);
  }

  /// Go to the Contact us  Screen
  static void goToContactUs() {
    Get.toNamed(
      Routes.contactUs,
    );
  }

  /// Go to the Contact us  Screen
  static void goToFAQ() {
    Get.toNamed(
      Routes.faq,
    );
  }

  /// Go to the Manage Child Profile  Screen
  static void goToManageChildProfileScreen() {
    Get.toNamed(
      Routes.manageChildProfile,
    );
  }

  /// Go to Rating and Review  Screen
  static void goToRatingReviewScreen() {
    Get.toNamed(
      Routes.ratingReview,
    );
  }

  /// Go to Rating and Review  Screen
  static void goToChnagePasswordScreen() {
    Get.toNamed(
      Routes.changePasswordView,
    );
  }

  /// Go to favorite view  Screen
  static void goToFavoriteScreen() {
    Get.toNamed(
      Routes.favoriteView,
    );
  }

  /// Go to My Profile view  Screen
  static void goToMyProfileView() {
    Get.toNamed(
      Routes.myProfileView,
    );
  }

  /// Go to Edit customer Profile view  Screen
  static void goToEditProfileView() {
    Get.toNamed(
      Routes.ediProfileView,
    );
  }

  /// Go to the Success  Screen
  static void goToSuccessView({
    Function()? onTapButton,
    Color? buttonColor,
    TextStyle? headerStyle,
    TextStyle? subTitleStyle,
    required String buttonText,
    required String successSvg,
    required String header,
    required String subHeader,
    required String successImage,
    required int subHeaderMaxLines,
    required int headerMaxLines,
    required bool sendTipText,
  }) {
    Get.off(
      SuccessUnSuccessView(
        buttonText: buttonText,
        successSvg: successSvg,
        header: header,
        subHeader: subHeader,
        buttonColor: buttonColor,
        onTapButton: onTapButton,
        headerStyle: headerStyle,
        subHeaderStyle: subTitleStyle,
        subHeaderMaxLines: subHeaderMaxLines,
        headerMaxLines: headerMaxLines,
        sendTipText: sendTipText,
        successImage: successImage,
      ),
    );
  }
}
