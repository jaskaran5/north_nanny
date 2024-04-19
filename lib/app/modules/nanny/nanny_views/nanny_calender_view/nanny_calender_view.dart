import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_cache_network_image.dart';
import 'package:northshore_nanny_flutter/navigators/routes_management.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../res/constants/assets.dart';
import '../../../../res/theme/colors.dart';
import '../../../../res/theme/dimens.dart';
import '../../../../res/theme/styles.dart';
import '../../../../utils/utility.dart';
import '../../../../widgets/app_text.dart';
import '../../../../widgets/custom_date_format_tile_view.dart';
import '../../../../widgets/custom_dot.dart';
import '../../../../widgets/review_custom_bottom_sheet.dart';
import '../nanny_booking_detail/nanny_booking_detail_binding.dart';
import '../nanny_booking_detail/nanny_booking_detail_controller.dart';
import 'nanny_calender_controller.dart';

class NannyCalenderView extends StatelessWidget {
  const NannyCalenderView({super.key});

  @override
  Widget build(BuildContext context) => GetBuilder(
        init: NannyCalenderController(),
        builder: (controller) => SafeArea(
          child: Scaffold(
            body: Padding(
              padding: Dimens.edgeInsets16,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TableCalendar(
                      sixWeekMonthsEnforced: true,
                      startingDayOfWeek: StartingDayOfWeek.monday,
                      daysOfWeekStyle: DaysOfWeekStyle(
                        weekdayStyle: AppStyles.ubHintColor13W500,
                        weekendStyle: AppStyles.ubHintColor13W500,
                      ),
                      calendarStyle: CalendarStyle(
                        defaultTextStyle: AppStyles.ubBlack15W600,
                        weekendTextStyle: AppStyles.ubBlack15W600,
                        outsideTextStyle: AppStyles.ubHintColor15W500,
                        isTodayHighlighted:
                            controller.selectedDay != null ? false : true,
                        todayDecoration: const BoxDecoration(
                          color: AppColors.navyBlue,
                          shape: BoxShape.circle,
                        ),
                        todayTextStyle: AppStyles.ubWhite15700,
                        selectedTextStyle: AppStyles.ubWhite15700,
                        selectedDecoration: const BoxDecoration(
                          color: AppColors.navyBlue,
                          shape: BoxShape.circle,
                        ),
                        markersMaxCount: 1,
                        markerSize: Dimens.four,
                        markersAutoAligned: true,
                        markerMargin: Dimens.edgeInsets4,
                        markersAlignment: Alignment.center,
                      ),
                      firstDay: DateTime(
                        DateTime.now().year,
                      ),
                      lastDay: DateTime.utc(
                        DateTime.now().year + 100,
                      ),
                      headerStyle: HeaderStyle(
                        titleTextStyle: AppStyles.ubBlack18W600,
                        formatButtonVisible: false,
                        titleCentered: true,
                        leftChevronIcon: SvgPicture.asset(Assets.iconsLeft),
                        rightChevronIcon: SvgPicture.asset(Assets.iconsRight),
                      ),
                      onDaySelected: (selectedDay, focusedDay) {
                        controller.selectedDay = selectedDay;
                        controller.focusDate = focusedDay;
                        controller.getSelectedDateBookingDetail(
                            selectedDate: selectedDay);
                        controller.update();
                      },
                      selectedDayPredicate: (day) =>
                          controller.selectedDay == day,
                      focusedDay: controller.focusDate,
                      onPageChanged: (focusedDay) {
                        controller.focusDate = focusedDay;
                        controller.getAllBookings(time: focusedDay);
                        controller.update();
                      },
                      eventLoader: (day) {
                        return controller.isEvent(
                          daysList: controller.nannyBookingDetails?.data ?? [],
                          day: day.day,
                          month: day.month,
                        )
                            ? [
                                '.',
                              ]
                            : [];
                      },
                    ),
                    Dimens.boxHeight32,
                    controller.nannyBookingDetail?.data != null &&
                            controller.nannyBookingDetail?.data?.isNotEmpty ==
                                true
                        ? Flexible(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount:
                                  controller.nannyBookingDetail?.data?.length ??
                                      0,
                              itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  if (!Get.isRegistered<
                                      NannyBookingDetailController>()) {
                                    NannyBookingDetailBinding().dependencies();
                                  }
                                  var nannyBookingController =
                                      Get.find<NannyBookingDetailController>();

                                  /// used to store the  tye of booking.
                                  nannyBookingController.typeOfBooking(
                                      bookingStatus: controller
                                              .nannyBookingDetail
                                              ?.data?[index]
                                              .bookingStatus ??
                                          0);

                                  /// used to get the booking data
                                  nannyBookingController
                                      .getBookingDetailOfCustomer(
                                          bookingId: controller
                                                  .nannyBookingDetail
                                                  ?.data?[index]
                                                  .bookingId ??
                                              0);

                                  RouteManagement.goToNannyBookingView();
                                },
                                child: Container(
                                  margin: Dimens.edgeInsetsB16,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(Dimens.fourteen),
                                    border: Border.all(
                                      color: AppColors.navyBlue,
                                      width: Dimens.two,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: Dimens.edgeInsets16,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CustomDateFormatTile(
                                              day: Utility.getDay(
                                                  dateTime: controller
                                                      .nannyBookingDetail
                                                      ?.data?[index]
                                                      .openingTime),
                                              dateFormatInMonthYearDayOfWeek:
                                                  Utility.convertDateToMMMMYYYEEE(
                                                      controller
                                                              .nannyBookingDetail
                                                              ?.data?[index]
                                                              .openingTime ??
                                                          DateTime.now()),
                                              timing:
                                                  '${Utility.formatTimeTo12Hour(controller.nannyBookingDetail?.data?[index].openingTime.toString())} to ${Utility.formatTimeTo12Hour(controller.nannyBookingDetail?.data?[index].closingTime.toString())}',
                                              totalPrice: controller
                                                      .nannyBookingDetail
                                                      ?.data?[index]
                                                      .billAmount
                                                      .toString() ??
                                                  '',
                                            ),
                                            Dimens.boxHeight16,
                                            Divider(
                                              color: AppColors.dividerColor,
                                              height: Dimens.one,
                                            ),
                                            Dimens.boxHeight16,
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                CustomDot(
                                                    size: Dimens.four,
                                                    color:
                                                        AppColors.blackColor),
                                                Dimens.boxWidth4,
                                                Flexible(
                                                  child: AppText(
                                                    text: controller
                                                        .nannyBookingDetail
                                                        ?.data?[index]
                                                        .services
                                                        ?.join(', ')
                                                        .capitalizeFirst,
                                                    style: AppStyles.ubGrey15W500,
                                                    maxLines: 3,
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Dimens.boxHeight16,
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                CustomDot(
                                                    size: Dimens.four,
                                                    color:
                                                        AppColors.blackColor),
                                                Dimens.boxWidth4,
                                                AppText(
                                                  text:
                                                      '${controller.nannyBookingDetail?.data?[index].childCount == 1 ? '${controller.nannyBookingDetail?.data?[index].childCount.toString()} ${TranslationKeys.child.tr}' : '${controller.nannyBookingDetail?.data?[index].childCount.toString()} ${TranslationKeys.children.tr}'} ',
                                                  style: AppStyles.ubGrey15W500,
                                                  maxLines: 1,
                                                  textAlign: TextAlign.start,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: Dimens.edgeInsets10,
                                        width: Get.width,
                                        decoration: BoxDecoration(
                                          color: AppColors.navyBlue,
                                          border: Border.all(
                                            color: AppColors.navyBlue,
                                            width: Dimens.two,
                                          ),
                                          borderRadius: BorderRadius.only(
                                            bottomLeft:
                                                Radius.circular(Dimens.ten),
                                            bottomRight:
                                                Radius.circular(Dimens.ten),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              height: Dimens.fifty,
                                              width: Dimens.fifty,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  Dimens.ten,
                                                ),
                                              ),
                                              child: controller
                                                          .nannyBookingDetail
                                                          ?.data?[index]
                                                          .image
                                                          ?.isEmpty ==
                                                      true
                                                  ? Image.asset(
                                                      Assets.imagesUserAvatar,
                                                      fit: BoxFit.contain,
                                                    )
                                                  : CustomCacheNetworkImage(
                                                      img: controller
                                                              .nannyBookingDetail
                                                              ?.data?[index]
                                                              .image ??
                                                          '',
                                                      size: Dimens.fifty,
                                                      imageRadius: Dimens.ten),
                                            ),
                                            Dimens.boxWidth16,
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                SizedBox(
                                                  width: Dimens.twoHundred,
                                                  child: AppText(
                                                    text: controller
                                                        .nannyBookingDetail
                                                        ?.data?[index]
                                                        .name
                                                        .toString(),
                                                    style:
                                                        AppStyles.ubWhite14700,
                                                    maxLines: 2,
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                                Dimens.boxHeight4,
                                                GestureDetector(
                                                  onTap: () {
                                                    Utility.openBottomSheet(
                                                      CustomReviewBottomSheet(
                                                        totalReviews: controller
                                                                .nannyBookingDetail
                                                                ?.data?[index]
                                                                .reviewCount ??
                                                            0,
                                                        totalReviewsRating:
                                                            controller
                                                                    .nannyBookingDetail
                                                                    ?.data?[
                                                                        index]
                                                                    .rating ??
                                                                0.0,
                                                        reviewsList: controller
                                                                .nannyBookingDetail
                                                                ?.data?[index]
                                                                .ratingList ??
                                                            [],
                                                      ),
                                                    );
                                                  },
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      SvgPicture.asset(
                                                          Assets.iconsStar),
                                                      Dimens.boxWidth4,
                                                      RichText(
                                                        text: TextSpan(
                                                          text: controller
                                                                      .nannyBookingDetail
                                                                      ?.data?[
                                                                          index]
                                                                      .rating ==
                                                                  0.0
                                                              ? '0 '
                                                              : '${controller.nannyBookingDetail?.data?[index].rating.toString()} ',
                                                          style: AppStyles
                                                              .ubLightNavy12W500,
                                                          children: [
                                                            TextSpan(
                                                              text:
                                                                  '(${controller.nannyBookingDetail?.data?[index].reviewCount.toString()} ${TranslationKeys.reviews.tr})',
                                                              style: AppStyles
                                                                  .ubLightNavy12W400,
                                                            ),
                                                          ],
                                                        ),
                                                        maxLines: 1,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Dimens.boxHeight50,
                              AppText(
                                text: TranslationKeys.noBookings.tr,
                                style: AppStyles.ubNavyBlue20W600,
                                maxLines: 1,
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
