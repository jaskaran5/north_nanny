import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/res/constants/enums.dart';
import 'app_routes.dart';

abstract class RouteManagement {
  /// Go to the choose baby Sitter Screen
  static void goChooseBabySitter() {
    Get.offAllNamed<void>(
      Routes.chooseBabySitter,
    );
  }

  /// Go to the SignIn Screen
  static void goToSignUp({required ChooseInterface chooseInterface}) {
    Get.toNamed<void>(
      Routes.signUp,
      arguments: chooseInterface,
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

  /// Go to the  Password success Screen
  static void goToPasswordSuccessView() {
    Get.toNamed<void>(
      Routes.passwordSuccessView,
    );
  }

  /// Go to the  create Sitter Profile  Screen
  static void goToCreateSitterProfileView(dynamic selectedInterface) {
    Get.toNamed<void>(
      Routes.createSitterProfileView,
      arguments: selectedInterface,
    );
  }

  /// Go to the Home Screen
  static void goToOffAllHome(dynamic selectedInterface) {
    Get.offAllNamed<void>(
      Routes.home,
      arguments: selectedInterface,
    );
  }
}
