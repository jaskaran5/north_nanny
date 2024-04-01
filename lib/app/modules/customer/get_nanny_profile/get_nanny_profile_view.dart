import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/customer/get_nanny_profile/get_nanny_profile_controller.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';
import 'package:northshore_nanny_flutter/app/res/constants/enums.dart';
import 'package:northshore_nanny_flutter/app/res/constants/extensions.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/utils/utility.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_about_section.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_app_bar.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_bottom_sheet.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_button.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_nanny_profile_view.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_shimmer_skeleton.dart';
import 'package:northshore_nanny_flutter/app/widgets/houry_rate_view.dart';
import 'package:northshore_nanny_flutter/app/widgets/review_custom_bottom_sheet.dart';
import 'package:table_calendar/table_calendar.dart';

class GetNannyProfileView extends StatelessWidget {
  const GetNannyProfileView({
    super.key,
  });

  @override
  Widget build(BuildContext context) => GetBuilder(
        init: GetNannyProfileController(),
        builder: (controller) => SafeArea(
          top: false,
          child: Scaffold(
            appBar: CustomAppbarWidget(
              title: "Nanny Profile",
              centerTitle: true,
              actions: [
                // if (!isComeFromSetting)
                GestureDetector(
                  onTap: () {
                    log("on tap on favourite");
                    controller.updateIsFavourite();
                  },
                  child: Padding(
                    padding: Dimens.edgeInsetsL16R16,
                    child: controller.getNannyData != null
                        ? SvgPicture.asset(controller.isFavorite.value
                            ? Assets.iconsHeartFilled
                            : Assets.iconsHeartOutline)
                        : null,
                  ),
                ),
              ],
            ),
            backgroundColor: AppColors.profileBackgroundColor,
            body: SkeletonWidget(
              isLoading: controller.isDataLoading.value,
              child: SingleChildScrollView(
                child: Padding(
                  padding: Dimens.edgeInsetsB16,
                  child: Column(
                    children: [
                      CustomNannyProfileView(
                        distance: double.tryParse(
                                controller.getNannyData?.distance.toString() ??
                                    "0.0")
                            ?.truncate()
                            .toString(),
                        imageUrl: controller.getNannyData?.image,
                        nannyName: controller.getNannyData?.name.toString(),
                        totalRating: controller.getNannyData?.rating,
                        totalReview: controller.getNannyData?.reviewCount,
                        nannyAge: controller.getNannyData?.age.toString(),
                        nannyExperience: controller.getNannyData?.experience
                                ?.split(' ')
                                .first ??
                            '',
                        onTapRating: () {
                          Utility.openBottomSheet(CustomReviewBottomSheet(
                              totalReviews:
                                  controller.profileData.data?.reviewCount ?? 0,
                              totalReviewsRating:
                                  controller.profileData.data?.rating ?? 0.0,
                              reviewsList:
                                  controller.profileData.data?.ratingList ??
                                      []));
                        },
                      ),
                      Dimens.boxHeight20,
                      Container(
                        margin: Dimens.edgeInsetsL16R16,
                        height: Dimens.fifty,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(Dimens.ten),
                        ),
                        child: Row(
                          children: List.generate(
                            controller.profileTabList.length,
                            (index) => GestureDetector(
                              onTap: () {
                                controller.selectedIndex = index;
                                if (index == 2) {
                                  // controller.getAvailabilityList();
                                }
                                controller.update();
                              },
                              child: Container(
                                height: Dimens.forty,
                                width: Dimens.hundredEight,
                                // padding: Dimens.edgeInsets8,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: controller.selectedIndex == index
                                      ? AppColors.navyBlue
                                      : Colors.transparent,
                                  borderRadius:
                                      BorderRadius.circular(Dimens.eight),
                                ),
                                child: AppText(
                                  text: controller.profileTabList[index].tr,
                                  style: controller.selectedIndex == index
                                      ? AppStyles.ubWhite14700
                                      : AppStyles.ubGrey14W600,
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      /** ON TAP ON TABBAR--------->>>>>>>>>>>>>>> */
                      Dimens.boxHeight20,
                      if (controller.selectedIndex == 0) ...[
                        /** INDEX-------000000---------- ABOUT--------*/
                        CustomAbout(
                          aboutNanny: controller.getNannyData?.aboutMe ?? '',
                        ),
                        Dimens.boxHeight20,
                        Padding(
                          padding: Dimens.edgeInsetsL16R16,
                          child: HourlyRateView(
                            showShadow: false,
                            borderRadius: Dimens.ten,
                          ),
                        )
                      ],
                      if (controller.selectedIndex == 1) ...[
                        /** INDEX-------11111111---------- SERVICES ---------- */

                        servicesView(
                            servicesList:
                                controller.getNannyData?.services ?? [],
                            rateList: controller.priceList),
                      ],
                      if (controller.selectedIndex == 2) ...[
                        /** INDEX-------222222222---------- AVAILABILITY ------- */
                        availabilityView(controller: controller),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}

///*** SERVICE VIEW WIDGET */
Widget servicesView({
  List<String>? rateList,
  List<String>? servicesList,
}) =>
    Padding(
      padding: Dimens.edgeInsetsL16R16,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          servicesList?.length ?? 0,
          (index) => SizedBox(
            height: Dimens.seventy,
            child: Card(
              color: Colors.white,
              margin: Dimens.edgeInsetsB10,
              shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimens.ten),
                borderSide: const BorderSide(
                  color: AppColors.primaryColor,
                  width: 1.5,
                ),
              ),
              elevation: 0.5,
              shadowColor: AppColors.lightNavyBlue.withOpacity(.8),
              child: Padding(
                padding: Dimens.edgeInsets10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: Dimens.thirtyFive,
                          width: Dimens.thirtyFive,
                          padding: Dimens.edgeInsets10,
                          decoration: BoxDecoration(
                            color: AppColors.lightNavyBlue,
                            borderRadius: BorderRadius.circular(
                              Dimens.eight,
                            ),
                          ),
                          child: SvgPicture.asset(
                            (Services.values
                                    .firstWhereOrNull((element) =>
                                        element.serviceName ==
                                        servicesList?[index].toString())
                                    ?.servicesSvg) ??
                                Services.funActivityOutHouse.servicesSvg,
                          ),
                        ),
                        Dimens.boxWidth10,
                        AppText(
                          text: (Services.values
                                  .firstWhereOrNull((element) =>
                                      element.serviceName ==
                                      servicesList?[index].toString())
                                  ?.serviceName
                                  .tr) ??
                              Services.funActivityOutHouse.serviceName.tr,
                          style: AppStyles.ubBlack14W600,
                          maxLines: 1,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: Dimens.edgeInsets4_0,
                          child: AppText(
                            text: rateList![index].toString(),
                            style: AppStyles.ubNavyBlue16W700,
                            maxLines: 1,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.bottomSheet(
                              CustomBottomSheet(
                                heading: Services.values
                                    .firstWhere((element) =>
                                        element.serviceName ==
                                        servicesList?[index].toString())
                                    .serviceName
                                    .tr,
                                description: Services.values
                                        .firstWhereOrNull((element) =>
                                            element.serviceName ==
                                            servicesList?[index].toString())
                                        ?.serviceDescription
                                        .tr ??
                                    '',
                                headingSvg: Assets.iconsRemoveBottomSheet,
                              ),
                              barrierColor: AppColors.greyColor.withOpacity(.2),
                            );
                          },
                          child: SvgPicture.asset(
                            Assets.iconsInfoCircle,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

///*** AVAILABILITY VIEW WIDGET */

Widget availabilityView({required GetNannyProfileController controller}) =>
    Padding(
      padding: Dimens.edgeInsetsL16R16,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: Dimens.edgeInsets10,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(Dimens.eight),
              boxShadow: [
                BoxShadow(
                  color: AppColors.lightNavyBlue.withOpacity(.8),
                  blurRadius: Dimens.five,
                )
              ],
            ),
            child: TableCalendar(
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
              firstDay: DateTime.now(),
              lastDay: DateTime.utc(
                DateTime.now().year + 100,
              ),
              calendarFormat: CalendarFormat.month,
              headerStyle: HeaderStyle(
                titleTextStyle: AppStyles.ubBlack18W600,
                formatButtonVisible: false,
                titleCentered: true,
                leftChevronIcon: SvgPicture.asset(Assets.iconsLeft),
                rightChevronIcon: SvgPicture.asset(Assets.iconsRight),
              ),
              sixWeekMonthsEnforced: true,
              onDaySelected: (selectedDay, focusedDay) async {
                /// used to update the  values of selected date and focus date.
                controller.updateSelectedDate(
                    date: selectedDay, focusDate: focusedDay);

                /// used to get the data by date.
                controller.getNannyDataByDate(date: selectedDay);
              },
              selectedDayPredicate: (day) => controller.selectedDate == day,
              focusedDay: controller.focusedDay,
              eventLoader: (day) {
                return controller.isElementEqualToData(
                  controller.getNannyData?.avilabilityList ?? [],
                  day.day,
                  day.month,
                )
                    ? [
                        '.',
                      ]
                    : [];
              },
              onPageChanged: (focusedDay) {
                controller.focusedDay = focusedDay;

                /// used to  call api when calender month change.
                controller.getNannyDetails(time: focusedDay);
                controller.update();
              },
            ),
          ),
          Dimens.boxHeight20,
          if (controller.selectedDate != null &&
              controller.isElementEqualToData(
                controller.getNannyData?.avilabilityList ?? [],
                controller.selectedDate?.day ?? 0,
                controller.selectedDate?.month ?? 0,
              ))
            CustomButton(
              title: TranslationKeys.bookSitter.tr,
              backGroundColor: AppColors.navyBlue,
              onTap: () {
                controller.redirectToNannyScheduleView();
              },
            ),
          Dimens.boxHeight5,
        ],
      ),
    );
