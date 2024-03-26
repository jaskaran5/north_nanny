import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/common/notification/notification_controller.dart';
import 'package:northshore_nanny_flutter/app/modules/nanny/nanny_views/nanny_booking_detail/nanny_booking_detail_binding.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_app_bar.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_notification_tile.dart';

import '../../../../navigators/routes_management.dart';
import '../../../data/storage/storage.dart';
import '../../../res/constants/enums.dart';
import '../../../res/constants/string_contants.dart';
import '../../../res/theme/dimens.dart';
import '../../nanny/nanny_views/nanny_booking_detail/nanny_booking_detail_controller.dart';
import '../booking_details/booking_detail_binding.dart';
import '../booking_details/booking_detail_controller.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) => GetBuilder<NotificationController>(
        init: NotificationController(),
        builder: (controller) => Scaffold(
          appBar: CustomAppbarWidget(
            addBackButton: false,
            leadingWidth: Dimens.zero,
            centerTitle: false,
            title: TranslationKeys.notifications.tr,
            titleAlignment: TextAlign.start,
          ),
          body: Padding(
            padding: Dimens.edgeInsets16,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  4,
                  (index) => GestureDetector(
                    onTap: () {
                      var loginType =
                          Storage.getValue(StringConstants.loginType);
                      if (loginType == StringConstants.customer) {
                        if (!Get.isRegistered<BookingDetailController>()) {
                          BookingDetailBinding().dependencies();
                        }
                        var controller = Get.find<BookingDetailController>();
                        controller.getBookingDataById(bookingId: 0);
                        RouteManagement.goToCustomerBookingDetailView();
                      } else if (loginType == StringConstants.nanny) {
                        if (!Get.isRegistered<NannyBookingDetailController>()) {
                          NannyBookingDetailBinding().dependencies();
                        }
                        var controller =
                            Get.find<NannyBookingDetailController>();
                        if (index == 0) {
                          controller.nannyBookingDetailStatus =
                              NannyBookingDetailStatus.present;
                        } else if (index == 1) {
                          controller.nannyBookingDetailStatus =
                              NannyBookingDetailStatus.endJob;
                        } else {
                          controller.nannyBookingDetailStatus =
                              NannyBookingDetailStatus.past;
                        }
                        RouteManagement.goToNannyBookingView();
                      }
                    },
                    child: CustomNotificationTile(
                      notificationHeading: 'Attention!',
                      notificationSubHeading:
                          'The job will automatically be marked as complete in ten minutes. Confirm now that the job was completed.',
                      notificationTime: '1 month ago',
                      isNotificationRead: true,
                      containerColor: index == 0 || index == 1
                          ? AppColors.notificationBackgroundColor
                          : AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
