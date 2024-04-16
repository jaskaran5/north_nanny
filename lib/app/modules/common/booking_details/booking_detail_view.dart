import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
import 'package:northshore_nanny_flutter/navigators/app_routes.dart';

import '../../../../navigators/routes_management.dart';
import '../../../res/constants/enums.dart';
import '../../../res/theme/colors.dart';
import '../../../widgets/custom_booking_review.dart';
import '../rating_and_review/rating_and_review_binding.dart';
import '../rating_and_review/rating_and_review_controller.dart';

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
                          BookingDetailStatus.arrived &&
                      controller.bookingDataById?.isJobStarted == true &&
                      controller.bookingDataById?.reviewGivenByMe == null) ...[
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
                              text: controller.bookingDataById?.endTime != null
                                  ? Utility.calculateTotalTimeDifference(
                                      controller.bookingDataById?.startTime,
                                      controller.bookingDataById?.endTime)
                                  : Utility.returnHMS(
                                      second: controller.seconds),
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
                  GetBuilder<BookingDetailController>(
                    id: 'customer_tracking',
                    builder: (trackingController) => trackingController
                                .bookingDataById !=
                            null
                        ? CustomTrackerTile(
                            onTapChat: () {
                              Get.toNamed(Routes.chat,
                                  arguments: trackingController
                                      .bookingDataById?.userDetails?.userId
                                      .toString());
                            },
                            image: trackingController
                                    .bookingDataById?.userDetails?.image
                                    .toString() ??
                                '',
                            svgPath: Assets.iconsChatWhite,
                            name: trackingController
                                    .bookingDataById?.userDetails?.name ??
                                '',
                            rating: trackingController
                                        .bookingDataById?.userDetails?.rating ==
                                    0.0
                                ? '0'
                                : trackingController
                                        .bookingDataById?.userDetails?.rating
                                        .toString() ??
                                    '',
                            reviews: trackingController
                                    .bookingDataById?.userDetails?.reviewCount
                                    .toString() ??
                                '',
                            description: trackingController
                                    .bookingDataById?.userDetails?.aboutMe
                                    .toString() ??
                                '',
                            distance: trackingController
                                    .bookingDataById?.userDetails?.distance
                                    .toString() ??
                                '0',
                            age: trackingController
                                    .bookingDataById?.userDetails?.age ??
                                0,
                            experience: trackingController
                                    .bookingDataById?.userDetails?.experience
                                    ?.split(' ')
                                    .first
                                    .toString() ??
                                '',
                            onTapRatingAndReview: () {
                              Utility.openBottomSheet(CustomReviewBottomSheet(
                                  totalReviews: trackingController
                                          .bookingDataById
                                          ?.userDetails
                                          ?.reviewCount ??
                                      0,
                                  totalReviewsRating: trackingController
                                      .bookingDataById?.userDetails?.rating,
                                  reviewsList: trackingController
                                          .bookingDataById
                                          ?.userDetails
                                          ?.ratingList ??
                                      []));
                            },
                            secondWidget: GestureDetector(
                              onTap: () {
                                debugPrint('Going to Customer Tracking view');
                                RouteManagement.goToCustomerTrackingView();
                              },
                              child: Container(
                                height: Dimens.hundredFourteen,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(Dimens.ten),
                                ),
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(Dimens.ten),
                                  child: IgnorePointer(
                                    child: GoogleMap(
                                      initialCameraPosition: CameraPosition(
                                          target: LatLng(
                                              double.parse(trackingController
                                                      .bookingDataById
                                                      ?.latitude ??
                                                  '0.0'),
                                              double.parse(trackingController
                                                      .bookingDataById
                                                      ?.longitude ??
                                                  '0.0')),
                                          zoom: Dimens.fifteen),
                                      myLocationEnabled: false,
                                      indoorViewEnabled: true,
                                      myLocationButtonEnabled: false,
                                      zoomControlsEnabled: false,
                                      onMapCreated: (googleController) {
                                        trackingController.googleMapController =
                                            googleController;

                                        log('---------------- >>>>>>>>>> map created <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<  ');

                                        trackingController
                                            .update(['customer_tracking']);
                                      },
                                      markers: {
                                        Marker(
                                          markerId: MarkerId(trackingController
                                                  .bookingDataById?.latitude ??
                                              ''),
                                          position: LatLng(
                                            trackingController
                                                        .trackerLocationModel !=
                                                    null
                                                ? double.parse(trackingController
                                                        .trackerLocationModel
                                                        ?.data
                                                        ?.latitude
                                                        .toString() ??
                                                    '0.0')
                                                : double.parse(
                                                    trackingController
                                                            .bookingDataById
                                                            ?.userDetails
                                                            ?.latitude ??
                                                        '0.0'),
                                            trackingController
                                                        .trackerLocationModel !=
                                                    null
                                                ? double.parse(trackingController
                                                        .trackerLocationModel
                                                        ?.data
                                                        ?.longitude ??
                                                    '0.0')
                                                : double.parse(
                                                    trackingController
                                                            .bookingDataById
                                                            ?.userDetails
                                                            ?.longitude ??
                                                        '0.0'),
                                          ),
                                          flat: true,
                                        ),
                                      },
                                      polylines: {
                                        Polyline(
                                          polylineId:
                                              const PolylineId('nannyLine'),
                                          color: AppColors.navyBlue3288DE,
                                          points: [
                                            LatLng(
                                              double.parse(trackingController
                                                      .bookingDataById
                                                      ?.latitude ??
                                                  '0.0'),
                                              double.parse(trackingController
                                                      .bookingDataById
                                                      ?.longitude ??
                                                  '0.0'),
                                            ),
                                            LatLng(
                                              trackingController
                                                          .trackerLocationModel !=
                                                      null
                                                  ? double.parse(trackingController
                                                          .trackerLocationModel
                                                          ?.data
                                                          ?.latitude
                                                          .toString() ??
                                                      '0.0')
                                                  : double.parse(
                                                      trackingController
                                                              .bookingDataById
                                                              ?.userDetails
                                                              ?.latitude ??
                                                          '0.0'),
                                              trackingController
                                                          .trackerLocationModel !=
                                                      null
                                                  ? double.parse(trackingController
                                                          .trackerLocationModel
                                                          ?.data
                                                          ?.longitude ??
                                                      '0.0')
                                                  : double.parse(
                                                      trackingController
                                                              .bookingDataById
                                                              ?.userDetails
                                                              ?.longitude ??
                                                          '0.0'),
                                            ),
                                          ],
                                        ),
                                      },
                                      mapType: MapType.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            showChat: (trackingController
                                            .bookingDataById?.bookingStatus ??
                                        0) >=
                                    6
                                ? false
                                : true,
                          )
                        : const CircularProgressIndicator(),
                  ),
                  Dimens.boxHeight16,
                  CustomBookingReceiptTile(
                    receiptHeader: 'Receipt',
                    totalPriceReceived:
                        controller.bookingDataById?.totalAmount?.toString() ??
                            '0.0',
                    childCount: controller.bookingDataById?.totalChildren ?? 0,
                    servicesList:
                        controller.bookingDataById?.servicesType ?? [],
                    totalTimeHour: controller.bookingDataById?.totalHour,
                    totalTimeHourPrice: controller.bookingDataById?.hourlyPrice,
                    isMinus: controller.bookingDataById?.isUseReferrals == true
                        ? false
                        : true,
                    isReferralBonus:
                        controller.bookingDataById?.isUseReferrals ?? false,
                    netPayBalAmount:
                        controller.bookingDataById?.isUseReferrals == true
                            ? (controller.bookingDataById!.totalAmount ?? 0.0) +
                                5.0
                            : 0.0,
                  ),
                  Dimens.boxHeight16,
                  if ((controller.bookingDetailStatus ==
                              BookingDetailStatus.givenReviewByCustomer ||
                          controller.bookingDetailStatus ==
                              BookingDetailStatus.reviewByOtherUser) &&
                      controller.bookingDataById?.reviewGivenByMe != null) ...[
                    CustomBookingReview(
                      reviewsList: [
                        if (controller.bookingDataById?.reviewGivenByMe != null)
                          controller.bookingDataById?.reviewGivenByMe,
                        if (controller.bookingDataById?.reviewGivenByOther !=
                            null)
                          controller.bookingDataById?.reviewGivenByOther,
                      ],
                    ),
                    Dimens.boxHeight16,
                  ],
                  if (controller.bookingDataById?.reviewGivenByMe == null &&
                          controller.bookingDataById?.bookingStatus == 7 ||
                      controller.bookingDetailStatus ==
                          BookingDetailStatus.reviewByOtherUser) ...[
                    CustomButton(
                      title: 'Rate your Experience',
                      backGroundColor: AppColors.navyBlue,
                      onTap: () {
                        if (!Get.isRegistered<RatingAndReviewController>()) {
                          RatingAndReviewBinding().dependencies();
                        }
                        Get.find<RatingAndReviewController>().storeUserData(
                            name:
                                controller.bookingDataById?.userDetails?.name ??
                                    '',
                            image: controller
                                    .bookingDataById?.userDetails?.image ??
                                '',
                            userReviews: controller.bookingDataById?.userDetails
                                    ?.reviewCount ??
                                0,
                            toUserId: controller
                                    .bookingDataById?.userDetails?.userId ??
                                0,
                            bookedId:
                                controller.bookingDataById?.bookingId ?? 0,
                            userRating: controller
                                    .bookingDataById?.userDetails?.rating ??
                                0.0);

                        RouteManagement.goToRatingReviewScreen();
                      },
                    ),
                  ],

                  /* comment due to complete the job.               if (controller.bookingDetailStatus ==
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
                  */

                  if (controller.bookingDetailStatus ==
                      BookingDetailStatus.disputeRaised) ...[
                    CustomButton(
                      backGroundColor: AppColors.fC3030RedColor,
                      title: 'Dispute Raised',
                      onTap: () {
                        Get.back();
                      },
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      );
}
