import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/common/booking_details/booking_detail_controller.dart';
import 'package:northshore_nanny_flutter/app/modules/common/rating_review/rating_review_view.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';
import 'package:northshore_nanny_flutter/app/res/constants/enums.dart';
import 'package:northshore_nanny_flutter/app/res/constants/extensions.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/utils/utility.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_app_bar.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_booking_children_tile.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_booking_detail.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_booking_receipt_tile.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_booking_review.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_bookng_service_tile.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_tracker_tile.dart';

import '../../../res/theme/colors.dart';

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
                  GestureDetector(
                    onTap: () {
                      Utility.showAlertDialog(
                        title: 'Confirmation',
                        firstButtonTitle: 'No',
                        secondButtonTitle: 'Yes',
                        onTapFirstButton: () => Get.back(),
                        onTapSecondButton: () {
                          Utility.closeDialog();
                          Utility.showAlertDialog(
                            title: 'Confirmations!',
                            firstButtonTitle: 'Send Tip',
                            onTapSecondButton: () {
                              Get.to(const RatingReviewView());
                            },
                            secondButtonTitle: 'Rate Now',
                            firstButtonBackgroundColor: AppColors.lightNavyBlue,
                            firstButtonStyle: AppStyles.ubNavyBlue14W700,
                            secondButtonBackgroundColor: AppColors.navyBlue,
                            secondButtonStyle: AppStyles.ubWhite14700,
                            imageName: Assets.imagesStar,
                            showContentSvg: true,
                            message:
                                'Your job has been successfully completed. Please rate your experience with this sitter',
                          );
                        },
                        firstButtonBackgroundColor: AppColors.lightNavyBlue,
                        message:
                            'Your nanny has marked this job as complete, please confirm that the job was completed successfully.',
                        secondButtonSvg: Assets.iconsStar,
                        showButtonSvg: true,
                        firstButtonStyle: AppStyles.ubNavyBlue14W700,
                        secondButtonBackgroundColor: AppColors.navyBlue,
                        secondButtonStyle: AppStyles.ubWhite14700,
                      );
                    },
                    child: Container(
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
                  ),
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
                          color: AppColors.greenColor05B016, width: Dimens.two),
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
                  Dimens.boxHeight16,
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
                  Dimens.boxHeight16,
                  const CustomBookingReview(
                      reviewsList: ['Christon Wang.F', 'Michal Johnson']),
                ],
              ),
            ),
          ),
        ),
      );
}
