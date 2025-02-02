import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/common/payment_details/custom_payment_details_view.dart';
import 'package:northshore_nanny_flutter/app/widgets/success_un_success.dart';
import '../app/modules/add_payment_method/add_payment_method.dart';
import '../app/modules/nanny/nanny_views/waiting_approval/waiting_approval_view.dart';
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

  /// go To service screen from create sitter profile.
  static void goToSelectServicesView() {
    Get.toNamed<void>(
      Routes.selectServicesView,
    );
  }

  /// go To Pricing screen from select services .
  static void goToPricingView() {
    Get.toNamed<void>(
      Routes.pricingView,
    );
  }

  /// go To BankDetail screen from pricing services .
  static void goToBankDetailView() {
    Get.toNamed<void>(
      Routes.bankDetailsView,
    );
  }

  /// go To waitingApproval screen from select services .
  static void goToOffAllWaitingApprovalView() {
    Get.offAll(
      () => const WaitingApprovalView(),
    );
    Future.delayed(
      const Duration(seconds: 5),
      () => RouteManagement.goToOffAllLogIn(),
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
  static void goToChangePasswordScreen() {
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
  static Future<bool> goToCustomPaymentView({
    required bool isComeFromSendTip,
    required bool isComeFromConfirmBooking,
    required bool isCardAdded,
    Function()? onTapSubmit,
  }) async {
    var value = await Get.to(
      () => CustomPaymentDetails(
        isComeFromConfirmBooking: isComeFromConfirmBooking,
        isComeFromSendTip: isComeFromSendTip,
        isCardAdded: isCardAdded,
        onTapSubmit: onTapSubmit,
      ),
    );
    return value ?? false;
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
      Routes.nannyBookingDetailsView,
    );
  }

  /// Go to GoogleMap  Screen
  static void goToGoogleMapScreen(isFromEdit) {
    Get.toNamed(Routes.googleMapView, arguments: isFromEdit);
  }

  /// Go to Choose child  Screen
  static void goToChooseChildProfileView() {
    Get.toNamed(
      Routes.chooseChildProfileView,
    );
  }

  /// Go to Choose child  Screen
  static void goToAddChildProfileView() {
    Get.toNamed(
      Routes.createChildProfileView,
    );
  }

  /// Go to Edit Nanny Profile  View
  static void goToEditNannyProfileView() {
    Get.toNamed(
      Routes.editNannyProfile,
    );
  }

  /// Go to Edit Nanny Services  View
  static void goToEditNannyServicesView() {
    Get.toNamed(
      Routes.editNannyServices,
    );
  }

  /// Go to GET NANNY PROFILE  View
  static void goToGetNannyProfileView({argument}) {
    Get.toNamed(Routes.getNannyProfile, arguments: argument ?? 0);
  }

  // /// Go to RATING REVIEW VIEW
  // static void goToRatingReviewView({argument}) {
  //   Get.toNamed(Routes.ratingReviewView, arguments: argument ?? 0);
  // }

  /// go to customer booking details view.
  static void goToCustomerBookingDetailView() {
    Get.toNamed(Routes.bookingDetailsView);
  }

  /// go to Notification  view.
  static void goToNotificationView() {
    Get.toNamed(Routes.notificationView);
  }

  /// go to Nanny Delete or Update   view from setting.
  static void goToUpdateBankDetailView() {
    Get.toNamed(Routes.nannyUpdateBankView);
  }

  /// go to Notification  view.
  static void goToAddBankView({required bool isComeFromBooking}) {
    Get.toNamed(Routes.addBankView, arguments: isComeFromBooking);
  }

  /// go to Nanny Tracking   view.
  static void goToNannyTrackingView() {
    Get.toNamed(
      Routes.nannyTrackingView,
    );
  }

  /// go to Customer Tracking   view.
  static void goToCustomerTrackingView() {
    Get.toNamed(
      Routes.customerTrackingView,
    );
  }
}
