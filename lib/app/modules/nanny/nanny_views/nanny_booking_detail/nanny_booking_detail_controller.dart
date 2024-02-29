import 'dart:async';

import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/navigators/routes_management.dart';

import '../../../../res/constants/assets.dart';
import '../../../../utils/enums.dart';
import '../../../../utils/utility.dart';

class NannyBookingDetailController extends GetxController {
  late NannyBookingDetailStatus nannyBookingDetailStatus;

  bool isExpandChildren = false;

  initBooking() {
    if (nannyBookingDetailStatus == NannyBookingDetailStatus.endJob) {
      Timer(
        const Duration(seconds: 3),
        () {
          Utility.showDialog(
            title: 'Congratulations! ',
            assetName: Assets.imagesStar,
            subTitle: 'Please rate your experience with this family!',
            buttonTitleText: 'Rate Now',
            assetWidth: Dimens.ninety,
            assetHeight: Dimens.hundredTen,
            titleMaxLine: 1,
            subTitleMaxLine: 1,
            onTapButton: () {
              Utility.closeDialog();
              RouteManagement.goToRatingReviewScreen();
            },
            isImage: true,
            showCrossSvg: true,
          );
        },
      );
    }
  }

  /// report list
  var reportList = [
    'Unavailable for this day/time',
    'Job is too far away',
    'Other'
  ];

  /// selected index store for report dialog
  int? selectedIndex;
}
