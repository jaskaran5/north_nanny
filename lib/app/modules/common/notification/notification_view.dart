import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/common/dashboard_bottom/dashboard_bottom_controller.dart';
import 'package:northshore_nanny_flutter/app/modules/common/notification/notification_controller.dart';
import 'package:northshore_nanny_flutter/app/modules/nanny/nanny_views/nanny_booking_detail/nanny_booking_detail_binding.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/utils/date_helper.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_app_bar.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_notification_tile.dart';
import '../../../../navigators/routes_management.dart';
import '../../../data/storage/storage.dart';
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
        builder: (notificationController) => Scaffold(
          appBar: CustomAppbarWidget(
            addBackButton: false,
            leadingWidth: Dimens.zero,
            centerTitle: false,
            title: TranslationKeys.notifications.tr,
            titleAlignment: TextAlign.start,
          ),
          //
          body: Padding(
            padding: Dimens.edgeInsets16,
            child: SingleChildScrollView(
              child: notificationController.notificationListModel?.data !=
                          null &&
                      notificationController
                              .notificationListModel?.data?.isNotEmpty ==
                          true
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                        notificationController
                                .notificationListModel?.data?.length ??
                            0,
                        (index) => InkWell(
                          splashColor: Colors.transparent,
                          onTap: () {
                            var loginType =
                                Storage.getValue(StringConstants.loginType);

                            /// used to read the notification.
                            notificationController
                                .postNotificationRead(
                                    notificationId: notificationController
                                            .notificationListModel
                                            ?.data?[index]
                                            .notificationId ??
                                        0)
                                .then((value) {
                              Get.find<DashboardBottomController>()
                                  .getNotificationCount();
                            });
                            if (loginType == StringConstants.customer) {
                              if (!Get.isRegistered<
                                  BookingDetailController>()) {
                                BookingDetailBinding().dependencies();
                              }
                              var customerBookingController =
                                  Get.find<BookingDetailController>();

                              /// api used to Store  booking Status type.
                              customerBookingController.typeOfBooking(
                                  bookingStatus: notificationController
                                      .notificationListModel
                                      ?.data?[index]
                                      .bookingStatus);

                              /// api used to get data of booking.
                              customerBookingController.getBookingDataById(
                                bookingId: notificationController
                                    .notificationListModel
                                    ?.data?[index]
                                    .bookingId,
                              );

                              /// going to route
                              RouteManagement.goToCustomerBookingDetailView();
                            } else if (loginType == StringConstants.nanny) {
                              if (!Get.isRegistered<
                                  NannyBookingDetailController>()) {
                                NannyBookingDetailBinding().dependencies();
                              }

                              var nannyBookingController =
                                  Get.find<NannyBookingDetailController>();

                              /// used to store the type of booking
                              nannyBookingController.typeOfBooking(
                                  bookingStatus: notificationController
                                          .notificationListModel
                                          ?.data?[index]
                                          .bookingStatus ??
                                      0);

                              /// api used to get details of booking
                              nannyBookingController.getBookingDetailOfCustomer(
                                bookingId: notificationController
                                        .notificationListModel
                                        ?.data?[index]
                                        .bookingId ??
                                    0,
                              );

                              /// going to route
                              RouteManagement.goToNannyBookingView();
                            }
                            notificationController.getNotificationList();
                          },
                          child: CustomNotificationTile(
                            notificationHeading: notificationController
                                    .notificationListModel
                                    ?.data?[index]
                                    .title ??
                                '',
                            notificationSubHeading: notificationController
                                    .notificationListModel
                                    ?.data?[index]
                                    .description ??
                                '',
                            notificationTime: DateHelper.getDateTimeAgo(
                                notificationController.notificationListModel
                                        ?.data?[index].createdOn
                                        .toString() ??
                                    ''),
                            isNotificationRead: notificationController
                                    .notificationListModel
                                    ?.data?[index]
                                    .isRead ??
                                false,
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: Get.height / 3,
                            ),
                            AppText(
                              text: TranslationKeys.noResultFound.tr,
                              style: AppStyles.ubNavyBlue30W600,
                              textAlign: TextAlign.center,
                            ),
                          ]),
                    ),
            ),
          ),
        ),
      );
}
