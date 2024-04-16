import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/common/booking_details/booking_detail_binding.dart';
import 'package:northshore_nanny_flutter/app/modules/common/booking_details/booking_detail_controller.dart';
import 'package:northshore_nanny_flutter/app/modules/common/calender/customer_calender_controller.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/utils/utility.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_cache_network_image.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_date_format_tile_view.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_dot.dart';
import 'package:northshore_nanny_flutter/app/widgets/review_custom_bottom_sheet.dart';
import 'package:northshore_nanny_flutter/navigators/routes_management.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../res/constants/assets.dart';
import '../../../res/theme/colors.dart';
import '../../../res/theme/styles.dart';
import '../../../widgets/app_text.dart';

class CustomerCalenderView extends StatelessWidget {
  const CustomerCalenderView({super.key});

  @override
  Widget build(BuildContext context) => GetBuilder(
        init: CustomerCalenderController(),
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
                        isTodayHighlighted: false,
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
                        2050,
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
                        controller.focusDay = focusedDay;

                        controller.update();

                        controller.getSelectedDateBookingDetail(
                            selectedDate: selectedDay);
                      },
                      selectedDayPredicate: (day) {
                        // debugPrint('selected day:${controller.selectedDay}');
                        // debugPrint('day:$day}');
                        // debugPrint('day>>>>>>>>:${controller.selectedDay==day}');
                        return controller.selectedDay?.day == day.day &&
                            controller.selectedDay?.month == day.month &&
                            controller.selectedDay?.year == day.year;
                      },
                      focusedDay: controller.focusDay,
                      onPageChanged: (focusedDay) {
                        controller.focusDay = focusedDay;

                        /// get events of other month .
                        controller.getCustomerAllBookingDetailsApi(
                            date: focusedDay);
                        controller.update();
                      },
                      eventLoader: (day) {
                        return controller.isEvent(
                          daysList: controller.userBookingDetail?.data ?? [],
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
                    // controller.isEvent(
                    //             daysList:
                    //                 controller.userBookingDetail?.data ?? [],
                    //             day: controller.selectedDay?.day ?? 0,
                    //             month: controller.selectedDay?.month ?? 0) &&
                    controller.singleDateBookingData != null
                        ? GestureDetector(
                            onTap: () {
                              if (!Get.isRegistered<
                                  BookingDetailController>()) {
                                BookingDetailBinding().dependencies();
                              }
                              var customerBookingController =
                                  Get.find<BookingDetailController>();

                              /// used to store the  booking status
                              customerBookingController.typeOfBooking(
                                  bookingStatus: controller
                                      .singleDateBookingData?.bookingStatus);

                              /// used to store the detail of booking
                              customerBookingController.getBookingDataById(
                                  bookingId: controller
                                      .singleDateBookingData?.bookingId);

                              RouteManagement.goToCustomerBookingDetailView();
                            },
                            child: Container(
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: Dimens.edgeInsets16,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomDateFormatTile(
                                          day: controller.selectedDay?.day
                                                  .toString()
                                                  .padLeft(2, '0') ??
                                              '',
                                          dateFormatInMonthYearDayOfWeek:
                                              Utility.convertDateToMMMMYYYEEE(
                                                  controller
                                                          .singleDateBookingData
                                                          ?.openingTime ??
                                                      DateTime.now()),
                                          timing:
                                              '${Utility.formatTimeTo12Hour(controller.singleDateBookingData?.openingTime.toString())} to ${Utility.formatTimeTo12Hour(controller.singleDateBookingData?.closingTime.toString())}',
                                          totalPrice: controller
                                                  .singleDateBookingData
                                                  ?.billAmount
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
                                                color: AppColors.blackColor),
                                            Dimens.boxWidth4,
                                            AppText(
                                              text: controller
                                                  .singleDateBookingData
                                                  ?.services
                                                  ?.join(', ')
                                                  .capitalizeFirst,
                                              style: AppStyles.ubGrey15W500,
                                              maxLines: 1,
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                        Dimens.boxHeight16,
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            CustomDot(
                                                size: Dimens.four,
                                                color: AppColors.blackColor),
                                            Dimens.boxWidth4,
                                            AppText(
                                              text:
                                                  '${controller.singleDateBookingData?.childCount} children',
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
                                        bottomLeft: Radius.circular(Dimens.ten),
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
                                            height: Dimens.hundred,
                                            width: Dimens.eightySix,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimens.ten),
                                            ),
                                            child: CustomCacheNetworkImage(
                                                img: controller
                                                        .singleDateBookingData
                                                        ?.image ??
                                                    '',
                                                size: 100,
                                                imageRadius: 15)

                                            //  Image.asset(
                                            //   Assets.iconsImage,
                                            //   fit: BoxFit.contain,
                                            // ),
                                            ),
                                        Dimens.boxWidth16,
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            AppText(
                                              text: controller
                                                      .singleDateBookingData
                                                      ?.name ??
                                                  '',
                                              style: AppStyles.ubWhite14700,
                                              maxLines: 1,
                                              textAlign: TextAlign.start,
                                            ),
                                            Dimens.boxHeight4,
                                            GestureDetector(
                                              onTap: () {
                                                Utility.openBottomSheet(
                                                  CustomReviewBottomSheet(
                                                    totalReviews: controller
                                                            .singleDateBookingData
                                                            ?.reviewCount ??
                                                        0,
                                                    totalReviewsRating: controller
                                                            .singleDateBookingData
                                                            ?.rating ??
                                                        0,
                                                    reviewsList: controller
                                                            .singleDateBookingData
                                                            ?.ratingList ??
                                                        [],
                                                  ),
                                                );
                                              },
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  SvgPicture.asset(
                                                      Assets.iconsStar),
                                                  Dimens.boxWidth4,
                                                  RichText(
                                                    text: TextSpan(
                                                      text:controller
                                                          .singleDateBookingData
                                                          ?.rating==0.0?'0': controller
                                                          .singleDateBookingData
                                                          ?.rating
                                                          .toString(),
                                                      style: AppStyles
                                                          .ubLightNavy12W500,
                                                      children: [
                                                        TextSpan(
                                                          text:
                                                              ' (${controller.singleDateBookingData?.reviewCount} reviews)',
                                                          style: AppStyles
                                                              .ubLightNavy12W400,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Dimens.boxHeight4,
                                            SizedBox(
                                              width: Dimens.oneHundredEightyTwo,
                                              child: AppText(
                                                text: controller
                                                        .singleDateBookingData
                                                        ?.aboutMe ??
                                                    '',
                                                maxLines: 4,
                                                style:
                                                    AppStyles.ubLightNavy10W400,
                                                textAlign: TextAlign.start,
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
