import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';
import 'package:northshore_nanny_flutter/app/res/constants/enums.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';

import '../../data/api/api_response.dart';
import '../../data/api/errors/api_error.dart';
import '../../data/api/interface_controller/api_interface_controller.dart';
import '../../utils/app_utils.dart';
import '../../utils/loading_dialog.dart';
import '../../widgets/custom_inkwell_widget.dart';
import '../theme/styles.dart';

extension BottomTabName on BottomTabs {
  String get bottomTabName {
    switch (this) {
      case BottomTabs.home:
        return TranslationKeys.home;
      case BottomTabs.messages:
        return TranslationKeys.messages;

      case BottomTabs.notifications:
        return '';
      case BottomTabs.calender:
        return TranslationKeys.calender;
      case BottomTabs.settings:
        return TranslationKeys.settings;
    }
  }

  String get bottomSvg {
    switch (this) {
      case BottomTabs.home:
        return Assets.iconsHomeOutline;
      case BottomTabs.messages:
        return Assets.iconsMessage;
      case BottomTabs.notifications:
        return Assets.iconsNotificationOutline;
      case BottomTabs.calender:
        return Assets.iconsCalendar;
      case BottomTabs.settings:
        return Assets.iconsSettingOutline;
    }
  }

  String get selectedBottomSvg {
    switch (this) {
      case BottomTabs.home:
        return Assets.iconsHomeFilled;
      case BottomTabs.messages:
        return Assets.iconsMessageFilled;
      case BottomTabs.notifications:
        return Assets.iconsNotificationOutline;
      case BottomTabs.calender:
        return Assets.iconsCalendarFilled;
      case BottomTabs.settings:
        return Assets.iconsSettingFilled;
    }
  }
}

extension ServiceName on Services {
  String get serviceName {
    switch (this) {
      case Services.housekeeping:
        return TranslationKeys.houseKeeping;
      case Services.driving:
        return TranslationKeys.driving;
      case Services.petCare:
        return TranslationKeys.petCare;
      case Services.homeWorkHelp:
        return TranslationKeys.homeWorkHelp;
      case Services.runningErrands:
        return TranslationKeys.runningErrands;
      case Services.funActivityOutHouse:
        return TranslationKeys.funActivityOutHouse;
    }
  }

  String get servicesSvg {
    switch (this) {
      case Services.housekeeping:
        return Assets.iconsHouseKeeping;
      case Services.driving:
        return Assets.iconsStaringWheel;
      case Services.petCare:
        return Assets.iconsPetThumb;
      case Services.homeWorkHelp:
        return Assets.iconsHomeWork;
      case Services.runningErrands:
        return Assets.iconsShoppingCart;
      case Services.funActivityOutHouse:
        return Assets.iconsFunActivity;
    }
  }

  String get serviceDescription {
    switch (this) {
      case Services.housekeeping:
        return 'This service includes, but is not limited to the following household chores: dishes, laundry, floors, countertops, and general tidying up.';
      case Services.driving:
        return 'This service includes school, camp, club, and sport pick-ups/drop-offs. (Only nannies who have proven that they have a driver’s license will be eligible for this service).';
      case Services.petCare:
        return 'The pet-care service includes feeding, walking, etc.';
      case Services.homeWorkHelp:
        return 'This service includes nannies assisting your child with completing their daily homework assignments.';
      case Services.runningErrands:
        return 'This service includes running everyday errands such as grocery shopping, etc.';
      case Services.funActivityOutHouse:
        return 'This service includes taking your children on fun activities such as: the trampoline park, pool/ beach, park, etc. This is included at no extra cost.';
    }
  }
}

extension GenderName on GenderConstant {
  String get genderName {
    switch (this) {
      case GenderConstant.male:
        return TranslationKeys.male;
      case GenderConstant.female:
        return TranslationKeys.female;
    }
  }
}

extension ChildrenListName on HourlyChildrenRateList {
  String get childrenName {
    switch (this) {
      case HourlyChildrenRateList.forPlusChildren:
        return '4+ ${TranslationKeys.children.tr}';
      case HourlyChildrenRateList.forChildren:
        return '4 ${TranslationKeys.children.tr}';
      case HourlyChildrenRateList.threeChildren:
        return '3 ${TranslationKeys.children.tr}';
      case HourlyChildrenRateList.twoChildren:
        return '2 ${TranslationKeys.children.tr}';
      case HourlyChildrenRateList.oneChild:
        return 'One ${TranslationKeys.child.tr}';
    }
  }

  int get ratePricePerChildren {
    switch (this) {
      case HourlyChildrenRateList.forPlusChildren:
        return 27;
      case HourlyChildrenRateList.forChildren:
        return 26;
      case HourlyChildrenRateList.threeChildren:
        return 24;
      case HourlyChildrenRateList.twoChildren:
        return 23;
      case HourlyChildrenRateList.oneChild:
        return 22;
    }
  }
}

extension BookingDeatilsSvg on BookingDetails {
  String get bookingDetailSvg {
    switch (this) {
      case BookingDetails.location:
        return Assets.iconsBookingLocation;
      case BookingDetails.hours:
        return Assets.iconsBookingTimer;
      case BookingDetails.date:
        return Assets.iconsCalendar;
      case BookingDetails.time:
        return Assets.iconsClock;
    }
  }
}

extension NullString on String? {
  bool get isNullOrEmpty => this == null || this!.trim().isEmpty;
}

extension FutureExt<T> on Future<Response<T>?> {
  void futureValue(
    Function(T value) response, {
    Function(String? error)? onError,
    required VoidCallback retryFunction,
    bool showLoading = true,
  }) {
    final interface = Get.find<ApiInterfaceController>();
    interface.error = null;

    if (showLoading) LoadingDialog.showLoadingDialog();

    timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        LoadingDialog.closeLoadingDialog();

        Utils.showSnackbar('Connection Timeout');

        _retry(interface, retryFunction);

        throw const ApiError(
          type: ErrorType.connectTimeout,
          error: "ConnectionTimeOut",
        );
      },
    ).then((value) {
      LoadingDialog.closeLoadingDialog();

      if (value?.body != null) {
        final result = ApiResponse.getResponse<T>(value!);
        if (result != null) {
          response(result);
        }
      }

      interface.update();
    }).catchError((e) {
      LoadingDialog.closeLoadingDialog();

      if (e == null) return;

      final String errorMessage = e is ApiError ? e.message : e.toString();

      if (e is ApiError) {
        if ((e.type == ErrorType.connectTimeout ||
            e.type == ErrorType.noConnection)) {
          interface.error = e;

          _retry(interface, retryFunction);
        } else {
          Utils.showDialog(
            errorMessage,
            onTap: errorMessage != "unauthorize"
                ? null
                : () {
                    // Storage.clearStorage();
                    // Get.offAllNamed(
                    //   "/home",
                    //   //change the ROUTE to the LOGIN or SPLASH screen so that the
                    //   //user can login again on UnauthorizeError error
                    // );
                  },
          );
        }
      }

      if (onError != null) {
        LoadingDialog.closeLoadingDialog();
        onError(errorMessage);
      }

      printError(info: 'catchError: error: $e\nerrorMessage: $errorMessage');
    });
  }

  void _retry(
    ApiInterfaceController interface,
    VoidCallback retryFunction,
  ) {
    interface.retry = retryFunction;
    interface.update();
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
        content: Text(
          message ?? "Something went wrong",
          textAlign: TextAlign.center,
          maxLines: 6,
          // style: AppTextStyle.semiBoldStyle.copyWith(
          //   color: AppColors.mineShaft,
          //   fontSize: Dimens.fontSize16,
          // ),
        ),
        confirm: Align(
          alignment: Alignment.centerRight,
          child: CustomInkwellWidget.text(
              onTap: () {
                Get.back();

                onTap?.call();
              },
              title: "oK",
              textStyle: AppStyles.fffUrban15w600

              // AppTextStyle.buttonTextStyle.copyWith(
              //   fontSize: Dimens.fontSize18,
              // ),
              ),
        ),
      );
}
