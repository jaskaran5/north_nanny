import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/navigators/routes_management.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../res/constants/assets.dart';
import '../../../../res/theme/colors.dart';
import '../../../../res/theme/dimens.dart';
import '../../../../res/theme/styles.dart';
import '../../../../utils/enums.dart';
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
                        controller.update();
                      },
                      selectedDayPredicate: (day) =>
                          controller.selectedDay == day,
                      focusedDay: controller.selectedDay,
                      eventLoader: (day) {
                        return day.day == DateTime.now().day ||
                                day.day == DateTime.now().day - 1
                            ? [
                                '.',
                              ]
                            : [];
                      },
                    ),
                    Dimens.boxHeight32,
                    GestureDetector(
                      onTap: () {
                        if (!Get.isRegistered<NannyBookingDetailController>()) {
                          NannyBookingDetailBinding().dependencies();
                        }
                        Get.find<NannyBookingDetailController>()
                                .nannyBookingDetailStatus =
                            controller.selectedDay.day == DateTime.now().day
                                ? NannyBookingDetailStatus.present
                                : NannyBookingDetailStatus.past;
                        RouteManagement.goToNannyBookingView();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimens.fourteen),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomDateFormatTile(
                                    day: controller.selectedDay.day
                                        .toString()
                                        .padLeft(2, '0'),
                                    dateFormatInMonthYearDayOfWeek:
                                        'Februaery 2024 Friday',
                                    timing: '10:00 AM to 05:00 PM',
                                    totalPrice: '112',
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
                                        text: 'Housekeeping, driving',
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
                                        text: '2 children',
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
                                  bottomRight: Radius.circular(Dimens.ten),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    height: Dimens.fifty,
                                    width: Dimens.fifty,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        Dimens.ten,
                                      ),
                                    ),
                                    child: Image.asset(
                                      Assets.iconsImage,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  Dimens.boxWidth16,
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      AppText(
                                        text: 'Chirstino Wang',
                                        style: AppStyles.ubWhite14700,
                                        maxLines: 1,
                                        textAlign: TextAlign.start,
                                      ),
                                      Dimens.boxHeight4,
                                      GestureDetector(
                                        onTap: () {
                                          Utility.openBottomSheet(
                                            const CustomReviewBottomSheet(
                                              totalReviews: '21',
                                              totalReviewsRating: 4.5,
                                              reviewsList: [
                                                'Michael Johnson',
                                                'Giorgio Chiellini',
                                                'Michael Johnson',
                                                'Alex Morgan',
                                                'Giorgio Chiellini'
                                              ],
                                            ),
                                          );
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SvgPicture.asset(Assets.iconsStar),
                                            Dimens.boxWidth4,
                                            RichText(
                                              text: TextSpan(
                                                text: '4.5 ',
                                                style:
                                                    AppStyles.ubLightNavy12W500,
                                                children: [
                                                  TextSpan(
                                                    text: '(21 review)',
                                                    style: AppStyles
                                                        .ubLightNavy12W400,
                                                  ),
                                                ],
                                              ),
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
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
