import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/common/booking_details/booking_detail_controller.dart';
import 'package:northshore_nanny_flutter/app/res/constants/constants.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_app_bar.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_booking_children_tile.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_booking_detail.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_booking_receipt_tile.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_bookng_service_tile.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_tracker_tile.dart';

class BookingDetailView extends StatelessWidget {
  const BookingDetailView({super.key});

  @override
  Widget build(BuildContext context) => GetBuilder(
        init: BookingDetailController(),
        builder: (controller) => Scaffold(
          appBar: CustomAppbarWidget(
            title: TranslationKeys.bookingDetails.tr,
          ),
          body: Padding(
            padding: Dimens.edgeInsets16,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomBookingDetailView(
                    bookingHeader: 'Booking details',
                    bookingDetailsList: [
                      'Chicago, Naperville',
                      '4 hours',
                      'January 03, 2024',
                      '01:00 PM to 05:00 PM',
                    ],
                  ),
                  Dimens.boxHeight16,
                  CustomBookingServiceTile(
                    serviceHeader: 'Service Type',
                    serviceDetailsList: [
                      Services.homeWorkHelp.serviceName,
                      Services.driving.serviceName,
                    ],
                  ),
                  Dimens.boxHeight16,
                  CustomBookingChildrenTile(
                    childrenHeader: 'Children Profile',
                    childrenDetailsList: const [
                      'Alexander',
                      'Oliver',
                    ],
                    isExpand: controller.isExpandChildren,
                    expansionCallback: (panelIndex, isExpand) {
                      controller.isExpandChildren = isExpand;
                      controller.update();
                    },
                  ),
                  Dimens.boxHeight16,
                  const CustomTrackerTile(
                    image: Assets.iconsImage,
                    svgPath: Assets.iconsChatWhite,
                    name: 'Chiristina Wang',
                    rating: '4.5 ',
                    reviews: '(21 reviews)',
                    description:
                        'Dedicated nanny providing loving Care and guidance to littleness. Experienced in nurturing children\'s development and ensuring a safe, happy environment.',
                    servicesList: [
                      'Distance 3 miles',
                      'Age: 40',
                      'Experience 10 yrs'
                    ],
                  ),
                  Dimens.boxHeight16,
                  CustomBookingReceiptTile(
                    receiptHeader: 'Receipt',
                    receiptDetailsList: const [
                      'Housekeeping',
                      'Driving',
                      '2 children',
                      'Total Time: 4 Hours',
                    ],
                    totalPriceReceived: controller.totalPrice,
                    receiptPricesList: controller.receiptPriceList,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
