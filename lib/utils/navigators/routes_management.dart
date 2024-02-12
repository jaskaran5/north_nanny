import 'package:get/get.dart';
import 'app_routes.dart';

abstract class RouteManagement {
  /// Go to the choose baby Sitter Screen
  static void goChooseBabySitter() {
    Get.offAllNamed<void>(
      Routes.chooseBabySitter,
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
  //
  // /// Go to the Home Screen
  // static void goToHome() {
  //   Get.offAllNamed<void>(
  //     Routes.home,
  //   );
  // }
}
