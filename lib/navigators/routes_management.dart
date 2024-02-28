import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/common/payment_details/custom_payment_details_view.dart';
import 'package:northshore_nanny_flutter/app/widgets/success_un_success.dart';
import '../app/modules/add_payment_method/add_payment_method.dart';
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
  static void goToOffAllLogIn() {
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

  /// Go to the  create  Profile CUSTOMER Screen
  static void goToCreateCustomerProfile() {
    Get.toNamed<void>(
      Routes.createCustomerProfileView,
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

  /// Go to the Success  Screen
  static void goToCustomPaymentView({
    required var paymentDetails,
    required String appBarTitle,
    required String addNewCardButtonTitle,
    required Color addNewCardButtonBackgroundColor,
    required Function()? onTapDeleteButton,
    String? submitButtonTitle,
    Color? submitButtonBackgroundColor,
    required Function()? onTapAddNewCardButton,
    Function()? onTapSubmitButton,
    required bool showDeleteButton,
    TextStyle? addNewCardButtonStyle,
    TextStyle? submitButtonStyle,
  }) {
    Get.to(
      () => CustomPaymentDetails(
        paymentDetails: paymentDetails,
        appBarTitle: appBarTitle,
        addNewCardButtonTitle: addNewCardButtonTitle,
        addNewCardButtonBackgroundColor: addNewCardButtonBackgroundColor,
        onTapAddNewCardButton: onTapAddNewCardButton,
        submitButtonTitle: submitButtonTitle ?? '',
        submitButtonBackgroundColor: submitButtonBackgroundColor,
        onTapSubmitButton: onTapSubmitButton,
        onTapDeleteButton: onTapDeleteButton,
        showDeleteButton: showDeleteButton,
        addNewCardButtonStyle: addNewCardButtonStyle,
        submitButtonStyle: submitButtonStyle,
      ),
    );
  }

  /// go To add Payment Method View.
  static void goToAddPaymentMethodScreen({
    required bool isComeFromNannyProfile,
    required String buttonText,
    required Function() onTapButton,
  }) {
    Get.to(
      () => AddPaymentMethod(
        isComeFromNannyProfile: isComeFromNannyProfile,
        buttonTitle: buttonText,
        onTapButton: onTapButton,
      ),
    );
  }

  /// Go to Invite A Friend view  Screen
  static void goToInviteAFriendView() {
    Get.toNamed(
      Routes.inviteAFriendView,
    );
  }

  /// Go to nanny booking details  Screen
  static void goToNannyBookingView() {
    Get.toNamed(
      Routes.bookingDetailsView,
    );
  }
}
