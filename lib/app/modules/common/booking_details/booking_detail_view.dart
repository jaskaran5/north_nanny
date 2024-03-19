import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/common/booking_details/booking_detail_controller.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/utils/utility.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_app_bar.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_booking_children_tile.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_booking_detail.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_booking_receipt_tile.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_bookng_service_tile.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_button.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_tracker_tile.dart';
import 'package:northshore_nanny_flutter/app/widgets/review_custom_bottom_sheet.dart';

import '../../../../navigators/routes_management.dart';
import '../../../res/constants/enums.dart';
import '../../../res/theme/colors.dart';

class BookingDetailView extends StatelessWidget {
  const BookingDetailView({super.key});

  @override
  Widget build(BuildContext context) => GetBuilder<BookingDetailController>(
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
                  if (controller.bookingDetailStatus ==
                      BookingDetailStatus.arrived) ...[
                    GetBuilder<BookingDetailController>(
                      id: 'customerTimerView',
                      builder: (controller) => Container(
                        padding: Dimens.edgeInsets16,
                        width: Get.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            Dimens.fourteen,
                          ),
                          border: Border.all(
                              color: AppColors.navyBlue, width: Dimens.two),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AppText(
                              text: TranslationKeys.totalTimeLeft.tr,
                              style: AppStyles.ubBlack14W700,
                              textAlign: TextAlign.start,
                              maxLines: 1,
                            ),
                            Dimens.boxHeight10,
                            AppText(
                              text:
                                  Utility.returnHMS(second: controller.seconds),
                              style: AppStyles.ubNavyBlue34W700,
                              maxLines: 1,
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (controller.bookingDetailStatus ==
                        BookingDetailStatus.arrived) ...[
                      Dimens.boxHeight16,
                      Container(
                        padding: Dimens.edgeInsets10,
                        width: Get.width,
                        decoration: BoxDecoration(
                          color: AppColors.greenColor05B016,
                          borderRadius: BorderRadius.circular(
                            Dimens.ten,
                          ),
                          border: Border.all(
                              color: AppColors.greenColor05B016,
                              width: Dimens.two),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(Assets.iconsGreenBoxInfo),
                            Dimens.boxWidth10,
                            AppText(
                              text: 'Nanny has arrived at your location.',
                              style: AppStyles.ubWhite14700,
                              maxLines: 1,
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                    ],
                    Dimens.boxHeight16,
                  ],
                  CustomBookingDetailView(
                    bookingHeader: 'Booking details',
                    time: controller.bookingDataById?.openingDate != null
                        ? '${Utility.formatTimeTo12Hour(controller.bookingDataById?.openingDate.toString())} to ${Utility.formatTimeTo12Hour(controller.bookingDataById?.closingDate.toString())}'
                        : '',
                    location:
                        controller.bookingDataById?.location.toString() ?? '',
                    date: controller.bookingDataById?.bookingDate,
                    hours:
                        controller.bookingDataById?.totalHour.toString() ?? '',
                  ),
                  Dimens.boxHeight16,
                  CustomBookingServiceTile(
                    serviceHeader: 'Service Type',
                    serviceDetailsList:
                        controller.bookingDataById?.servicesType ?? [],
                  ),
                  Dimens.boxHeight16,
                  if (controller.bookingDataById?.children != null &&
                      controller.bookingDataById?.children?.isNotEmpty ==
                          true) ...[
                    ///CHILDREN PROFILE
                    CustomBookingChildrenTile(
                      childrenHeader: 'Children Profile',
                      childrenDetailsList:
                          controller.bookingDataById?.children ?? [],
                      expansionCallback: (index) {
                        controller.bookingDataById?.children?[index].isExpand =
                            !(controller.bookingDataById?.children?[index]
                                    .isExpand ??
                                false);
                        controller.update();
                      },
                    ),
                    Dimens.boxHeight16,
                  ],
                  CustomTrackerTile(
                    image: controller.bookingDataById?.userDetails?.image
                            .toString() ??
                        '',
                    svgPath: Assets.iconsChatWhite,
                    name: controller.bookingDataById?.userDetails?.name ?? '',
                    rating: controller.bookingDataById?.userDetails?.rating
                            .toString() ??
                        '',
                    reviews: controller
                            .bookingDataById?.userDetails?.reviewCount
                            .toString() ??
                        '',
                    description: controller
                            .bookingDataById?.userDetails?.aboutMe
                            .toString() ??
                        '',
                    distance: controller.bookingDataById?.userDetails?.distance
                            .toString() ??
                        '0',
                    age: controller.bookingDataById?.userDetails?.age ?? 0,
                    experience: controller
                            .bookingDataById?.userDetails?.experience
                            ?.split(' ')
                            .first
                            .toString() ??
                        '',
                    onTapRatingAndReview: () {
                      Utility.openBottomSheet(CustomReviewBottomSheet(
                          totalReviews: controller
                                  .bookingDataById?.userDetails?.reviewCount ??
                              0,
                          totalReviewsRating:
                              controller.bookingDataById?.userDetails?.rating,
                          reviewsList: controller
                                  .bookingDataById?.userDetails?.ratingList ??
                              []));
                    },
                  ),
                  Dimens.boxHeight16,
                  CustomBookingReceiptTile(
                    receiptHeader: 'Receipt',
                    totalPriceReceived: controller.bookingDataById?.totalAmount,
                    childCount: controller.bookingDataById?.totalChildren ?? 0,
                    servicesList:
                        controller.bookingDataById?.servicesType ?? [],
                    totalTimeHour: controller.bookingDataById?.totalHour,
                    totalTimeHourPrice: controller.bookingDataById?.hourlyPrice,
                    isReferralBonus:
                        controller.bookingDataById?.isUseReferrals ?? false,
                  ),
                  Dimens.boxHeight16,
                  if (controller.bookingDetailStatus ==
                      BookingDetailStatus.reviewComplete) ...[
                    CustomButton(
                      title: 'Rate your Experience',
                      backGroundColor: AppColors.navyBlue,
                      onTap: () {
                        controller.bookingDetailStatus =
                            BookingDetailStatus.reviewComplete;
                        controller.update();
                        RouteManagement.goToRatingReviewScreen();
                      },
                    ),
                  ],
                  if (controller.bookingDetailStatus ==
                      BookingDetailStatus.complete) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomButton(
                          title: 'Mark as Complete',
                          backGroundColor: AppColors.navyBlue,
                          width: Dimens.oneHundredFifty,
                          onTap: () {
                            /// accept the nanny booking complete request
                            controller.updateStatus(
                                bookingId:
                                    controller.bookingDataById?.bookingId ?? 0,
                                bookingStatus: 7);
                          },
                        ),
                        CustomButton(
                          title: TranslationKeys.no.tr,
                          backGroundColor: AppColors.lightNavyBlue,
                          width: Dimens.oneHundredFifty,
                          onTap: () {
                            /// Reject the nanny booking complete request
                            controller.updateStatus(
                                bookingId:
                                    controller.bookingDataById?.bookingId ?? 0,
                                bookingStatus: 8);
                          },
                          textColor: AppColors.navyBlue,
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      );
}
