import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/customer/get_nanny_profile/get_nanny_profile_controller.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/utils/utility.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_app_bar.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_button.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_text_field.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../res/theme/colors.dart';
import '../../res/theme/styles.dart';
import '../../widgets/app_text.dart';
import '../../widgets/custom_booking_receipt_tile.dart';

class ScheduleNannyView extends StatelessWidget {
  const ScheduleNannyView({super.key});

  @override
  Widget build(BuildContext context) => GetBuilder(
      init: GetNannyProfileController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppbarWidget(
            title: TranslationKeys.scheduleNanny.tr,
          ),
          body: Padding(
            padding: Dimens.edgeInsets16,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(Dimens.eight),
                      border: Border.all(
                        color: AppColors.dividerColor,
                        width: Dimens.one,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.lightNavyBlue.withOpacity(.8),
                          blurRadius: Dimens.five,
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: Dimens.edgeInsetsL10R10,
                          child: TableCalendar(
                            sixWeekMonthsEnforced: true,
                            startingDayOfWeek: StartingDayOfWeek.monday,
                            daysOfWeekStyle: DaysOfWeekStyle(
                              weekdayStyle: AppStyles.ubHintColor13W500,
                              weekendStyle: AppStyles.ubHintColor13W500,
                            ),
                            calendarStyle: CalendarStyle(
                              isTodayHighlighted: false,
                              defaultTextStyle: AppStyles.ubBlack15W600,
                              weekendTextStyle: AppStyles.ubBlack15W600,
                              outsideTextStyle: AppStyles.ubHintColor15W500,
                              todayDecoration: const BoxDecoration(
                                color: AppColors.navyBlue,
                                shape: BoxShape.circle,
                              ),
                              selectedDecoration: const BoxDecoration(
                                color: AppColors.navyBlue,
                                shape: BoxShape.circle,
                              ),
                              markersMaxCount: 1,
                              markerSize: Dimens.four,
                              markersAutoAligned: true,
                              markerMargin: Dimens.edgeInsets4,
                              markersAlignment: Alignment.center,
                              todayTextStyle: AppStyles.ubWhite15700,
                              selectedTextStyle: AppStyles.ubWhite15700,
                              markerDecoration: const BoxDecoration(
                                  color: AppColors.navyBlue,
                                  shape: BoxShape.circle),
                            ),
                            firstDay: DateTime.now(),
                            lastDay: DateTime.utc(
                              2050,
                            ),
                            headerStyle: HeaderStyle(
                              titleTextStyle: AppStyles.ubBlack18W600,
                              formatButtonVisible: false,
                              titleCentered: true,
                              leftChevronIcon:
                                  SvgPicture.asset(Assets.iconsLeft),
                              rightChevronIcon:
                                  SvgPicture.asset(Assets.iconsRight),
                            ),
                            onDaySelected: (selectedDay, focusedDay) {
                              log("selected day:--$selectedDay");
                              log("focusedDay day:--$focusedDay");

                              /// used to update the  values of selected date and focus date.
                              controller.updateSelectedDate(
                                  date: selectedDay, focusDate: focusedDay);

                              /// used to get the data by date.
                              controller.getNannyDataByDate(date: selectedDay);
                            },
                            focusedDay: controller.focusedDay,
                            selectedDayPredicate: (day) =>
                                controller.selectedDate == day,
                            eventLoader: (day) {
                              return controller.isElementEqualToData(
                                controller.getNannyData!.avilabilityList ?? [],
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
                        Divider(
                          color: AppColors.dividerColor,
                          height: Dimens.one,
                        ),
                        Padding(
                          padding: Dimens.edgeInsets16,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                text: Utility.getDay(
                                  dateTime: controller.singleDay?.data
                                          ?.bookingDetail?.openingTime ??
                                      DateTime.now(),
                                ),
                                style: AppStyles.ubBlack30W600,
                                maxLines: 1,
                                textAlign: TextAlign.start,
                              ),
                              Dimens.boxWidth16,
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText(
                                    text: Utility.convertDateToMMMMYYYEEE(
                                      controller.singleDay?.data?.bookingDetail
                                              ?.openingTime ??
                                          DateTime.now(),
                                    ),
                                    style: AppStyles.ubGrey12W400,
                                    maxLines: 1,
                                    textAlign: TextAlign.start,
                                  ),
                                  Dimens.boxHeight8,
                                  AppText(
                                    text:
                                        '${Utility.formatTimeTo12Hour(controller.singleDay?.data?.bookingDetail?.openingTime.toString())} to ${Utility.formatTimeTo12Hour(controller.singleDay?.data?.bookingDetail?.closingTime.toString())}',
                                    style: AppStyles.ubBlack14W700,
                                    maxLines: 1,
                                    textAlign: TextAlign.start,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: AppColors.dividerColor,
                          height: Dimens.one,
                        ),
                        Padding(
                          padding: Dimens.edgeInsets16,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(Assets.iconsInfoGreen),
                              Dimens.boxWidth10,
                              Flexible(
                                child: AppText(
                                  text:
                                      'This nanny is available from  ${Utility.formatTimeTo12Hour(controller.singleDay?.data?.bookingDetail?.openingTime.toString())} to ${Utility.formatTimeTo12Hour(controller.singleDay?.data?.bookingDetail?.closingTime.toString())} ',
                                  maxLines: 2,
                                  style: AppStyles.ubGreen12W600,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Dimens.boxHeight16,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          controller.startTime = await showTimePicker(
                            context: Get.context!,
                            initialTime: Utility.convertDateTimeToTimeOfDay(
                                controller.singleDay?.data?.bookingDetail
                                        ?.openingTime ??
                                    DateTime.now()),
                          );
                          controller.update();
                          log('Edit startTime:${controller.startTime}');
                        },
                        child: Container(
                          height: Dimens.fiftyThree,
                          width: Dimens.oneHundredFifty,
                          padding: Dimens.edgeInsets8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              Dimens.eight,
                            ),
                            border: Border.all(
                              color: AppColors.lightNavyBlue,
                              width: Dimens.one,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(
                                Assets.iconsClock,
                                height: Dimens.twenty,
                                width: Dimens.twenty,
                              ),
                              Dimens.boxWidth10,
                              AppText(
                                text: controller.startTime == null
                                    ? Utility.formatTimeTo12Hour(controller
                                        .singleDay
                                        ?.data
                                        ?.bookingDetail
                                        ?.openingTime
                                        .toString())
                                    : '${Utility.convertTo12HourFormat('${controller.startTime?.hour}:${controller.startTime?.minute}')} ${controller.startTime?.period.name}',
                                style: AppStyles.ubBlack15W600,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          controller.endTime = await showTimePicker(
                            context: Get.context!,
                            initialTime: Utility.convertDateTimeToTimeOfDay(
                                controller.singleDay?.data?.bookingDetail
                                        ?.closingTime ??
                                    DateTime.now()),
                          );
                          controller.update();
                          log('Edit endTime:${controller.endTime}');
                        },
                        child: Container(
                          height: Dimens.fiftyThree,
                          width: Dimens.oneHundredFifty,
                          padding: Dimens.edgeInsets8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              Dimens.eight,
                            ),
                            border: Border.all(
                              color: AppColors.lightNavyBlue,
                              width: Dimens.one,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(
                                Assets.iconsClock,
                                height: Dimens.twenty,
                                width: Dimens.twenty,
                              ),
                              Dimens.boxWidth10,
                              AppText(
                                text: controller.endTime == null
                                    ? Utility.formatTimeTo12Hour(controller
                                        .singleDay
                                        ?.data
                                        ?.bookingDetail
                                        ?.closingTime
                                        .toString())
                                    : '${Utility.convertTo12HourFormat('${controller.endTime?.hour}:${controller.endTime?.minute}')} ${controller.endTime?.period.name}',
                                style: AppStyles.ubBlack15W600,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (controller.singleDay?.data?.bookedSlot?.isNotEmpty ==
                      true) ...[
                    Dimens.boxHeight8,
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          Assets.iconsInfoGreyCircle,
                        ),
                        Dimens.boxWidth8,
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: AppText(
                                text:
                                    'The nanny is not available ${controller.singleDay?.data?.bookedSlot?.map((e) => 'from ${Utility.formatTimeTo12Hour(e.openingTime.toString())} to ${Utility.formatTimeTo12Hour(e.closingTime.toString())} ').toList().join(',\n ')} ',
                                maxLines: 2,
                                style: AppStyles.ubHintColor12W500,
                                textAlign: TextAlign.left,
                              ),
                            ),
                            // Dimens.boxHeight5,
                            // AppText(
                            //   text: controller.singleDay?.data?.bookedSlot
                            //       ?.map((e) =>
                            //           ' from ${Utility.formatTimeTo12Hour(e.openingTime.toString())} to ${Utility.formatTimeTo12Hour(e.closingTime.toString())} \n ')
                            //       .toList()
                            //       .join(', '),
                            //   style: AppStyles.ubHintColor12W500,
                            //   textAlign: TextAlign.left,
                            //   maxLines: 4,
                            // )
                          ],
                        )
                      ],
                    ),
                  ],
                  Dimens.boxHeight16,

                  TextField(
                    onTap: () {
                      controller.showMultiSelectDialogServices(context);
                    },
                    readOnly: true,
                    controller: controller.typeOfServiceTextController,
                    maxLines: 1,
                    minLines: 1,
                    decoration: customFieldDeco(
                      suffix: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 40.0,
                      ),
                      hintText: "Type of service",
                      prefixWidget: Padding(
                        padding: Dimens.edgeInsets12,
                        child: SvgPicture.asset(
                          Assets.iconsBrifecaseCross,
                          height: Dimens.ten,
                          width: Dimens.ten,
                        ),
                      ),
                    ),
                    cursorColor: AppColors.blackColor,
                    cursorWidth: Dimens.one,
                    style: AppStyles.ubBlack15W600,
                  ),

                  // /// TYPE OF SERVICE ==========>>>>>>>>> DROPDOWN <<<<<<-------
                  // MultiDropDownAppDropdown(
                  //     hintText: "Type of service",
                  //     onItemRemoved: (p0, p1) {
                  //       log("p0-- $p0");
                  //       log("p1-- $p1");
                  //     },
                  //     selectedItem: controller.selectedServices,
                  //     itemBuilderPhysics: const ScrollPhysics(),
                  //     onChanged: (value) {
                  //       log("select value -->> $value");
                  //       controller.updateSelectedServices(value: value);
                  //       return;
                  //     },
                  //     // maxHeight: Dimens.twoHundredSeventy,
                  //     baseTextStyle: AppStyles.ubHintColor15W500,
                  //     prefix: SvgPicture.asset(Assets.iconsBrifecaseCross),
                  //     items: controller.getNannyData?.services?.toList() ?? [],
                  //     itemBuilder: (context, item, isSelected) {
                  //       return PopupMenuItem(
                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           mainAxisSize: MainAxisSize.min,
                  //           children: [
                  //             Padding(
                  //               padding: Dimens.edgeInsetsH20V15,
                  //               child: Row(
                  //                 mainAxisAlignment:
                  //                     MainAxisAlignment.spaceBetween,
                  //                 children: [
                  //                   AppText(
                  //                     text: item.toString().tr,
                  //                     maxLines: 1,
                  //                     textAlign: TextAlign.start,
                  //                     style: AppStyles.ubNavyBlue15W600,
                  //                   ),
                  //                   // if (controller.selectedServices.value
                  //                   //         .contains(item) ||
                  //                   //     isSelected)
                  //                   //   SvgPicture.asset(Assets.iconsCircleTick)
                  //                 ],
                  //               ),
                  //             ),
                  //             Divider(
                  //               color: AppColors.dividerColor,
                  //               height: Dimens.two,
                  //             )
                  //           ],
                  //         ),
                  //       );
                  //     }

                  //     // {
                  //     //   bool isItemSelected =
                  //     //       controller.selectedServices.contains(item);

                  //     //   log("is item selected already :-->. $isItemSelected");
                  //     //   return GestureDetector(
                  //     //     onTap: () {
                  //     //       if (controller.selectedServices.contains(item)) {
                  //     //         controller.selectedServices.remove(item);
                  //     //       } else {
                  //     //         controller.selectedServices.add(item);
                  //     //       }
                  //     //       controller.update();
                  //     //     },
                  //     //     child: Column(
                  //     //       crossAxisAlignment: CrossAxisAlignment.start,
                  //     //       mainAxisSize: MainAxisSize.min,
                  //     //       children: [
                  //     //         Padding(
                  //     //           padding: Dimens.edgeInsetsH20V15,
                  //     //           child: Row(
                  //     //             mainAxisAlignment:
                  //     //                 MainAxisAlignment.spaceBetween,
                  //     //             children: [
                  //     //               AppText(
                  //     //                 text: item.toString().tr,
                  //     //                 maxLines: 1,
                  //     //                 textAlign: TextAlign.start,
                  //     //                 style: AppStyles.ubNavyBlue15W600,
                  //     //               ),
                  //     //               // if (controller.selectedServices.value
                  //     //               //         .contains(item) ||
                  //     //               //     isSelected)
                  //     //               //   SvgPicture.asset(Assets.iconsCircleTick)
                  //     //             ],
                  //     //           ),
                  //     //         ),
                  //     //         Divider(
                  //     //           color: AppColors.dividerColor,
                  //     //           height: Dimens.two,
                  //     //         )
                  //     //       ],
                  //     //     ),
                  //     //   );
                  //     // },

                  //     ),

                  Dimens.boxHeight16,

                  //** SELECT CHILDREN */

                  TextField(
                    onTap: () {
                      controller.showMultiSelectDialogChildren(context);
                    },
                    readOnly: true,
                    controller: controller.selectChildrenTextController,
                    maxLines: 1,
                    minLines: 1,
                    decoration: customFieldDeco(
                      suffix: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 40.0,
                      ),
                      hintText: "Select Children",
                      prefixWidget: Padding(
                        padding: Dimens.edgeInsets12,
                        child: SvgPicture.asset(
                          Assets.iconsBrifecaseCross,
                          height: Dimens.ten,
                          width: Dimens.ten,
                        ),
                      ),
                    ),
                    cursorColor: AppColors.blackColor,
                    cursorWidth: Dimens.one,
                    style: AppStyles.ubBlack15W600,
                  ),

                  // MultiDropDownAppDropdown(
                  //   // maxHeight: controller.childList.length * 20,
                  //   // height: controller.childList.length * 20,
                  //   hintText: "Select children",
                  //   onItemRemoved: (p0, p1) {
                  //     log("p0-- $p0");
                  //     log("p1-- $p1");
                  //   },
                  //   selectedItem: controller.selectedChildList,
                  //   itemBuilderPhysics: const ScrollPhysics(),
                  //   onChanged: (value) {
                  //     controller.updateSelectedChildren(value: value);
                  //     return;
                  //   },
                  //   // maxHeight: Dimens.oneHundredEightyTwo,
                  //   baseTextStyle: AppStyles.ubHintColor15W500,
                  //   prefix: SvgPicture.asset(Assets.iconsBabyBoy),
                  //   items: [
                  //     // 'Select all',
                  //     ...controller.childList
                  //         .map((element) => element.name.toString()),
                  //     // "+ Add kids"
                  //   ],
                  //   itemBuilder: (context, item, isSelected) {
                  //     return PopupMenuItem(
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         mainAxisSize: MainAxisSize.min,
                  //         children: [
                  //           //
                  //           Padding(
                  //             padding: Dimens.edgeInsetsH20V15,
                  //             child: Row(
                  //               mainAxisAlignment:
                  //                   MainAxisAlignment.spaceBetween,
                  //               children: [
                  //                 AppText(
                  //                   text: item.toString().tr,
                  //                   maxLines: 1,
                  //                   textAlign: TextAlign.start,
                  //                   style: AppStyles.ubNavyBlue15W600,
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //           Divider(
                  //             color: AppColors.dividerColor,
                  //             height: Dimens.two,
                  //           )
                  //         ],
                  //       ),
                  //     );
                  //     // bool isItemSelected =
                  //     //     controller.selectedChildList.contains(item);

                  //     // log("is item selected already :-->. $isItemSelected");
                  //     // return GestureDetector(
                  //     //   onTap: () {
                  //     //     if (controller.selectedChildList.contains(item)) {
                  //     //       controller.selectedChildList.remove(item);
                  //     //     } else {
                  //     //       controller.selectedChildList.add(item);
                  //     //     }
                  //     //     controller.update();
                  //     //   },
                  //     //   child: Column(
                  //     //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     //     mainAxisSize: MainAxisSize.min,
                  //     //     children: [
                  //     //       //
                  //     //       Padding(
                  //     //         padding: Dimens.edgeInsetsH20V15,
                  //     //         child: Row(
                  //     //           mainAxisAlignment:
                  //     //               MainAxisAlignment.spaceBetween,
                  //     //           children: [
                  //     //             AppText(
                  //     //               text: item.toString().tr,
                  //     //               maxLines: 1,
                  //     //               textAlign: TextAlign.start,
                  //     //               style: AppStyles.ubNavyBlue15W600,
                  //     //             ),
                  //     //           ],
                  //     //         ),
                  //     //       ),
                  //     //       Divider(
                  //     //         color: AppColors.dividerColor,
                  //     //         height: Dimens.two,
                  //     //       )
                  //     //     ],
                  //     //   ),

                  //     // );
                  //   },
                  // ),

                  // AppDropdown(
                  //   selectedItem: ' ',
                  //   onChanged: (value) {
                  //     log("value: $value");
                  //   },

                  //   baseTextStyle: AppStyles.ubHintColor15W500,
                  //   prefix: SvgPicture.asset(Assets.iconsBabyBoy),
                  //   items: [
                  //     'Select all',
                  //     ...controller.childList.map((element) => element.name),
                  //     "+ Add kids"
                  //   ],

                  //   // controller.childList.map((element) {return

                  //   // DropdownMenuItem(child: child)
                  //   // })

                  //   // controller.childList.toList(),
                  //   // const [
                  //   //   'Select all',
                  //   //   'Alexander',
                  //   //   'Oliver',
                  //   //   'add',
                  //   // ],

                  //   itemBuilderPhysics: const ScrollPhysics(),
                  //   maxHeight: Dimens.twoHundred,
                  //   itemBuilder: (context, item, isSelected) {
                  //     return Visibility(
                  //       visible: item != "add",
                  //       replacement: Padding(
                  //         padding: Dimens.edgeInsets16,
                  //         child: Center(
                  //           child: AppText(
                  //             text: '+ Add kids',
                  //             maxLines: 1,
                  //             textAlign: TextAlign.center,
                  //             style: AppStyles.ubNavyBlue15W600,
                  //           ),
                  //         ),
                  //       ),
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         mainAxisSize: MainAxisSize.min,
                  //         children: [
                  //           Padding(
                  //             padding: Dimens.edgeInsetsH20V15,
                  //             child: Row(
                  //               mainAxisAlignment:
                  //                   MainAxisAlignment.spaceBetween,
                  //               children: [
                  //                 AppText(
                  //                   text: item.toString().tr,
                  //                   maxLines: 1,
                  //                   textAlign: TextAlign.start,
                  //                   style: AppStyles.ubNavyBlue15W600,
                  //                 ),
                  //                 // item == controller.selectedGender
                  //                 SvgPicture.asset(Assets.iconsCircleTick)
                  //                 //     : Dimens.box0,
                  //               ],
                  //             ),
                  //           ),
                  //           // item != controller.genderList.last
                  //           //     ? Dimens.boxHeight2
                  //           //     : Dimens.box0,
                  //           // item != controller.genderList.last
                  //           //     ?
                  //           Divider(
                  //             color: AppColors.dividerColor,
                  //             height: Dimens.two,
                  //           )
                  //           // : Dimens.box0,
                  //         ],
                  //       ),
                  //     );
                  //   },
                  // ),

                  Dimens.boxHeight16,
                  Container(
                    padding: Dimens.edgeInsets16,
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(Dimens.eight),
                      border: Border.all(
                        color: AppColors.dividerColor,
                        width: Dimens.one,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.lightNavyBlue.withOpacity(.8),
                          blurRadius: Dimens.five,
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: Dimens.twenty,
                          width: Dimens.twenty,
                          child: Checkbox(
                            value: controller.isReferral,
                            activeColor: AppColors.navyBlue,
                            onChanged: (value) {
                              controller.isReferral = value;
                              controller.update();
                            },
                            shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                Dimens.four,
                              ),
                              side: BorderSide(
                                color: AppColors.checkBoxBorderColor,
                                width: Dimens.one,
                              ),
                            ),
                            side: BorderSide(
                              color: AppColors.checkBoxBorderColor,
                              width: Dimens.one,
                            ),
                          ),
                        ),
                        Dimens.boxWidth8,
                        AppText(
                          text: TranslationKeys.useReferralBonus.tr,
                          style: AppStyles.ubGrey15W500,
                          maxLines: 1,
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                  Dimens.boxHeight16,

                  ///-------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> RECEIPT DATA ------------>>>>>>>>
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(Dimens.eight),
                      border: Border.all(
                        color: AppColors.dividerColor,
                        width: Dimens.one,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.lightNavyBlue.withOpacity(.8),
                          blurRadius: Dimens.five,
                        )
                      ],
                    ),
                    child: CustomBookingReceiptTile(
                      receiptHeader: 'Receipt',
                      shoBorder: false,
                      showHeader: false,
                      totalPriceReceived: controller.returnTotalPrice(
                        servicesListLength: controller.selectedServices.length,
                        totalMinutesPrice:
                            Utility.returnPriceAccordingToMinuetBasis(
                                childCount: controller.selectedChildList.length,
                                minuets: Utility.calculateTotalMinutesDifference(
                                    controller.startTime != null
                                        ? controller.startTime ??
                                            TimeOfDay.now()
                                        : Utility.convertDateTimeToTimeOfDay(
                                            controller
                                                    .singleDay
                                                    ?.data
                                                    ?.bookingDetail
                                                    ?.openingTime ??
                                                DateTime.now()),
                                    controller.endTime != null
                                        ? controller.endTime ?? TimeOfDay.now()
                                        : Utility.convertDateTimeToTimeOfDay(
                                            controller
                                                    .singleDay
                                                    ?.data
                                                    ?.bookingDetail
                                                    ?.closingTime ??
                                                DateTime.now()))),
                        isIncludeServicesFee: true,
                      ),
                      isReferralBonus: controller.isReferral ?? false,
                      childCount: controller.selectedChildList.length,
                      servicesList: controller.selectedServices,
                      netPayBalAmount: controller.isReferral == true
                          ? controller.totalPrice.value - 5
                          : 0.0,
                      serviceFees:
                          controller.returnServiceFeeAccordingToTotalPrice(
                        servicesListLength: controller.selectedServices.length,
                        totalMinutesPrice:
                            Utility.returnPriceAccordingToMinuetBasis(
                                childCount: controller.selectedChildList.length,
                                minuets: Utility.calculateTotalMinutesDifference(
                                    controller.startTime != null
                                        ? controller.startTime ??
                                            TimeOfDay.now()
                                        : Utility.convertDateTimeToTimeOfDay(
                                            controller
                                                    .singleDay
                                                    ?.data
                                                    ?.bookingDetail
                                                    ?.openingTime ??
                                                DateTime.now()),
                                    controller.endTime != null
                                        ? controller.endTime ?? TimeOfDay.now()
                                        : Utility.convertDateTimeToTimeOfDay(
                                            controller
                                                    .singleDay
                                                    ?.data
                                                    ?.bookingDetail
                                                    ?.closingTime ??
                                                DateTime.now()))),
                      ),
                      totalTimeHour: Utility.calculateTotalMinutesDifference(
                          controller.startTime != null
                              ? controller.startTime ?? TimeOfDay.now()
                              : Utility.convertDateTimeToTimeOfDay(controller
                                      .singleDay
                                      ?.data
                                      ?.bookingDetail
                                      ?.openingTime ??
                                  DateTime.now()),
                          controller.endTime != null
                              ? controller.endTime ?? TimeOfDay.now()
                              : Utility.convertDateTimeToTimeOfDay(controller
                                      .singleDay
                                      ?.data
                                      ?.bookingDetail
                                      ?.closingTime ??
                                  DateTime.now())),
                      totalTimeHourPrice:
                          Utility.returnPriceAccordingToMinuetBasis(
                              childCount: controller.selectedChildList.length,
                              minuets: Utility.calculateTotalMinutesDifference(
                                  controller.startTime != null
                                      ? controller.startTime ?? TimeOfDay.now()
                                      : Utility.convertDateTimeToTimeOfDay(
                                          controller
                                                  .singleDay
                                                  ?.data
                                                  ?.bookingDetail
                                                  ?.openingTime ??
                                              DateTime.now()),
                                  controller.endTime != null
                                      ? controller.endTime ?? TimeOfDay.now()
                                      : Utility.convertDateTimeToTimeOfDay(
                                          controller
                                                  .singleDay
                                                  ?.data
                                                  ?.bookingDetail
                                                  ?.closingTime ??
                                              DateTime.now()))),
                    ),
                  ),
                  Dimens.boxHeight16,
                  CustomButton(
                    title: TranslationKeys.confirmBooking.tr,
                    backGroundColor: AppColors.navyBlue,
                    onTap: () {
                      log('total Price:${controller.totalPrice}');

                      /// used to store opening  time with date.

                      DateTime startDate =
                          controller.returnFinalTimeAccordingToDate(
                              startTime: controller.startTime ??
                                  Utility.convertDateTimeToTimeOfDay(controller
                                          .singleDay
                                          ?.data
                                          ?.bookingDetail
                                          ?.openingTime ??
                                      DateTime.now()),
                              day: controller.singleDay?.data?.bookingDetail
                                      ?.openingTime ??
                                  DateTime.now());

                      /// used to store closing  time with date.
                      DateTime endDate =
                          controller.returnFinalTimeAccordingToDate(
                              startTime: controller.endTime ??
                                  Utility.convertDateTimeToTimeOfDay(controller
                                          .singleDay
                                          ?.data
                                          ?.bookingDetail
                                          ?.closingTime ??
                                      DateTime.now()),
                              day: controller.singleDay?.data?.bookingDetail
                                      ?.closingTime ??
                                  DateTime.now());

                      /// confirm booking api.
                      controller.confirmBookingApi(
                        hourlyPrice: Utility.returnPriceAccordingToMinuetBasis(
                            childCount: controller.selectedChildList.length,
                            minuets: Utility.calculateTotalMinutesDifference(
                                controller.startTime != null
                                    ? controller.startTime ?? TimeOfDay.now()
                                    : Utility.convertDateTimeToTimeOfDay(
                                        controller.singleDay?.data
                                                ?.bookingDetail?.openingTime ??
                                            DateTime.now()),
                                controller.endTime != null
                                    ? controller.endTime ?? TimeOfDay.now()
                                    : Utility.convertDateTimeToTimeOfDay(
                                        controller.singleDay?.data
                                                ?.bookingDetail?.closingTime ??
                                            DateTime.now()))),
                        isUseReferral: controller.isReferral ?? false,
                        nannyUserId: controller.nannyId.value,
                        totalMinutes: Utility.calculateTotalMinutesDifference(
                            controller.startTime != null
                                ? controller.startTime ?? TimeOfDay.now()
                                : Utility.convertDateTimeToTimeOfDay(controller
                                        .singleDay
                                        ?.data
                                        ?.bookingDetail
                                        ?.openingTime ??
                                    DateTime.now()),
                            controller.endTime != null
                                ? controller.endTime ?? TimeOfDay.now()
                                : Utility.convertDateTimeToTimeOfDay(controller
                                        .singleDay
                                        ?.data
                                        ?.bookingDetail
                                        ?.closingTime ??
                                    DateTime.now())),
                        totalPrice: controller.totalPrice.value,
                        childIds: controller.selectedChildIds,
                        openingTime: startDate,
                        closingTime: endDate,
                      );
                      // RouteManagement.goToAddPaymentMethodScreen(
                      //   isComeFromNannyProfile: true,
                      //   buttonText: TranslationKeys.submit.tr,
                      //   onTapButton: () {
                      //     RouteManagement.goToSuccessView(
                      //       buttonText: TranslationKeys.backToHome.tr,
                      //       successSvg: Assets.iconsSuccess,
                      //       header: TranslationKeys.nannyRequested.tr,
                      //       headerStyle: AppStyles.ubDarkBlackColor24W700,
                      //       subHeader:
                      //           TranslationKeys.notificationNannyAccept.tr,
                      //       onTapButton: () {
                      //         RouteManagement.goToOffAllDashboard(
                      //             isFromSetting: false);
                      //       },
                      //       subTitleStyle: AppStyles.ubGrey16W500,
                      //       subHeaderMaxLines: 2,
                      //       headerMaxLines: 2,
                      //       successImage: '',
                      //       sendTipText: false,
                      //     );
                      //   },
                      // );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      });
}
