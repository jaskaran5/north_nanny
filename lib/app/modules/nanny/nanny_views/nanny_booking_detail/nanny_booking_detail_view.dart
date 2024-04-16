import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:northshore_nanny_flutter/app/modules/common/chatting/chat/chat_view.dart';
import 'package:northshore_nanny_flutter/app/modules/nanny/nanny_views/nanny_booking_detail/nanny_booking_detail_controller.dart';
import 'package:northshore_nanny_flutter/app/modules/nanny/nanny_views/nanny_home/nanny_home_binding.dart';
import 'package:northshore_nanny_flutter/app/modules/nanny/nanny_views/nanny_home/nanny_home_controller.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/utils/utility.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_app_bar.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_booking_children_tile.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_booking_receipt_tile.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_booking_review.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_booking_track_location.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_bookng_service_tile.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_bottom_sheet.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_button.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_cache_network_image.dart';
import 'package:northshore_nanny_flutter/app/widgets/review_custom_bottom_sheet.dart';
import 'package:northshore_nanny_flutter/navigators/routes_management.dart';

import '../../../../res/constants/enums.dart';
import '../../../../widgets/custom_booking_detail.dart';
import '../../../../widgets/custom_text_field.dart';
import '../../../common/rating_and_review/rating_and_review_binding.dart';
import '../../../common/rating_and_review/rating_and_review_controller.dart';

class NannyBookingDetailView extends StatelessWidget {
  const NannyBookingDetailView({super.key});

  @override
  Widget build(BuildContext context) =>
      GetBuilder<NannyBookingDetailController>(
        builder: (controller) => Scaffold(
          appBar: CustomAppbarWidget(
            title: TranslationKeys.bookingDetails.tr,
            onBackPress: () {
              if (!Get.isRegistered<NannyHomeController>()) {
                NannyHomeBinding().dependencies();
              }
              Get.find<NannyHomeController>().getHomeData();
              Get.back();
            },
          ),
          body: Padding(
            padding: Dimens.edgeInsets16,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (controller.nannyBookingDetailStatus ==
                          NannyBookingDetailStatus.endJob ||
                      controller.nannyBookingDetailStatus ==
                              NannyBookingDetailStatus.waitingForApproval &&
                          controller.bookingDetailsModel?.data?.isJobStarted ==
                              true) ...[
                    GetBuilder<NannyBookingDetailController>(
                      id: 'timerView',
                      builder: (timerController) => Container(
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
                              text: timerController
                                          .bookingDetailsModel?.data?.endTime !=
                                      null
                                  ? Utility.calculateTotalTimeDifference(
                                      timerController
                                          .bookingDetailsModel?.data?.startTime,
                                      timerController
                                          .bookingDetailsModel?.data?.endTime)
                                  : Utility.returnHMS(
                                      second: timerController.seconds),
                              style: AppStyles.ubNavyBlue34W700,
                              maxLines: 1,
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Dimens.boxHeight14,
                  ],
                  CustomBookingDetailView(
                    bookingHeader: 'Job Details',
                    time: controller.bookingDetailsModel?.data?.openingDate !=
                            null
                        ? '${Utility.formatTimeTo12Hour(controller.bookingDetailsModel?.data?.openingDate.toString())} to ${Utility.formatTimeTo12Hour(controller.bookingDetailsModel?.data?.closingDate.toString())}'
                        : '',
                    location: controller.bookingDetailsModel?.data?.location
                            .toString() ??
                        '',
                    date: controller.bookingDetailsModel?.data?.bookingDate,
                    hours: controller.bookingDetailsModel?.data?.totalHour
                            .toString() ??
                        '',
                  ),
                  Dimens.boxHeight14,
                  CustomBookingServiceTile(
                    serviceHeader: 'Service Type',
                    serviceDetailsList:
                        controller.bookingDetailsModel?.data?.servicesType ??
                            [],
                  ),
                  Dimens.boxHeight14,
                  CustomBookingChildrenTile(
                    childrenHeader: 'Children Profile',
                    childrenDetailsList:
                        controller.bookingDetailsModel?.data?.children ?? [],
                    expansionCallback: (index) {
                      controller.bookingDetailsModel?.data?.children?[index]
                          .isExpand = !(controller.bookingDetailsModel?.data
                              ?.children?[index].isExpand ??
                          false);
                      controller.update();
                    },
                  ),
                  Dimens.boxHeight14,
                  GetBuilder<NannyBookingDetailController>(
                    id: 'tracking-view',
                    builder: (trackController) => CustomBookingTrackLocation(
                      firstWidget: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                height: Dimens.seventy,
                                width: Dimens.seventy,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(Dimens.ten),
                                ),
                                child: trackController.bookingDetailsModel?.data
                                            ?.userDetails?.image?.isEmpty ==
                                        true
                                    ? Image.asset(
                                        Assets.imagesUserAvatar,
                                        fit: BoxFit.contain,
                                        height: Dimens.seventy,
                                        width: Dimens.seventy,
                                      )
                                    : CustomCacheNetworkImage(
                                        img: trackController.bookingDetailsModel
                                                ?.data?.userDetails?.image ??
                                            '',
                                        size: Dimens.seventy,
                                        imageRadius: Dimens.ten),
                              ),
                              Dimens.boxWidth10,
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: Dimens.oneHundredFifty,
                                    child: AppText(
                                      text: trackController.bookingDetailsModel
                                          ?.data?.userDetails?.name
                                          .toString(),
                                      style: AppStyles.ubWhite14700,
                                      maxLines: 2,
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  Dimens.boxHeight4,
                                  GestureDetector(
                                    onTap: () {
                                      Utility.openBottomSheet(
                                        CustomReviewBottomSheet(
                                          totalReviews: trackController
                                                  .bookingDetailsModel
                                                  ?.data
                                                  ?.userDetails
                                                  ?.reviewCount ??
                                              0,
                                          totalReviewsRating: trackController
                                                  .bookingDetailsModel
                                                  ?.data
                                                  ?.userDetails
                                                  ?.rating ??
                                              0.0,
                                          reviewsList: trackController
                                                  .bookingDetailsModel
                                                  ?.data
                                                  ?.userReviewList ??
                                              [],
                                        ),
                                      );
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SvgPicture.asset(
                                          Assets.iconsStar,
                                          height: Dimens.twelve,
                                          width: Dimens.twelve,
                                        ),
                                        Dimens.boxWidth2,
                                        AppText(
                                          text: trackController
                                                      .bookingDetailsModel
                                                      ?.data
                                                      ?.userDetails
                                                      ?.rating ==
                                                  0.0
                                              ? '0'
                                              : trackController
                                                  .bookingDetailsModel
                                                  ?.data
                                                  ?.userDetails
                                                  ?.rating
                                                  .toString(),
                                          style: AppStyles.ubWhite12W500,
                                          maxLines: 1,
                                          textAlign: TextAlign.left,
                                        ),
                                        Dimens.boxWidth2,
                                        AppText(
                                          text:
                                              '(${trackController.bookingDetailsModel?.data?.userDetails?.reviewCount} ${TranslationKeys.reviews.tr})',
                                          style: AppStyles.ubWhite12W400,
                                          maxLines: 1,
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          if (trackController.nannyBookingDetailStatus ==
                                  NannyBookingDetailStatus.onMyWay ||
                              trackController.nannyBookingDetailStatus ==
                                  NannyBookingDetailStatus.arrived ||
                              trackController.nannyBookingDetailStatus ==
                                  NannyBookingDetailStatus.endJob)
                            GestureDetector(
                                onTap: () {
                                  Get.to(const ChatView(),
                                      arguments: trackController
                                          .bookingDetailsModel
                                          ?.data
                                          ?.userDetails
                                          ?.userId
                                          .toString());
                                },
                                child: SvgPicture.asset(Assets.iconsChatWhite)),
                        ],
                        //
                      ),
                      showTrackLocation:
                          trackController.nannyBookingDetailStatus ==
                                  NannyBookingDetailStatus.givenReviewByNanny
                              ? false
                              : trackController.bookingDetailsModel != null
                                  ? true
                                  : false,
                      latitude: trackController.currentPosition?.latitude ??
                          double.parse(trackController
                                  .bookingDetailsModel?.data?.latitude ??
                              '0.0'),
                      longitude: trackController.currentPosition?.longitude ??
                          double.parse(trackController
                                  .bookingDetailsModel?.data?.longitude ??
                              '0.0'),
                      polyline: {
                        Polyline(
                          polylineId: const PolylineId('line'),
                          color: AppColors.navyBlue3288DE,
                          points: [
                            LatLng(
                                trackController.currentPosition?.latitude ??
                                    double.parse(trackController
                                            .bookingDetailsModel
                                            ?.data
                                            ?.latitude ??
                                        '0.0'),
                                trackController.currentPosition?.longitude ??
                                    double.parse(trackController
                                            .bookingDetailsModel
                                            ?.data
                                            ?.longitude ??
                                        '0.0')),
                            LatLng(
                                double.parse(trackController.bookingDetailsModel
                                        ?.data?.userDetails?.latitude ??
                                    '0.0'),
                                double.parse(trackController.bookingDetailsModel
                                        ?.data?.userDetails?.longitude ??
                                    '0.0')),
                          ],
                        ),
                      },
                      markers: {
                        Marker(
                          markerId: MarkerId(trackController.bookingDetailsModel
                                  ?.data?.userDetails?.latitude
                                  .toString() ??
                              ''),
                          flat: true,
                          position: LatLng(
                            double.parse(trackController.bookingDetailsModel
                                    ?.data?.userDetails?.latitude ??
                                '0.0'),
                            double.parse(trackController.bookingDetailsModel
                                    ?.data?.userDetails?.longitude ??
                                '0.0'),
                          ),
                        )
                      },
                      onMapCreated: trackController.onMapCreated,
                    ),
                  ),
                  Dimens.boxHeight14,
                  CustomBookingReceiptTile(
                    receiptHeader: 'Receipt',
                    totalPriceReceived: controller
                            .bookingDetailsModel?.data?.totalAmount
                            ?.toString() ??
                        '0.0',
                    childCount:
                        controller.bookingDetailsModel?.data?.totalChildren ??
                            0,
                    servicesList:
                        controller.bookingDetailsModel?.data?.servicesType ??
                            [],
                    totalTimeHour:
                        controller.bookingDetailsModel?.data?.totalHour ?? 0,
                    totalTimeHourPrice:
                        controller.bookingDetailsModel?.data?.hourlyPrice ??
                            0.0,
                  ),
                  Dimens.boxHeight14,
                  if (controller.nannyBookingDetailStatus ==
                          NannyBookingDetailStatus.givenReviewByNanny &&
                      controller.bookingDetailsModel?.data?.reviewGivenByMe !=
                          null) ...[
                    CustomBookingReview(
                      reviewsList: [
                        if (controller
                                .bookingDetailsModel?.data?.reviewGivenByMe !=
                            null)
                          controller.bookingDetailsModel?.data?.reviewGivenByMe,
                        if (controller.bookingDetailsModel?.data
                                ?.reviewGivenByOther !=
                            null)
                          controller
                              .bookingDetailsModel?.data?.reviewGivenByOther,
                      ],
                    ),
                  ],
                  if (controller.nannyBookingDetailStatus ==
                      NannyBookingDetailStatus.present) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomButton(
                          width: Dimens.oneHundredSixty,
                          backGroundColor:
                              AppColors.fC3030RedColor.withOpacity(.15),
                          title: TranslationKeys.reject.tr,
                          textColor: AppColors.fC3030RedColor,
                          onTap: () {
                            controller.selectedIndex = null;
                            controller.otherRejectionTextEditingController
                                .clear();
                            controller.rejectionReason = '';

                            /// rejection dialog.
                            Get.dialog(
                              GetBuilder(
                                  init: NannyBookingDetailController(),
                                  builder: (bookingController) {
                                    return Padding(
                                      padding: Dimens.edgeInsetsL16R16,
                                      child: Center(
                                        child: Material(
                                          borderRadius: BorderRadius.circular(
                                              Dimens.twenty),
                                          color: AppColors.primaryColor,
                                          child: Container(
                                            padding: Dimens.edgeInsetsB16,
                                            decoration: BoxDecoration(
                                              color: AppColors.primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimens.twenty),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Dimens.boxHeight4,
                                                Padding(
                                                  padding: Dimens
                                                      .edgeInsetsL12T6R12B6,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      AppText(
                                                        text:
                                                            'Reject booking request',
                                                        style: AppStyles
                                                            .ubBlack16W700,
                                                        maxLines: 1,
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          Get.back();
                                                        },
                                                        child: SvgPicture.asset(
                                                          Assets
                                                              .iconsRemoveBottomSheet,
                                                          height:
                                                              Dimens.twentyFour,
                                                          width:
                                                              Dimens.twentyFour,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Divider(
                                                  color:
                                                      AppColors.lightNavyBlue,
                                                  height: Dimens.one,
                                                ),
                                                Dimens.boxHeight4,
                                                Padding(
                                                  padding: Dimens.edgeInsets10,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      ...List.generate(
                                                        bookingController
                                                            .reportList.length,
                                                        (index) =>
                                                            GestureDetector(
                                                          onTap: () {
                                                            bookingController
                                                                    .selectedIndex =
                                                                index;
                                                            if (index != 2) {
                                                              controller
                                                                      .rejectionReason =
                                                                  controller
                                                                      .reportList[
                                                                          index]
                                                                      .toString();
                                                            } else {
                                                              controller
                                                                      .rejectionReason =
                                                                  controller
                                                                      .otherRejectionTextEditingController
                                                                      .text;
                                                            }
                                                            bookingController
                                                                .update();
                                                          },
                                                          child: Padding(
                                                            padding: Dimens
                                                                .edgeInsets6,
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                SvgPicture
                                                                    .asset(
                                                                  bookingController
                                                                              .selectedIndex ==
                                                                          index
                                                                      ? Assets
                                                                          .iconsCircleTick
                                                                      : Assets
                                                                          .iconsUncheckCircle,
                                                                ),
                                                                Dimens
                                                                    .boxWidth8,
                                                                AppText(
                                                                  text: bookingController
                                                                      .reportList[
                                                                          index]
                                                                      .toString(),
                                                                  maxLines: 1,
                                                                  style: bookingController
                                                                              .selectedIndex ==
                                                                          index
                                                                      ? AppStyles
                                                                          .ubNavyBlue14W600
                                                                      : AppStyles
                                                                          .ubBlack14W500,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      if (bookingController
                                                              .selectedIndex ==
                                                          2) ...[
                                                        Dimens.boxHeight8,
                                                        TextField(
                                                          controller: controller
                                                              .otherRejectionTextEditingController,
                                                          maxLines: 4,
                                                          decoration:
                                                              customFieldDeco(
                                                            hintText:
                                                                'Enter reason (option)',
                                                            hintStyle: AppStyles
                                                                .ubHintColor12W500,
                                                          ),
                                                        ),
                                                        Dimens.boxHeight8,
                                                      ],
                                                      Dimens.boxHeight8,
                                                      CustomButton(
                                                        title: TranslationKeys
                                                            .submit.tr,
                                                        backGroundColor:
                                                            AppColors.navyBlue,
                                                        onTap: () {
                                                          /// report api for report the booking
                                                          controller.acceptOrRejectBookingDetail(
                                                              bookingId: controller
                                                                      .bookingDetailsModel
                                                                      ?.data
                                                                      ?.bookingId ??
                                                                  0,
                                                              bookingStatus: 3,
                                                              rejectionStatus:
                                                                  controller.selectedIndex !=
                                                                          null
                                                                      ? (controller.selectedIndex ??
                                                                              0) +
                                                                          1
                                                                      : 0,
                                                              rejectionReason:
                                                                  controller
                                                                      .rejectionReason);
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            );
                          },
                        ),
                        CustomButton(
                          width: Dimens.oneHundredSixty,
                          backGroundColor: AppColors.navyBlue,
                          title: TranslationKeys.accept.tr,
                          onTap: () {
                            /// used this condition to add bank account. if not bank account added by nanny.
                            if (controller.bookingDetailsModel?.data
                                    ?.isBankAddedByNanny ==
                                true) {
                              /// accept booking
                              controller.acceptOrRejectBookingDetail(
                                bookingId: controller
                                        .bookingDetailsModel?.data?.bookingId ??
                                    0,
                                bookingStatus: 2,
                              );
                              controller.nannyBookingDetailStatus =
                                  NannyBookingDetailStatus.onMyWay;
                              controller.update();
                            } else {
                              /// used to go add bank account .
                              RouteManagement.goToAddBankView(
                                  isComeFromBooking: true);
                            }
                          },
                        ),
                      ],
                    )
                  ],
                  if ((controller.nannyBookingDetailStatus ==
                              NannyBookingDetailStatus.onMyWay ||
                          controller.nannyBookingDetailStatus ==
                              NannyBookingDetailStatus.arrived ||
                          controller.nannyBookingDetailStatus ==
                              NannyBookingDetailStatus.endJob) &&
                      controller.nannyBookingDetailStatus !=
                          NannyBookingDetailStatus.approvedByAdmin) ...[
                    Opacity(
                      opacity:
                          controller.bookingDetailsModel?.data?.isJobStarted ==
                                  true
                              ? 1.0
                              : 0.5,
                      child: CustomButton(
                        title: controller.nannyBookingDetailStatus ==
                                NannyBookingDetailStatus.onMyWay
                            ? 'On my way'
                            : controller.nannyBookingDetailStatus ==
                                    NannyBookingDetailStatus.arrived
                                ? 'Arrived'
                                : 'End Job ',
                        backGroundColor: controller.nannyBookingDetailStatus ==
                                NannyBookingDetailStatus.onMyWay
                            ? AppColors.f7D901YellowColor
                            : controller.nannyBookingDetailStatus ==
                                    NannyBookingDetailStatus.arrived
                                ? AppColors.greenColor05B016
                                : AppColors.fC3030RedColor,
                        titleStyle: controller.nannyBookingDetailStatus ==
                                NannyBookingDetailStatus.onMyWay
                            ? AppStyles.ubBlack15W600
                            : null,
                        onTap: () {
                          if (controller.nannyBookingDetailStatus ==
                                  NannyBookingDetailStatus.onMyWay &&
                              controller.bookingDetailsModel?.data
                                      ?.isJobStarted ==
                                  true) {
                            // controller.nannyBookingDetailStatus =
                            //     NannyBookingDetailStatus.arrived;
                            controller.updateStatus(
                                bookingId: controller
                                        .bookingDetailsModel?.data?.bookingId ??
                                    0,
                                bookingStatus: 4);
                          } else if (controller.nannyBookingDetailStatus ==
                              NannyBookingDetailStatus.arrived) {
                            // controller.nannyBookingDetailStatus =
                            //     NannyBookingDetailStatus.endJob;
                            controller.updateStatus(
                              bookingId: controller
                                      .bookingDetailsModel?.data?.bookingId ??
                                  0,
                              bookingStatus: 5,
                              startTime: DateTime.now(),
                            );
                          } else if (controller.nannyBookingDetailStatus ==
                              NannyBookingDetailStatus.endJob) {
                            controller.updateStatus(
                                bookingId: controller
                                        .bookingDetailsModel?.data?.bookingId ??
                                    0,
                                bookingStatus: 6,
                                endTime: DateTime.now());
                            // controller.nannyBookingDetailStatus =
                            //     NannyBookingDetailStatus.waitingForApproval;
                          }
                          controller.update();
                        },
                      ),
                    ),
                  ],
                  if (controller.nannyBookingDetailStatus ==
                      NannyBookingDetailStatus.waitingForApproval) ...[
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: Dimens.edgeInsets10,
                        height: Dimens.fiftyThree,
                        width: Get.width,
                        decoration: BoxDecoration(
                          color: AppColors.lightNavyBlue,
                          borderRadius: BorderRadius.circular(Dimens.twelve),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Dimens.boxWidth8,
                            AppText(
                              text: 'Waiting for approval...',
                              maxLines: 1,
                              style: AppStyles.ubNavyBlue15W600,
                            ),
                            GestureDetector(
                              onTap: () {
                                Utility.openBottomSheet(
                                  const CustomBottomSheet(
                                      heading: 'Waiting for approval',
                                      description:
                                          'We are waiting for the family to confirm that the job was completed. If they don\'t confirm in the next ten minutes, the job will be automatically marked as complete, and you will have the option to rate and write a review.'),
                                );
                              },
                              child: SvgPicture.asset(
                                Assets.iconsOutlineInfoCircle,
                                height: Dimens.twenty,
                                width: Dimens.twenty,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  Dimens.boxHeight16,
                  if (controller.nannyBookingDetailStatus ==
                      NannyBookingDetailStatus.disputeRaised) ...[
                    CustomButton(
                      backGroundColor: AppColors.fC3030RedColor,
                      title: 'Dispute Raised',
                      onTap: () {
                        Get.back();
                      },
                    ),
                  ],
                  if (controller.bookingDetailsModel?.data?.reviewGivenByMe ==
                          null &&
                      controller.nannyBookingDetailStatus ==
                          NannyBookingDetailStatus.approvedByAdmin) ...[
                    CustomButton(
                      backGroundColor: AppColors.navyBlue,
                      title: 'Rate Your Experience',
                      onTap: () {
                        if (!Get.isRegistered<RatingAndReviewController>()) {
                          RatingAndReviewBinding().dependencies();
                        }
                        Get.find<RatingAndReviewController>().storeUserData(
                            name: controller.bookingDetailsModel?.data
                                    ?.userDetails?.name ??
                                '',
                            image: controller.bookingDetailsModel?.data
                                    ?.userDetails?.image ??
                                '',
                            userReviews: controller.bookingDetailsModel?.data
                                    ?.userDetails?.reviewCount ??
                                0,
                            toUserId: controller.bookingDetailsModel?.data
                                    ?.userDetails?.userId ??
                                0,
                            bookedId: controller
                                    .bookingDetailsModel?.data?.bookingId ??
                                0,
                            userRating: controller.bookingDetailsModel?.data
                                    ?.userDetails?.rating ??
                                0.0);
                        RouteManagement.goToRatingReviewScreen();
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
