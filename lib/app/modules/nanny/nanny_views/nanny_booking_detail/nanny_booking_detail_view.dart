import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/nanny/nanny_views/nanny_booking_detail/nanny_booking_detail_controller.dart';
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
import 'package:northshore_nanny_flutter/app/widgets/review_custom_bottom_sheet.dart';

import '../../../../res/constants/enums.dart';
import '../../../../widgets/custom_booking_detail.dart';
import '../../../../widgets/custom_text_field.dart';

class NannyBookingDetailView extends StatelessWidget {
  const NannyBookingDetailView({super.key});

  @override
  Widget build(BuildContext context) =>
      GetBuilder<NannyBookingDetailController>(
        initState: (_) {
          Get.find<NannyBookingDetailController>().initBooking();
        },
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
                  if (controller.nannyBookingDetailStatus ==
                          NannyBookingDetailStatus.endJob ||
                      controller.nannyBookingDetailStatus ==
                          NannyBookingDetailStatus.waitingForApproval) ...[
                    Container(
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
                            text: '04:00:00',
                            style: AppStyles.ubNavyBlue34W700,
                            maxLines: 1,
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                    Dimens.boxHeight14,
                  ],
                  const CustomBookingDetailView(
                    bookingHeader: 'Job Details',
                    bookingDetailsList: [
                      'Chicago, Naperville',
                      '4 hours',
                      'January 03, 2024',
                      '01:00 PM to 05:00 PM',
                    ],
                  ),
                  Dimens.boxHeight14,
                  const CustomBookingServiceTile(
                    serviceHeader: 'Service Type',
                    serviceDetailsList: [
                      'Housekeeping',
                      'Driving',
                    ],
                  ),
                  Dimens.boxHeight14,
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
                  Dimens.boxHeight14,
                  CustomBookingTrackLocation(
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
                                child: Image.asset(
                                  Assets.iconsImage,
                                ),
                              ),
                              Dimens.boxWidth10,
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText(
                                    text: 'Michael Johnson',
                                    style: AppStyles.ubWhite14700,
                                    maxLines: 1,
                                    textAlign: TextAlign.left,
                                  ),
                                  Dimens.boxHeight4,
                                  GestureDetector(
                                    onTap: () {
                                      Utility.openBottomSheet(
                                        const CustomReviewBottomSheet(
                                          totalReviews: 21,
                                          totalReviewsRating: 4.5,
                                          reviewsList: [],
                                          //   'Michael Johnson',
                                          //   'Giorgio Chiellini',
                                          //   'Michael Johnson',
                                          //   'Alex Morgan',
                                          //   'Giorgio Chiellini'
                                          // ],
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
                                          text: '4.5',
                                          style: AppStyles.ubWhite12W500,
                                          maxLines: 1,
                                          textAlign: TextAlign.left,
                                        ),
                                        Dimens.boxWidth2,
                                        AppText(
                                          text: '(21 reviews)',
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
                          if (controller.nannyBookingDetailStatus ==
                                  NannyBookingDetailStatus.onMyWay ||
                              controller.nannyBookingDetailStatus ==
                                  NannyBookingDetailStatus.arrived ||
                              controller.nannyBookingDetailStatus ==
                                  NannyBookingDetailStatus.endJob)
                            SvgPicture.asset(Assets.iconsChatWhite),
                        ],
                      ),
                      showTrackLocation: controller.nannyBookingDetailStatus ==
                              NannyBookingDetailStatus.reviewComplete
                          ? false
                          : true),
                  Dimens.boxHeight14,
                  const CustomBookingReceiptTile(
                    receiptHeader: 'Receipt',
                    receiptDetailsList: [
                      'Housekeeping',
                      'Driving',
                      '2 children',
                      'Total Time: 4 Hours'
                    ],
                    totalPriceReceived: 112,
                    receiptPricesList: [10, 10, 23, 92],
                  ),
                  Dimens.boxHeight14,
                  if (controller.nannyBookingDetailStatus ==
                          NannyBookingDetailStatus.reviewComplete ||
                      controller.nannyBookingDetailStatus ==
                          NannyBookingDetailStatus.past) ...[
                    const CustomBookingReview(
                      reviewsList: ['Christon Wang.F', 'Michal Johnson'],
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
                                                              bookingId: 0,
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
                            /// accept booking
                            controller.acceptOrRejectBookingDetail(
                              bookingId: 0,
                              bookingStatus: 2,
                            );
                            controller.nannyBookingDetailStatus =
                                NannyBookingDetailStatus.onMyWay;
                            controller.update();
                          },
                        ),
                      ],
                    )
                  ],
                  if (controller.nannyBookingDetailStatus ==
                          NannyBookingDetailStatus.onMyWay ||
                      controller.nannyBookingDetailStatus ==
                          NannyBookingDetailStatus.arrived ||
                      controller.nannyBookingDetailStatus ==
                          NannyBookingDetailStatus.endJob) ...[
                    CustomButton(
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
                            NannyBookingDetailStatus.onMyWay) {
                          controller.nannyBookingDetailStatus =
                              NannyBookingDetailStatus.arrived;
                        } else if (controller.nannyBookingDetailStatus ==
                            NannyBookingDetailStatus.arrived) {
                          controller.nannyBookingDetailStatus =
                              NannyBookingDetailStatus.endJob;
                        } else if (controller.nannyBookingDetailStatus ==
                            NannyBookingDetailStatus.endJob) {
                          controller.initBooking();
                          controller.nannyBookingDetailStatus =
                              NannyBookingDetailStatus.waitingForApproval;
                        }
                        controller.update();
                      },
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
                ],
              ),
            ),
          ),
        ),
      );
}
