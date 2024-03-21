import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/nanny/nanny_views/nanny_booking_detail/nanny_booking_detail_binding.dart';
import 'package:northshore_nanny_flutter/app/modules/nanny/nanny_views/nanny_booking_detail/nanny_booking_detail_controller.dart';
import 'package:northshore_nanny_flutter/app/modules/nanny/nanny_views/nanny_home/nanny_home_controller.dart';
import 'package:northshore_nanny_flutter/app/modules/nanny/nanny_views/nanny_home/widgets/custom_nanny_home_tile.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/utils/utility.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_app_bar.dart';
import 'package:northshore_nanny_flutter/app/widgets/review_custom_bottom_sheet.dart';
import 'package:northshore_nanny_flutter/navigators/routes_management.dart';
import '../../../../res/theme/styles.dart';
import '../../../../widgets/app_text.dart';

class NannyHomeView extends StatelessWidget {
  const NannyHomeView({super.key});

  @override
  Widget build(BuildContext context) => GetBuilder<NannyHomeController>(
        init: NannyHomeController(),
        builder: (controller) => Scaffold(
          appBar: CustomAppbarWidget(
            leadingWidth: Dimens.zero,
            titleWidget: Container(
              height: 100,
              padding: Dimens.edgeInsets16,
              margin: Dimens.edgeInsetsT10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    // width: Dimens.hundred,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          text: controller.nannyHomeData.data?.address,
                          style: AppStyles.ubLocationColor14W400,
                          maxLines: 1,
                        ),
                        Dimens.boxHeight2,
                        AppText(
                          text:
                              '${Utility.getGreetingMessage()},${controller.nannyHomeData.data?.name.toString().capitalizeFirst} ',
                          style: AppStyles.pdBlack18W600,
                          maxLines: 1,
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: Dimens.twentyTwo,
                        width: Dimens.fortyOne,
                        child: Switch(
                          activeTrackColor: AppColors.navyBlue,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          inactiveTrackColor: AppColors.trackColorDCDFEB,
                          trackOutlineWidth:
                              MaterialStatePropertyAll(Dimens.two),
                          thumbColor: const MaterialStatePropertyAll(
                              AppColors.primaryColor),
                          value: controller.isSwitchOn,
                          onChanged: (value) {
                            controller.isSwitchOn = value;
                            controller.setAvailability(isAvailable: value);
                            controller.update();
                          },
                          activeColor: AppColors.navyBlue,
                        ),
                      ),
                      Dimens.boxHeight2,
                      AppText(
                        text: controller.isSwitchOn
                            ? TranslationKeys.available.tr
                            : TranslationKeys.unAvailable.tr,
                        style: controller.isSwitchOn
                            ? AppStyles.ubNavyBlue10W400
                            : AppStyles.ubGrey10W400,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          body: Padding(
            padding: Dimens.edgeInsets16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: Dimens.edgeInsets10,
                  height: Dimens.seventyEight,
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: AppColors.navyBlue,
                    borderRadius: BorderRadius.circular(Dimens.fourteen),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.lightNavyBlue.withOpacity(.5),
                        blurRadius: Dimens.five,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: Dimens.sixty,
                        width: Dimens.sixty,
                        padding: Dimens.edgeInsets10,
                        decoration: BoxDecoration(
                          color: AppColors.trackerBackgroundColor,
                          borderRadius: BorderRadius.circular(Dimens.ten),
                        ),
                        child: SvgPicture.asset(Assets.iconsDollarCircle),
                      ),
                      Dimens.boxWidth12,
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            text: TranslationKeys.totalEarning.tr,
                            style: AppStyles.ubBBD7F4lightNavyBlue12W400,
                            maxLines: 1,
                          ),
                          Dimens.boxHeight4,
                          AppText(
                            text:
                                '\$${controller.nannyHomeData.data?.totalRevenue ?? ''}',
                            style: AppStyles.ubColorFFF24W700,
                            maxLines: 1,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Dimens.boxHeight14,
                AppText(
                  text: TranslationKeys.bookingRequests.tr,
                  maxLines: 1,
                  textAlign: TextAlign.left,
                  style: AppStyles.ubBlack16W600,
                ),
                Dimens.boxHeight14,
                controller.nannyHomeData.data?.bookingRequest?.isNotEmpty ==
                        true
                    ? Expanded(
                        child: ListView(
                          children: List.generate(
                            controller.nannyHomeData.data?.bookingRequest
                                    ?.length ??
                                0,
                            (index) => GestureDetector(
                              onTap: () {
                                if (!Get.isRegistered<
                                    NannyBookingDetailController>()) {
                                  NannyBookingDetailBinding().dependencies();
                                }
                                var nannyBookingDetailsController =
                                    Get.find<NannyBookingDetailController>();
                                nannyBookingDetailsController
                                    .getBookingDetailOfCustomer(
                                        bookingId: controller
                                                .nannyHomeData
                                                .data
                                                ?.bookingRequest?[index]
                                                .bookingId ??
                                            0);

                                nannyBookingDetailsController.typeOfBooking(
                                    bookingStatus: controller
                                            .nannyHomeData
                                            .data
                                            ?.bookingRequest?[index]
                                            .bookingStatus ??
                                        0);
                                RouteManagement.goToNannyBookingView();
                              },
                              child: CustomNannyHomeTile(
                                day: Utility.getDay(
                                    dateTime: controller.nannyHomeData.data
                                        ?.bookingRequest?[index].openingDate),
                                dateFormatInMonthYearDayOfWeek:
                                    Utility.convertDateToMMMMYYYEEE(controller
                                            .nannyHomeData
                                            .data
                                            ?.bookingRequest?[index]
                                            .openingDate ??
                                        DateTime.now()),
                                timing:
                                    '${Utility.formatTimeTo12Hour(controller.nannyHomeData.data?.bookingRequest?[index].openingDate.toString() ?? '')} to ${Utility.formatTimeTo12Hour(controller.nannyHomeData.data?.bookingRequest?[index].closingDate.toString())}',
                                totalPrice: controller.nannyHomeData.data
                                        ?.bookingRequest?[index].price
                                        .toString() ??
                                    '0',
                                image: controller.nannyHomeData.data
                                        ?.bookingRequest?[index].image ??
                                    '',
                                name: controller.nannyHomeData.data
                                        ?.bookingRequest?[index].name ??
                                    '',
                                rating: controller.nannyHomeData.data
                                        ?.bookingRequest?[index].rating
                                        .toString() ??
                                    '',
                                reviews: controller.nannyHomeData.data
                                        ?.bookingRequest?[index].reviewCount
                                        .toString() ??
                                    '',
                                onTapRating: () {
                                  Utility.openBottomSheet(
                                    CustomReviewBottomSheet(
                                      totalReviews: controller
                                              .nannyHomeData
                                              .data
                                              ?.bookingRequest?[index]
                                              .reviewCount ??
                                          0,
                                      totalReviewsRating: controller
                                              .nannyHomeData
                                              .data
                                              ?.bookingRequest?[index]
                                              .rating ??
                                          0.0,
                                      reviewsList: controller
                                              .nannyHomeData
                                              .data
                                              ?.bookingRequest?[index]
                                              .userReviewList ??
                                          [],
                                    ),
                                  );
                                },
                                noOfKids: controller
                                        .nannyHomeData
                                        .data
                                        ?.bookingRequest?[index]
                                        .numberOfChildren ??
                                    0,
                                distance: controller.nannyHomeData.data
                                        ?.bookingRequest?[index].distance ??
                                    0,
                              ),
                            ),
                          ),
                        ),
                      )
                    : Expanded(
                        child: Center(
                            child: Image.asset(
                          Assets.imagesNoDataPng,
                          height: Dimens.twoHundred,
                          width: Dimens.twoHundred,
                        )),
                      ),
              ],
            ),
          ),
        ),
      );
}
