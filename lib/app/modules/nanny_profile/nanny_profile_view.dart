import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/nanny_profile/nanny_profile_controller.dart';
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
import 'package:northshore_nanny_flutter/app/widgets/custom_button.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_nanny_home_svg_tile.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_nanny_profile_view.dart';
import 'package:northshore_nanny_flutter/app/widgets/review_custom_bottom_sheet.dart';
import 'package:northshore_nanny_flutter/navigators/routes_management.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../widgets/custom_bottom_sheet.dart';
import '../../widgets/custom_text_field.dart';

class NannyProfileView extends StatelessWidget {
  const NannyProfileView({
    super.key,
  });

  @override
  Widget build(BuildContext context) => GetBuilder(
        init: NannyProfileController(),
        builder: (controller) => Scaffold(
          appBar: CustomAppbarWidget(
            title: TranslationKeys.myProfile.tr,
            centerTitle: true,
          ),
          backgroundColor: AppColors.profileBackgroundColor,
          body: SingleChildScrollView(
            child: Padding(
              padding: Dimens.edgeInsetsB16,
              child: Column(
                children: [
                  CustomNannyProfileView(
                    imageUrl: controller.profileData.data?.image,
                    nannyName: controller.profileData.data?.name.toString(),
                    totalRating: controller.profileData.data?.rating,
                    totalReview: controller.profileData.data?.reviewCount,
                    nannyAge: controller.profileData.data?.age.toString(),
                    nannyExperience: controller.profileData.data?.experience
                        ?.split(' ')
                        .first,
                    nannyGender: controller.profileData.data?.gender == 1
                        ? TranslationKeys.male.tr
                        : controller.profileData.data?.gender == 2
                            ? TranslationKeys.female.tr
                            : '',
                    onTapRating: () {
                      Utility.openBottomSheet(CustomReviewBottomSheet(
                          totalReviews:
                              controller.profileData.data?.reviewCount ?? 0,
                          totalReviewsRating:
                              controller.profileData.data?.rating ?? 0.0,
                          reviewsList:
                              controller.profileData.data?.ratingList ?? []));
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
                              controller.getAvailabilityList(
                                  dateTime: DateTime.now()
                                      .toUtc()
                                      .toIso8601String()
                                      .toString());
                              controller.selectedDate = null;
                              controller.isRangeSelection = false;
                              controller.rangeStartDate = null;
                              controller.rangeEndDate = null;
                              controller.focusDate = DateTime.now();
                              controller.singleDay?.data = null;
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
                              borderRadius: BorderRadius.circular(Dimens.eight),
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
                  Dimens.boxHeight20,
                  if (controller.selectedIndex == 0) ...[
                    CustomAbout(
                      aboutNanny: controller.profileData.data?.about ?? '',
                    ),
                    Dimens.boxHeight20,
                    Container(
                      padding: Dimens.edgeInsets16,
                      margin: Dimens.edgeInsetsL16R16,
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(
                          Dimens.eight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.lightNavyBlue.withOpacity(.8),
                            blurRadius: Dimens.five,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            text: TranslationKeys.education.tr,
                            maxLines: 1,
                            textAlign: TextAlign.start,
                            style: AppStyles.ubBlack14W700,
                          ),
                          Dimens.boxHeight14,
                          CustomNannySvgTile(
                            assetName: Assets.iconsHouse,
                            heading: TranslationKeys.highSchool.tr,
                            aboutHeading: controller
                                    .profileData.data?.highSchool
                                    .toString() ??
                                '',
                          ),
                          Dimens.boxHeight14,
                          CustomNannySvgTile(
                            assetName: Assets.iconsBuilding,
                            heading: TranslationKeys.college.tr,
                            aboutHeading: controller.profileData.data?.college
                                    .toString() ??
                                '',
                          ),
                          Dimens.boxHeight14,
                        ],
                      ),
                    ),
                    Dimens.boxHeight20,
                    Container(
                      padding: Dimens.edgeInsets16,
                      width: Get.width,
                      margin: Dimens.edgeInsetsL16R16,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(
                          Dimens.eight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.lightNavyBlue.withOpacity(.8),
                            blurRadius: Dimens.five,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomNannySvgTile(
                            assetName: Assets.iconsLocationDot,
                            heading: TranslationKeys.location.tr,
                            aboutHeading:
                                controller.profileData.data?.location ?? '',
                            aboutHeadingWidth: Dimens.twoHundredFifty,
                          ),
                          Dimens.boxHeight14,
                          CustomNannySvgTile(
                            assetName: Assets.iconsPhone,
                            heading: TranslationKeys.phoneNumber.tr,
                            aboutHeading:
                                controller.profileData.data?.mobileNo ?? '',
                          ),
                          Dimens.boxHeight14,
                          if (controller.profileData.data?.isDrivingLicence !=
                              null) ...[
                            CustomNannySvgTile(
                              assetName: Assets.iconsPersonalcard,
                              heading: TranslationKeys.driversLicense.tr,
                              aboutHeading: controller
                                          .profileData.data?.isDrivingLicence ==
                                      true
                                  ? TranslationKeys.yes.capitalizeFirst
                                      .toString()
                                  : TranslationKeys.no.capitalizeFirst
                                      .toString(),
                            ),
                            Dimens.boxHeight14,
                          ],
                        ],
                      ),
                    ),
                    Dimens.boxHeight20,
                    Container(
                      padding: Dimens.edgeInsets16,
                      margin: Dimens.edgeInsetsL16R16,
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(
                          Dimens.eight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.lightNavyBlue.withOpacity(.8),
                            blurRadius: Dimens.five,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomNannySvgTile(
                            assetName: Assets.iconsDollarCircle,
                            heading: TranslationKeys.referralEarned.tr,
                            aboutHeading:
                                '${controller.profileData.data?.bonusReferrals?.toInt()}',
                          ),
                        ],
                      ),
                    ),
                    Dimens.boxHeight20,
                    CustomButton(
                      backGroundColor: AppColors.navyBlue,
                      title: TranslationKeys.editProfile.tr,
                      onTap: () {
                        RouteManagement.goToEditNannyProfileView();
                      },
                    ),
                  ],
                  if (controller.selectedIndex == 1) ...[
                    servicesView(
                      servicesList: controller.profileData.data?.services,
                    ),
                    CustomButton(
                      backGroundColor: AppColors.navyBlue,
                      title: TranslationKeys.editServices.tr,
                      onTap: () {
                        RouteManagement.goToEditNannyServicesView();
                      },
                    ),
                  ],
                  if (controller.selectedIndex == 2) ...[
                    availabilityView(
                      controller: controller,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      );
}

Widget servicesView({
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

Widget availabilityView({required NannyProfileController controller}) =>
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
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                ),
                isTodayHighlighted: false,
                todayTextStyle: AppStyles.ubWhite15700,
                selectedTextStyle: AppStyles.ubWhite15700,
                selectedDecoration: const BoxDecoration(
                  color: AppColors.navyBlue,
                  shape: BoxShape.circle,
                ),
                rangeStartDecoration: const BoxDecoration(
                  color: AppColors.navyBlue,
                  shape: BoxShape.circle,
                ),
                rangeEndDecoration: const BoxDecoration(
                  color: AppColors.navyBlue,
                  shape: BoxShape.circle,
                ),
                rangeHighlightColor: AppColors.lightNavyBlue,
                markersMaxCount: 1,
                markerSize: Dimens.four,
                markersAutoAligned: true,
                markerMargin: Dimens.edgeInsets4,
                markersAlignment: Alignment.center,
              ),
              firstDay: DateTime.now(),
              lastDay: DateTime.utc(
                DateTime.now().year + 50,
              ),
              calendarFormat: CalendarFormat.month,
              headerStyle: HeaderStyle(
                titleTextStyle: AppStyles.ubBlack18W600,
                formatButtonVisible: false,
                titleCentered: true,
                leftChevronIcon: SvgPicture.asset(Assets.iconsLeft),
                rightChevronIcon: SvgPicture.asset(Assets.iconsRight),
              ),
              onDaySelected: (selectedDay, focusedDay) {
                controller.selectedDate = selectedDay;
                controller.focusDate = focusedDay;
                log('selected Date:${selectedDay.toUtc().toIso8601String()}');
                controller.getAvailabilityByDate(
                    dateTime: selectedDay.toUtc().toIso8601String());
                controller.update();
              },
              selectedDayPredicate: (day) => controller.selectedDate == day,
              focusedDay: controller.focusDate,
              onDayLongPressed: (selectedDay, focusedDay) {
                controller.isRangeSelection = !controller.isRangeSelection;
                controller.update();
                if (controller.isRangeSelection) {
                  controller.selectedDate = null;
                  controller.singleDay?.data = null;
                } else {
                  controller.rangeStartDate = null;
                  controller.rangeEndDate = null;
                }
                controller.update();
              },
              rangeSelectionMode: controller.isRangeSelection
                  ? RangeSelectionMode.toggledOn
                  : RangeSelectionMode.disabled,
              onRangeSelected: (start, end, focusedDay) {
                if (controller.isRangeSelection) {
                  controller.rangeStartDate = start;
                  controller.rangeEndDate = end;
                }
                log('start range : $start');
                log('End range : $end');
                controller.update();
              },
              rangeStartDay: controller.rangeStartDate,
              rangeEndDay: controller.rangeEndDate,
              eventLoader: (day) {
                return controller.isElementEqualToData(
                        controller.availabilityListModel?.data ?? [],
                        day.day,
                        day.month)
                    ? [
                        '.',
                      ]
                    : [];
              },
              availableGestures: AvailableGestures.all,
              onPageChanged: (focusedDay) {
                controller.focusDate = focusedDay;
                controller.selectedDate = null;

                /// used to  call api when calender month change.
                controller.getAvailabilityList(
                    dateTime: focusedDay.toUtc().toIso8601String());
                controller.update();
              },
            ),
          ),
          Dimens.boxHeight20,
          controller.singleDay?.data != null && controller.selectedDate != null
              ? Container(
                  padding: Dimens.edgeInsets16,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(Dimens.eight),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.lightNavyBlue.withOpacity(.8),
                        blurRadius: Dimens.five,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            text: Utility.getDay(
                                dateTime:
                                    controller.singleDay?.data?.openingTime),
                            style: AppStyles.ubBlack30W600,
                            maxLines: 1,
                          ),
                          Dimens.boxWidth16,
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                  text: Utility.convertDateToMMMMYYYEEE(
                                      controller.singleDay?.data?.openingTime ??
                                          DateTime.now()),
                                  style: AppStyles.ubGrey12W400,
                                  maxLines: 1,
                                  textAlign: TextAlign.start),
                              Dimens.boxHeight8,
                              AppText(
                                text:
                                    '${Utility.formatTimeTo12Hour(controller.singleDay?.data?.openingTime.toString())}  to ${Utility.formatTimeTo12Hour(controller.singleDay?.data?.closingTime.toString())}',
                                style: AppStyles.ubBlack14W700,
                                maxLines: 1,
                                textAlign: TextAlign.start,
                              )
                            ],
                          ),
                        ],
                      ),
                      PopupMenuButton(
                        padding: Dimens.edgeInsets4,
                        position: PopupMenuPosition.under,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(Dimens.six),
                        ),
                        icon: SvgPicture.asset(Assets.iconsMore),
                        itemBuilder: (BuildContext context) {
                          return [
                            PopupMenuItem(
                              onTap: () {
                                controller.startTime = null;
                                controller.endTime = null;

                                /// edit selected time
                                Get.dialog(
                                  GetBuilder<NannyProfileController>(
                                      builder: (nannyController) {
                                    return Center(
                                      child: Padding(
                                        padding: Dimens.edgeInsetsL16R16,
                                        child: Material(
                                          color: AppColors.primaryColor,
                                          borderRadius: BorderRadius.circular(
                                              Dimens.twenty),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: AppColors.primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimens.twenty),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: Dimens.edgeInsets10,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      AppText(
                                                        text: TranslationKeys
                                                            .editAvailability
                                                            .tr,
                                                        maxLines: 1,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: AppStyles
                                                            .ubBlack16W700,
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          Get.back();
                                                        },
                                                        child: SvgPicture.asset(
                                                          Assets
                                                              .iconsRemoveBottomSheet,
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
                                                Dimens.boxHeight14,
                                                Padding(
                                                  padding: Dimens.edgeInsets16,
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      TextField(
                                                        maxLines: 1,
                                                        minLines: 1,
                                                        readOnly: true,
                                                        onTap: () async {
                                                          nannyController
                                                                  .startTime =
                                                              await showTimePicker(
                                                            context:
                                                                Get.context!,
                                                            initialEntryMode:
                                                                TimePickerEntryMode
                                                                    .input,
                                                            initialTime: Utility
                                                                .convertDateTimeToTimeOfDay(controller
                                                                        .singleDay
                                                                        ?.data
                                                                        ?.openingTime ??
                                                                    DateTime
                                                                        .now()),
                                                            builder: (context,
                                                                    child) =>
                                                                MediaQuery(
                                                              data: MediaQuery.of(
                                                                      context)
                                                                  .copyWith(
                                                                      alwaysUse24HourFormat:
                                                                          false),
                                                              child: child!,
                                                            ),
                                                          );
                                                          nannyController
                                                              .update();
                                                          log('Edit startTime:${nannyController.startTime}');
                                                        },
                                                        decoration:
                                                            customFieldDeco(
                                                          hintStyle: AppStyles
                                                              .ubBlack15W600,
                                                          hintText: nannyController
                                                                      .startTime ==
                                                                  null
                                                              ? Utility.formatTimeTo12Hour(
                                                                  controller
                                                                      .singleDay
                                                                      ?.data
                                                                      ?.openingTime
                                                                      .toString())
                                                              : '${Utility.convertTo12HourFormat('${nannyController.startTime?.hour}:${nannyController.startTime?.minute}')} ${nannyController.startTime?.period.name.toUpperCase()}',
                                                        ),
                                                        cursorColor: AppColors
                                                            .blackColor,
                                                        cursorWidth: Dimens.one,
                                                        style: AppStyles
                                                            .ubBlack15W600,
                                                      ),
                                                      Dimens.boxHeight14,
                                                      TextField(
                                                        maxLines: 1,
                                                        readOnly: true,
                                                        onTap: () async {
                                                          nannyController
                                                                  .endTime =
                                                              await showTimePicker(
                                                            context:
                                                                Get.context!,
                                                            initialEntryMode:
                                                                TimePickerEntryMode
                                                                    .input,
                                                            initialTime: Utility
                                                                .convertDateTimeToTimeOfDay(controller
                                                                        .singleDay
                                                                        ?.data
                                                                        ?.closingTime ??
                                                                    DateTime
                                                                        .now()),
                                                            builder: (context,
                                                                    child) =>
                                                                MediaQuery(
                                                              data: MediaQuery.of(
                                                                      context)
                                                                  .copyWith(
                                                                      alwaysUse24HourFormat:
                                                                          false),
                                                              child: child!,
                                                            ),
                                                          );
                                                          nannyController
                                                              .update();
                                                          log('Edit EndTime:${nannyController.endTime}');
                                                        },
                                                        minLines: 1,
                                                        decoration:
                                                            customFieldDeco(
                                                          hintStyle: AppStyles
                                                              .ubBlack15W600,
                                                          hintText: nannyController
                                                                      .endTime ==
                                                                  null
                                                              ? Utility.formatTimeTo12Hour(
                                                                  controller
                                                                      .singleDay
                                                                      ?.data
                                                                      ?.closingTime
                                                                      .toString())
                                                              : '${Utility.convertTo12HourFormat('${nannyController.endTime?.hour}:${nannyController.endTime?.minute}')} ${nannyController.endTime?.period.name.toUpperCase()}',
                                                        ),
                                                        cursorColor: AppColors
                                                            .blackColor,
                                                        cursorWidth: Dimens.one,
                                                        style: AppStyles
                                                            .ubBlack15W600,
                                                      ),
                                                      Dimens.boxHeight14,
                                                      CustomButton(
                                                        backGroundColor:
                                                            AppColors.navyBlue,
                                                        title: TranslationKeys
                                                            .submit.tr,
                                                        onTap: () {
                                                          nannyController
                                                              .editAvailabilityValidator(
                                                            startTime: controller
                                                                    .startTime ??
                                                                Utility.convertDateTimeToTimeOfDay(controller
                                                                        .singleDay
                                                                        ?.data
                                                                        ?.openingTime ??
                                                                    DateTime
                                                                        .now()),
                                                            endTime: controller
                                                                    .endTime ??
                                                                Utility.convertDateTimeToTimeOfDay(controller
                                                                        .singleDay
                                                                        ?.data
                                                                        ?.closingTime ??
                                                                    DateTime
                                                                        .now()),
                                                            day: controller
                                                                .singleDay
                                                                ?.data
                                                                ?.openingTime,
                                                          );
                                                        },
                                                      ),
                                                      Dimens.boxHeight10,
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
                              child: Text(
                                TranslationKeys.edit.tr,
                                maxLines: 1,
                                style: AppStyles.ubGreen05B016Color12W500,
                                textAlign: TextAlign.left,
                              ),
                            ),
                            PopupMenuItem(
                              onTap: () {
                                controller.deleteAvailability(
                                    dateTime: controller
                                            .singleDay?.data?.openingTime ??
                                        DateTime.now());
                              },
                              child: Text(
                                TranslationKeys.delete.tr,
                                style: AppStyles.ubFc3030RedColor12W500,
                                textAlign: TextAlign.left,
                                maxLines: 1,
                              ),
                            ),
                          ];
                        },
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
          Dimens.boxHeight20,
          if (!controller.isElementEqualToData(
              controller.availabilityListModel?.data ?? [],
              controller.singleDay?.data?.openingTime?.day ?? 0,
              controller.singleDay?.data?.openingTime?.month ?? 0))
            Opacity(
              opacity: controller.isRangeSelection
                  ? controller.rangeStartDate != null &&
                          controller.rangeEndDate != null
                      ? 1
                      : 0.4
                  : controller.selectedDate != null
                      ? 1
                      : 0.4,
              child: CustomButton(
                title: TranslationKeys.addAvailability.tr,
                backGroundColor: AppColors.navyBlue,
                onTap: () {
                  controller.startTime = null;
                  controller.endTime = null;
                  if (controller.selectedDate != null ||
                      (controller.rangeStartDate != null &&
                          controller.rangeEndDate != null)) {
                    Get.dialog(
                      GetBuilder<NannyProfileController>(
                          builder: (nannyController) {
                        return Center(
                          child: Padding(
                            padding: Dimens.edgeInsetsL16R16,
                            child: Material(
                              color: AppColors.primaryColor,
                              borderRadius:
                                  BorderRadius.circular(Dimens.twenty),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius:
                                      BorderRadius.circular(Dimens.twenty),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: Dimens.edgeInsets10,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          AppText(
                                            text: TranslationKeys
                                                .addAvailability.tr,
                                            maxLines: 1,
                                            textAlign: TextAlign.left,
                                            style: AppStyles.ubBlack16W700,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Get.back();
                                            },
                                            child: SvgPicture.asset(
                                              Assets.iconsRemoveBottomSheet,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      color: AppColors.lightNavyBlue,
                                      height: Dimens.one,
                                    ),
                                    Dimens.boxHeight14,
                                    Padding(
                                      padding: Dimens.edgeInsets16,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextField(
                                            maxLines: 1,
                                            minLines: 1,
                                            readOnly: true,
                                            onTap: () async {
                                              nannyController.startTime =
                                                  await showTimePicker(
                                                context: Get.context!,
                                                initialEntryMode:
                                                    TimePickerEntryMode.input,
                                                initialTime: nannyController
                                                            .startTime !=
                                                        null
                                                    ? nannyController.startTime!
                                                    : TimeOfDay.now(),
                                                builder: (context, child) =>
                                                    MediaQuery(
                                                  data: MediaQuery.of(context)
                                                      .copyWith(
                                                          alwaysUse24HourFormat:
                                                              false),
                                                  child: child!,
                                                ),
                                              );
                                              nannyController.update();
                                              log('startTime:${nannyController.startTime}');
                                            },
                                            decoration: customFieldDeco(
                                              hintStyle:
                                                  nannyController.startTime ==
                                                          null
                                                      ? null
                                                      : AppStyles.ubBlack15W600,
                                              hintText: nannyController
                                                          .startTime ==
                                                      null
                                                  ? TranslationKeys.startTime.tr
                                                  : '${Utility.convertTo12HourFormat('${nannyController.startTime?.hour}:${nannyController.startTime?.minute}')} ${nannyController.startTime?.period.name.toUpperCase()}',
                                            ),
                                            cursorColor: AppColors.blackColor,
                                            cursorWidth: Dimens.one,
                                            style: AppStyles.ubBlack15W600,
                                          ),
                                          Dimens.boxHeight14,
                                          TextField(
                                            maxLines: 1,
                                            readOnly: true,
                                            onTap: () async {
                                              nannyController.endTime =
                                                  await showTimePicker(
                                                context: Get.context!,
                                                initialEntryMode:
                                                    TimePickerEntryMode.input,
                                                initialTime: nannyController
                                                            .endTime !=
                                                        null
                                                    ? nannyController.endTime!
                                                    : TimeOfDay.now(),
                                                builder: (context, child) =>
                                                    MediaQuery(
                                                  data: MediaQuery.of(context)
                                                      .copyWith(
                                                          alwaysUse24HourFormat:
                                                              false),
                                                  child: child!,
                                                ),
                                              );
                                              nannyController.update();
                                              log('endTime:${nannyController.endTime}');
                                            },
                                            minLines: 1,
                                            decoration: customFieldDeco(
                                              hintStyle:
                                                  nannyController.endTime ==
                                                          null
                                                      ? null
                                                      : AppStyles.ubBlack15W600,
                                              hintText: nannyController
                                                          .endTime ==
                                                      null
                                                  ? TranslationKeys.endTime.tr
                                                  : '${Utility.convertTo12HourFormat('${nannyController.endTime?.hour}:${nannyController.endTime?.minute}')} ${nannyController.endTime?.period.name.toUpperCase()}',
                                            ),
                                            cursorColor: AppColors.blackColor,
                                            cursorWidth: Dimens.one,
                                            style: AppStyles.ubBlack15W600,
                                          ),
                                          Dimens.boxHeight14,
                                          CustomButton(
                                            backGroundColor: AppColors.navyBlue,
                                            title: TranslationKeys.submit.tr,
                                            onTap: () {
                                              /// api for add availability validator
                                              nannyController.addAvailabilityValidator(
                                                  availabilityDatesList:
                                                      Utility.getDaysInBetween(
                                                          startDate: controller
                                                                  .rangeStartDate ??
                                                              DateTime.now(),
                                                          endDate: controller
                                                                  .rangeEndDate ??
                                                              DateTime.now()),
                                                  startTime:
                                                      controller.startTime,
                                                  endTime: controller.endTime);
                                            },
                                          ),
                                          Dimens.boxHeight10,
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
                  }
                },
              ),
            ),
        ],
      ),
    );
