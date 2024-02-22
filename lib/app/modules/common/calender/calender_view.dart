import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/common/booking_details/booking_detail_view.dart';
import 'package:northshore_nanny_flutter/app/modules/common/calender/calender_controller.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/utils/utility.dart';
import 'package:northshore_nanny_flutter/app/widgets/review_custom_bottom_sheet.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../res/constants/assets.dart';
import '../../../res/theme/colors.dart';
import '../../../res/theme/styles.dart';
import '../../../widgets/app_text.dart';

class CalenderView extends StatelessWidget {
  const CalenderView({super.key});

  @override
  Widget build(BuildContext context) => GetBuilder(
        init: CalenderController(),
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
                        markerMargin: Dimens.edgeInsets2,
                        markersAlignment: Alignment.center,
                      ),
                      firstDay: DateTime.now(),
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
                        return day.day.isEven
                            ? [
                                '.',
                              ]
                            : [];
                      },
                    ),
                    Dimens.boxHeight32,
                    controller.selectedDay.day.isEven
                        ? GestureDetector(
                            onTap: () {
                              Get.to(const BookingDetailView());
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
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                AppText(
                                                  text: controller
                                                      .selectedDay.day
                                                      .toString()
                                                      .padLeft(2, '0'),
                                                  style:
                                                      AppStyles.ubBlack30W600,
                                                  maxLines: 1,
                                                ),
                                                Dimens.boxWidth16,
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    AppText(
                                                        text:
                                                            'Februaery 2024 Friday',
                                                        style: AppStyles
                                                            .ubGrey12W400,
                                                        maxLines: 1,
                                                        textAlign:
                                                            TextAlign.start),
                                                    Dimens.boxHeight8,
                                                    AppText(
                                                      text:
                                                          '10:00 Am to 05:00 PM',
                                                      style: AppStyles
                                                          .ubBlack14W700,
                                                      maxLines: 1,
                                                      textAlign:
                                                          TextAlign.start,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            AppText(
                                              text: '\$112',
                                              style: AppStyles.ubBlack16W700,
                                              maxLines: 1,
                                            ),
                                          ],
                                        ),
                                        Dimens.boxHeight16,
                                        Divider(
                                          color: AppColors.dividerColor,
                                          height: Dimens.one,
                                        ),
                                        Dimens.boxHeight16,
                                        AppText(
                                          text: '• HouseKeeping, driving',
                                          style: AppStyles.ubGrey15W500,
                                          maxLines: 1,
                                          textAlign: TextAlign.start,
                                        ),
                                        Dimens.boxHeight16,
                                        AppText(
                                          text: '• 2 children',
                                          style: AppStyles.ubGrey15W500,
                                          maxLines: 1,
                                          textAlign: TextAlign.start,
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
                                            borderRadius: BorderRadius.circular(
                                                Dimens.ten),
                                          ),
                                          child: Image.asset(
                                            Assets.iconsImage,
                                            fit: BoxFit.contain,
                                          ),
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
                                                  SvgPicture.asset(
                                                      Assets.iconsStar),
                                                  Dimens.boxWidth4,
                                                  RichText(
                                                    text: TextSpan(
                                                      text: '4.5 ',
                                                      style: AppStyles
                                                          .ubLightNavy12W500,
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
                                            Dimens.boxHeight4,
                                            SizedBox(
                                              width: Dimens.oneHundredFifty,
                                              child: AppText(
                                                text:
                                                    'Dedicated nanny providing loving Care and guidance to littleness. Experienced in nurturing children\'s development and ensuring a safe, happy environment.',
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
