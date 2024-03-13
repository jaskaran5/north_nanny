import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/customer/get_nanny_profile/get_nanny_profile_controller.dart';
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
import 'package:northshore_nanny_flutter/app/widgets/custom_bottom_sheet.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_button.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_nanny_profile_view.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_shimmer_skeleton.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_text_field.dart';
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
        builder: (controller) => Scaffold(
          appBar: CustomAppbarWidget(
            title: "Nanny Profile",
            centerTitle: true,
            actions: [
              // if (!isComeFromSetting)
              GestureDetector(
                onTap: () {
                  controller.isFavorite = !controller.isFavorite;
                  controller.update();
                },
                child: Padding(
                  padding: Dimens.edgeInsetsL16R16,
                  child: controller.getNannyData != null
                      ? SvgPicture.asset(controller.getNannyData!.isFavorite!
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
                                controller.getAvailabilityList();
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
                    Dimens.boxHeight20,
                    if (controller.selectedIndex == 0) ...[
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
                      servicesView(
                          servicesList: controller.getNannyData?.services ?? [],
                          rateList: controller.priceList),
                      // CustomButton(
                      //   backGroundColor: AppColors.navyBlue,
                      //   title: TranslationKeys.editServices.tr,
                      //   onTap: () {
                      //     RouteManagement.goToEditNannyServicesView();
                      //   },
                      // ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}

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
              firstDay: DateTime(
                DateTime.now().year,
              ),
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
              onDaySelected: (selectedDay, focusedDay) {
                controller.selectedDate = selectedDay;
                controller.update();
              },
              selectedDayPredicate: (day) => controller.selectedDate == day,
              focusedDay: controller.selectedDate ?? DateTime.now(),
              onDayLongPressed: (selectedDay, focusedDay) {
                controller.isRangeSelection = !controller.isRangeSelection;
                if (controller.isRangeSelection) {
                  controller.selectedDate = null;
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
              availableGestures: AvailableGestures.none,
              onPageChanged: (focusedDay) {
                /// used to  call api when calender month change.
              },
            ),
            // SfDateRangePicker(
            //   selectionMode: DateRangePickerSelectionMode.range,
            //   navigationMode: DateRangePickerNavigationMode.snap,
            //   onSelectionChanged: (args) {
            //     //   controller.selectedList.clear();
            //     log('selected Values:${args.value}');
            //     String _range =
            //         '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
            //         // ignore: lines_longer_than_80_chars
            //         ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
            //
            //     print("_range==> $_range");
            //
            //     //   controller.selectedList
            //     //       .addAll(dateRangePickerSelectionChangedArgs.value);
            //     //   log('selected Values:${controller.selectedList}');
            //     //
            //     //   if (controller.selectedList.isEmpty) {
            //     //     controller.startTime = null;
            //     //     controller.endTime = null;
            //     //   }
            //     //   controller.update();
            //   },
            //   view: DateRangePickerView.month,
            //   initialSelectedDate: controller.selectedDate,
            //   allowViewNavigation: false,
            //   backgroundColor: AppColors.primaryColor,
            //   enablePastDates: false,
            //   headerStyle: DateRangePickerHeaderStyle(
            //     textStyle: AppStyles.ubBlack18W600,
            //     backgroundColor: AppColors.primaryColor,
            //     textAlign: TextAlign.left,
            //   ),
            //   minDate: DateTime.now(),
            //   selectionColor: AppColors.navyBlue,
            //   selectionShape: DateRangePickerSelectionShape.circle,
            //   monthCellStyle: DateRangePickerMonthCellStyle(
            //     disabledDatesTextStyle: AppStyles.ubHintColor13W500,
            //     weekendTextStyle: AppStyles.ubHintColor15W500,
            //     textStyle: AppStyles.ubBlack15W600,
            //     todayTextStyle: AppStyles.ubNavyBlue15W600,
            //     leadingDatesTextStyle: AppStyles.ubHintColor13W500,
            //     trailingDatesTextStyle: AppStyles.ubHintColor13W500,
            //     todayCellDecoration: const BoxDecoration(
            //         color: Colors.transparent, shape: BoxShape.circle),
            //   ),
            //   cellBuilder: (context, cellDetails) =>
            //       GetBuilder<NannyProfileController>(
            //           builder: (nannyController) {
            //     return Container(
            //       decoration: BoxDecoration(
            //         border: Border.all(color: Colors.white),
            //       ),
            //       child: Column(
            //         mainAxisAlignment: MainAxisAlignment.spaceAround,
            //         children: [
            //           ClipRRect(
            //             borderRadius: BorderRadius.circular(Dimens.twenty),
            //             child: Container(
            //               height: Dimens.twenty,
            //               width: Dimens.twenty,
            //               alignment: Alignment.center,
            //               child: AppText(
            //                 text: cellDetails.date.day.toString(),
            //                 style: nannyController.selectedList
            //                         .contains(cellDetails)
            //                     ? AppStyles.ubWhite15700
            //                     : AppStyles.ubBlack15W600,
            //                 maxLines: 1,
            //               ),
            //             ),
            //           ),
            //           // if (controller.availabilityListModel?.data?.indexWhere(
            //           //         (element) {
            //           //           print('data:${element.openingTime?.day}');
            //           //
            //           //           return (element.openingTime?.day ?? 0) ==
            //           //             cellDetails.date.day;
            //           //         }) !=
            //           //     null)
            //           //   Container(
            //           //     height: Dimens.five,
            //           //     width: Dimens.five,
            //           //     decoration: const BoxDecoration(
            //           //       color: AppColors.navyBlue,
            //           //       shape: BoxShape.circle,
            //           //     ),
            //           //   )
            //         ],
            //       ),
            //     );
            //   }),
            //   monthViewSettings: DateRangePickerMonthViewSettings(
            //     showTrailingAndLeadingDates: true,
            //     viewHeaderStyle: DateRangePickerViewHeaderStyle(
            //       textStyle: AppStyles.ubGrey14W500,
            //     ),
            //   ),
            //   initialDisplayDate: controller.selectedDate,
            //   rangeSelectionColor: AppColors.lightNavyBlue,
            //   startRangeSelectionColor: AppColors.navyBlue,
            //   rangeTextStyle: AppStyles.ubBlack15W600,
            //   endRangeSelectionColor: AppColors.navyBlue,
            //   todayHighlightColor: AppColors.navyBlue,
            // ),
          ),
          Dimens.boxHeight20,
          // controller.isElementEqualToData(
          //         controller.availabilityListModel?.data ?? [],
          //         controller.selectedDate?.day ?? 0)
          //     ? Container(
          //         padding: Dimens.edgeInsets16,
          //         decoration: BoxDecoration(
          //           color: AppColors.primaryColor,
          //           borderRadius: BorderRadius.circular(Dimens.eight),
          //           boxShadow: [
          //             BoxShadow(
          //               color: AppColors.lightNavyBlue.withOpacity(.8),
          //               blurRadius: Dimens.five,
          //             ),
          //           ],
          //         ),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             Row(
          //               mainAxisSize: MainAxisSize.min,
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 AppText(
          //                   text: controller.selectedDate!.day
          //                       .toString()
          //                       .padLeft(2, '0')
          //                       .toString(),
          //                   style: AppStyles.ubBlack30W600,
          //                   maxLines: 1,
          //                 ),
          //                 Dimens.boxWidth16,
          //                 Column(
          //                   mainAxisSize: MainAxisSize.min,
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: [
          //                     AppText(
          //                         text: Utility.convertDateToMMMMYYYEEE(
          //                             controller.selectedDate ??
          //                                 DateTime.now()),
          //                         style: AppStyles.ubGrey12W400,
          //                         maxLines: 1,
          //                         textAlign: TextAlign.start),
          //                     Dimens.boxHeight8,
          //                     AppText(
          //                       text:
          //                           '${Utility.formatTimeTo12Hour(controller.returnOpeningTime(
          //                         list:
          //                             controller.availabilityListModel?.data ??
          //                                 [],
          //                       ))}  to ${Utility.formatTimeTo12Hour(controller.returnClosingTime(
          //                         list:
          //                             controller.availabilityListModel?.data ??
          //                                 [],
          //                       ))} ',
          //                       style: AppStyles.ubBlack14W700,
          //                       maxLines: 1,
          //                       textAlign: TextAlign.start,
          //                     )
          //                   ],
          //                 ),
          //               ],
          //             ),
          //             PopupMenuButton(
          //               padding: Dimens.edgeInsets4,
          //               position: PopupMenuPosition.under,
          //               elevation: 2,
          //               shape: RoundedRectangleBorder(
          //                 borderRadius: BorderRadius.circular(Dimens.six),
          //               ),
          //               icon: SvgPicture.asset(Assets.iconsMore),
          //               itemBuilder: (BuildContext context) {
          //                 return [
          //                   PopupMenuItem(
          //                     onTap: () {
          //                       /// edit selected time
          //                       Get.dialog(
          //                         GetBuilder<NannyProfileController>(
          //                             builder: (nannyController) {
          //                           return Center(
          //                             child: Padding(
          //                               padding: Dimens.edgeInsetsL16R16,
          //                               child: Material(
          //                                 color: AppColors.primaryColor,
          //                                 borderRadius: BorderRadius.circular(
          //                                     Dimens.twenty),
          //                                 child: Container(
          //                                   decoration: BoxDecoration(
          //                                     color: AppColors.primaryColor,
          //                                     borderRadius:
          //                                         BorderRadius.circular(
          //                                             Dimens.twenty),
          //                                   ),
          //                                   child: Column(
          //                                     mainAxisSize: MainAxisSize.min,
          //                                     crossAxisAlignment:
          //                                         CrossAxisAlignment.start,
          //                                     children: [
          //                                       Padding(
          //                                         padding: Dimens.edgeInsets10,
          //                                         child: Row(
          //                                           mainAxisAlignment:
          //                                               MainAxisAlignment
          //                                                   .spaceBetween,
          //                                           children: [
          //                                             AppText(
          //                                               text: TranslationKeys
          //                                                   .addAvailability.tr,
          //                                               maxLines: 1,
          //                                               textAlign:
          //                                                   TextAlign.left,
          //                                               style: AppStyles
          //                                                   .ubBlack16W700,
          //                                             ),
          //                                             GestureDetector(
          //                                               onTap: () {
          //                                                 Get.back();
          //                                               },
          //                                               child: SvgPicture.asset(
          //                                                 Assets
          //                                                     .iconsRemoveBottomSheet,
          //                                               ),
          //                                             ),
          //                                           ],
          //                                         ),
          //                                       ),
          //                                       Divider(
          //                                         color:
          //                                             AppColors.lightNavyBlue,
          //                                         height: Dimens.one,
          //                                       ),
          //                                       Dimens.boxHeight14,
          //                                       Padding(
          //                                         padding: Dimens.edgeInsets16,
          //                                         child: Column(
          //                                           mainAxisSize:
          //                                               MainAxisSize.min,
          //                                           crossAxisAlignment:
          //                                               CrossAxisAlignment
          //                                                   .start,
          //                                           children: [
          //                                             TextField(
          //                                               maxLines: 1,
          //                                               minLines: 1,
          //                                               readOnly: true,
          //                                               onTap: () async {
          //                                                 nannyController
          //                                                         .startTime =
          //                                                     await showTimePicker(
          //                                                   context:
          //                                                       Get.context!,
          //                                                   initialTime:
          //                                                       TimeOfDay.now(),
          //                                                 );
          //                                                 nannyController
          //                                                     .update();
          //                                                 log('startTime:${nannyController.startTime}');
          //                                               },
          //                                               decoration:
          //                                                   customFieldDeco(
          //                                                 hintStyle: nannyController
          //                                                             .startTime ==
          //                                                         null
          //                                                     ? null
          //                                                     : AppStyles
          //                                                         .ubBlack15W600,
          //                                                 hintText: nannyController
          //                                                             .startTime ==
          //                                                         null
          //                                                     ? TranslationKeys
          //                                                         .startTime.tr
          //                                                     : '${Utility.convertTo12HourFormat('${nannyController.startTime?.hour}:${nannyController.startTime?.minute}')} ${nannyController.startTime?.period.name}',
          //                                               ),
          //                                               cursorColor: AppColors
          //                                                   .blackColor,
          //                                               cursorWidth: Dimens.one,
          //                                               style: AppStyles
          //                                                   .ubBlack15W600,
          //                                             ),
          //                                             Dimens.boxHeight14,
          //                                             TextField(
          //                                               maxLines: 1,
          //                                               readOnly: true,
          //                                               onTap: () async {
          //                                                 nannyController
          //                                                         .endTime =
          //                                                     await showTimePicker(
          //                                                   context:
          //                                                       Get.context!,
          //                                                   initialTime: controller
          //                                                           .returnClosingTime(
          //                                                         list: controller
          //                                                                 .availabilityListModel
          //                                                                 ?.data ??
          //                                                             [],
          //                                                       ) ??
          //                                                       TimeOfDay.now(),
          //                                                 );
          //                                                 nannyController
          //                                                     .update();
          //                                                 log('endTime:${nannyController.endTime}');
          //                                               },
          //                                               minLines: 1,
          //                                               decoration:
          //                                                   customFieldDeco(
          //                                                 hintStyle: nannyController
          //                                                             .endTime ==
          //                                                         null
          //                                                     ? null
          //                                                     : AppStyles
          //                                                         .ubBlack15W600,
          //                                                 hintText: nannyController
          //                                                             .endTime ==
          //                                                         null
          //                                                     ? TranslationKeys
          //                                                         .endTime.tr
          //                                                     : '${Utility.convertTo12HourFormat('${nannyController.endTime?.hour}:${nannyController.endTime?.minute}')} ${nannyController.endTime?.period.name}',
          //                                               ),
          //                                               cursorColor: AppColors
          //                                                   .blackColor,
          //                                               cursorWidth: Dimens.one,
          //                                               style: AppStyles
          //                                                   .ubBlack15W600,
          //                                             ),
          //                                             Dimens.boxHeight14,
          //                                             CustomButton(
          //                                               backGroundColor:
          //                                                   AppColors.navyBlue,
          //                                               title: TranslationKeys
          //                                                   .submit.tr,
          //                                               onTap: () {
          //                                                 String formatList;
          //                                                 DateTime list;
          //                                                 List<DateTime>
          //                                                     startTimeList =
          //                                                     [];
          //                                                 List<DateTime>
          //                                                     endTimeList = [];
          //                                                 if (nannyController
          //                                                             .startTime !=
          //                                                         null ||
          //                                                     nannyController
          //                                                             .endTime !=
          //                                                         null) {
          //                                                   for (var i in controller
          //                                                       .selectedList) {
          //                                                     formatList =
          //                                                         DateFormat(
          //                                                                 'yyyy-MM-dd')
          //                                                             .format(
          //                                                                 i);
          //                                                     list = DateTime
          //                                                         .parse(
          //                                                             formatList);
          //                                                     startTimeList
          //                                                         .add(DateTime(
          //                                                       list.year,
          //                                                       list.month,
          //                                                       list.day,
          //                                                       nannyController
          //                                                           .startTime!
          //                                                           .hour,
          //                                                       nannyController
          //                                                           .startTime!
          //                                                           .minute,
          //                                                     ).toUtc());
          //                                                     endTimeList
          //                                                         .add(DateTime(
          //                                                       list.year,
          //                                                       list.month,
          //                                                       list.day,
          //                                                       nannyController
          //                                                           .endTime!
          //                                                           .hour,
          //                                                       nannyController
          //                                                           .endTime!
          //                                                           .minute,
          //                                                     ).toUtc());
          //                                                   }
          //                                                 }
          //                                                 log('start Time List:$startTimeList');
          //                                                 log('End time List:$endTimeList');
          //                                                 List<
          //                                                         Map<String,
          //                                                             dynamic>>
          //                                                     finalList = [];
          //                                                 for (int value = 0;
          //                                                     value <
          //                                                         startTimeList
          //                                                             .length;
          //                                                     value++) {
          //                                                   finalList.add({
          //                                                     "openingTime":
          //                                                         startTimeList[
          //                                                                 value]
          //                                                             .toString(),
          //                                                     "closingTime":
          //                                                         endTimeList[
          //                                                                 value]
          //                                                             .toString(),
          //                                                   });
          //                                                 }
          //                                                 log('final list:$finalList');
          //
          //                                                 /// api for add availability validator
          //                                                 nannyController.addAvailabilityValidator(
          //                                                     availabilityList:
          //                                                         finalList,
          //                                                     startTime:
          //                                                         controller
          //                                                             .startTime,
          //                                                     endTime:
          //                                                         controller
          //                                                             .endTime);
          //                                               },
          //                                             ),
          //                                             Dimens.boxHeight10,
          //                                           ],
          //                                         ),
          //                                       ),
          //                                     ],
          //                                   ),
          //                                 ),
          //                               ),
          //                             ),
          //                           );
          //                         }),
          //                       );
          //                     },
          //                     child: Text(
          //                       TranslationKeys.edit.tr,
          //                       maxLines: 1,
          //                       style: AppStyles.ubGreen05B016Color12W500,
          //                       textAlign: TextAlign.left,
          //                     ),
          //                   ),
          //                   PopupMenuItem(
          //                     child: Text(
          //                       TranslationKeys.delete.tr,
          //                       style: AppStyles.ubFc3030RedColor12W500,
          //                       textAlign: TextAlign.left,
          //                       maxLines: 1,
          //                     ),
          //                   ),
          //                 ];
          //               },
          //             ),
          //           ],
          //         ),
          //       )
          //     : const SizedBox.shrink(),
          Dimens.boxHeight20,
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
                Get.dialog(
                  GetBuilder<NannyProfileController>(
                      builder: (nannyController) {
                    return Center(
                      child: Padding(
                        padding: Dimens.edgeInsetsL16R16,
                        child: Material(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(Dimens.twenty),
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
                                        text:
                                            TranslationKeys.addAvailability.tr,
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
                                            initialTime:
                                                nannyController.startTime !=
                                                        null
                                                    ? nannyController.startTime!
                                                    : TimeOfDay.now(),
                                          );
                                          nannyController.update();
                                          log('startTime:${nannyController.startTime}');
                                        },
                                        decoration: customFieldDeco(
                                          hintStyle:
                                              nannyController.startTime == null
                                                  ? null
                                                  : AppStyles.ubBlack15W600,
                                          hintText: nannyController.startTime ==
                                                  null
                                              ? TranslationKeys.startTime.tr
                                              : '${Utility.convertTo12HourFormat('${nannyController.startTime?.hour}:${nannyController.startTime?.minute}')} ${nannyController.startTime?.period.name}',
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
                                            initialTime:
                                                nannyController.endTime != null
                                                    ? nannyController.endTime!
                                                    : TimeOfDay.now(),
                                          );
                                          nannyController.update();
                                          log('endTime:${nannyController.endTime}');
                                        },
                                        minLines: 1,
                                        decoration: customFieldDeco(
                                          hintStyle:
                                              nannyController.endTime == null
                                                  ? null
                                                  : AppStyles.ubBlack15W600,
                                          hintText: nannyController.endTime ==
                                                  null
                                              ? TranslationKeys.endTime.tr
                                              : '${Utility.convertTo12HourFormat('${nannyController.endTime?.hour}:${nannyController.endTime?.minute}')} ${nannyController.endTime?.period.name}',
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
                                          // String formatList;
                                          // DateTime list;
                                          // List<DateTime> startTimeList = [];
                                          // List<DateTime> endTimeList = [];
                                          // if (nannyController.startTime != null || nannyController.endTime != null) {
                                          //   for (var i in controller.selectedList) {
                                          //     formatList = DateFormat('yyyy-MM-dd').format(i);
                                          //     list = DateTime.parse(formatList);
                                          //     var date  =DateTime(
                                          //       list.year,
                                          //       list.month,
                                          //       list.day,
                                          //       nannyController.startTime!.hour,
                                          //       nannyController.startTime!.minute,
                                          //     ).toUtc().toIso8601String();
                                          //     print("Date =======>>$date ");
                                          //     startTimeList.add(date);
                                          //     endTimeList.add(DateTime(
                                          //       list.year,
                                          //       list.month,
                                          //       list.day,
                                          //       nannyController
                                          //           .endTime!.hour,
                                          //       nannyController
                                          //           .endTime!.minute,
                                          //     ).toUtc().toIso8601String());
                                          //   }
                                          // }
                                          // log('start Time List:$startTimeList');
                                          // log('End time List:$endTimeList');
                                          // List<Map<String, dynamic>>
                                          //     finalList = [];
                                          // for (int value = 0;
                                          //     value < startTimeList.length;
                                          //     value++) {
                                          //   finalList.add({
                                          //     "openingTime":
                                          //         startTimeList[value]
                                          //             .toString(),
                                          //     "closingTime":
                                          //         endTimeList[value]
                                          //             .toString(),
                                          //   });
                                          // }
                                          // log('final list:$finalList');

                                          /// api for add availability validator
                                          // nannyController
                                          //     .addAvailabilityValidator(
                                          //         availabilityList: [],
                                          //         startTime:
                                          //             controller.startTime,
                                          //         endTime:
                                          //             controller.endTime);
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
            ),
          ),
        ],
      ),
    );
