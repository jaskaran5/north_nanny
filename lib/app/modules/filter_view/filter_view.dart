import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/customer/home/customer_home_controller.dart';
import 'package:northshore_nanny_flutter/app/utils/utility.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../res/constants/assets.dart';
import '../../res/theme/colors.dart';
import '../../res/theme/dimens.dart';
import '../../res/theme/styles.dart';
import '../../utils/translations/translation_keys.dart';
import '../../widgets/app_text.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_drop_down.dart';
import '../../widgets/library/flutter_time_picker_spinner.dart';

class FilterView extends StatelessWidget {
  const FilterView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: GetBuilder(
        builder: (CustomerHomeController controller) {
          return Scaffold(
            appBar: CustomAppbarWidget(
              title: TranslationKeys.filters.tr,
            ),
            bottomSheet: Container(
              color: AppColors.primaryColor,
              padding: Dimens.edgeInsets16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /**-------->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>------>>>>>> RESET BUTTON */
                  CustomButton(
                    onTap: () {
                      controller.onClickOnFilterApply(isResetFilters: true);
                      controller.resetFilters();
                    },
                    height: Dimens.fiftyThree,
                    width: Dimens.oneHundredFifty,
                    borderRadius: Dimens.twelve,
                    title: TranslationKeys.reset.tr,
                    backGroundColor: AppColors.lightNavyBlue,
                    textColor: AppColors.navyBlue,
                  ),
                  /**--------->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>----->>>>>> APPLY BUTTON */

                  CustomButton(
                    onTap: () {
                      controller.onClickOnFilterApply(isResetFilters: false);
                    },
                    height: Dimens.fiftyThree,
                    width: Dimens.oneHundredFifty,
                    borderRadius: Dimens.twelve,
                    title: TranslationKeys.apply.tr,
                    backGroundColor: AppColors.navyBlue,
                  ),
                ],
              ),
            ),
            body: Padding(
              padding: Dimens.edgeInsets16,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Dimens.boxHeight10,
                  AppText(
                    text: TranslationKeys.distance.tr,
                    style: AppStyles.ubBlack16W700,
                    maxLines: 1,
                    textAlign: TextAlign.start,
                  ),
                  Dimens.boxHeight4,
                  /**DISTANCE slider */
                  FlutterSlider(
                    minimumDistance: 0.0,
                    maximumDistance: 25.0,
                    handler: FlutterSliderHandler(
                      child: SvgPicture.asset(Assets.iconsSliderThumb),
                    ),
                    handlerHeight: Dimens.twentyFour,
                    handlerWidth: Dimens.twentyFour,
                    rightHandler: FlutterSliderHandler(
                      child: SvgPicture.asset(Assets.iconsSliderThumb),
                    ),
                    step: const FlutterSliderStep(
                      isPercentRange: false,
                    ),
                    values: [
                      controller.distanceLowerValue,
                      controller.distanceHigherValue,
                    ],
                    rangeSlider: true,
                    min: Dimens.zero,
                    max: 25,
                    axis: Axis.horizontal,
                    onDragging: (handlerIndex, lowerValue, upperValue) {
                      log("handlerIndex:-->> $handlerIndex");
                      log("lower:-->> $lowerValue");
                      log("upperValue:-->> $upperValue");

                      if (handlerIndex == 0) {
                        controller.distanceLowerValue = lowerValue;
                      } else {
                        controller.distanceHigherValue = upperValue;
                      }
                      controller.update();
                    },
                    handlerAnimation: FlutterSliderHandlerAnimation(
                      scale: Dimens.one,
                      duration: Duration.zero,
                    ),
                    tooltip: FlutterSliderTooltip(
                      positionOffset: FlutterSliderTooltipPositionOffset(
                        top: Dimens.fortySix,
                      ),
                      textStyle: AppStyles.ubGrey14W600,
                      custom: (value) => AppText(
                        text:
                            '${double.parse(value.toString()).toInt().toString()} miles',
                        style: AppStyles.ubGrey14W600,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                      ),
                      alwaysShowTooltip: true,
                    ),
                    trackBar: FlutterSliderTrackBar(
                      activeTrackBar: BoxDecoration(
                          color: AppColors.sliderActiveColor,
                          borderRadius: BorderRadius.circular(
                            Dimens.eight,
                          )),
                      activeTrackBarHeight: Dimens.five,
                      inactiveTrackBar: BoxDecoration(
                          color: AppColors.sliderInActiveColor,
                          borderRadius: BorderRadius.circular(
                            Dimens.eight,
                          )),
                      inactiveTrackBarHeight: Dimens.five,
                    ),
                  ),
                  // FlutterSlider(
                  //   handler: FlutterSliderHandler(
                  //     child: SvgPicture.asset(Assets.iconsSliderThumb),
                  //   ),
                  //   handlerHeight: Dimens.twentyFour,
                  //   handlerWidth: Dimens.twentyFour,
                  //   rightHandler: FlutterSliderHandler(
                  //     child: SvgPicture.asset(Assets.iconsSliderThumb),
                  //   ),
                  //   step: const FlutterSliderStep(
                  //     isPercentRange: false,
                  //   ),
                  //   values: [
                  //     controller.distanceLowerValue,
                  //     controller.distanceHigherValue,
                  //   ],
                  //   rangeSlider: true,
                  //   min: Dimens.zero,
                  //   max: Dimens.ten,
                  //   axis: Axis.horizontal,
                  //   onDragging: (handlerIndex, lowerValue, upperValue) {
                  //     if (handlerIndex == 0) {
                  //       controller.ageLowerValue = lowerValue;
                  //     } else {
                  //       controller.ageHigherValue = upperValue;
                  //     }
                  //     controller.update();
                  //   },
                  //   // onDragging: (handlerIndex, lowerValue, upperValue) {
                  //   //   controller.distanceHigherValue = upperValue;
                  //   //   controller.distanceLowerValue = lowerValue;
                  //   //   controller.update();
                  //   // },
                  //   handlerAnimation: FlutterSliderHandlerAnimation(
                  //     scale: Dimens.one,
                  //     duration: Duration.zero,
                  //   ),
                  //   tooltip: FlutterSliderTooltip(
                  //     positionOffset: FlutterSliderTooltipPositionOffset(
                  //       top: Dimens.fortySix,
                  //     ),
                  //     textStyle: AppStyles.ubGrey14W600,
                  //     custom: (value) => AppText(
                  //       text:
                  //           '${double.parse(value.toString()).toInt().toString()} miles',
                  //       style: AppStyles.ubGrey14W600,
                  //       textAlign: TextAlign.center,
                  //       maxLines: 1,
                  //     ),
                  //     alwaysShowTooltip: true,
                  //   ),
                  //   trackBar: FlutterSliderTrackBar(
                  //     activeTrackBar: BoxDecoration(
                  //         color: AppColors.sliderActiveColor,
                  //         borderRadius: BorderRadius.circular(
                  //           Dimens.eight,
                  //         )),
                  //     activeTrackBarHeight: Dimens.five,
                  //     inactiveTrackBar: BoxDecoration(
                  //         color: AppColors.sliderInActiveColor,
                  //         borderRadius: BorderRadius.circular(
                  //           Dimens.eight,
                  //         )),
                  //     inactiveTrackBarHeight: Dimens.five,
                  //   ),
                  // ),

                  Dimens.boxHeight26,
                  AppText(
                    text:
                        "${TranslationKeys.gender.tr.capitalizeFirst} (${TranslationKeys.optional.tr})",
                    style: AppStyles.ubBlack16W700,
                    maxLines: 1,
                    textAlign: TextAlign.start,
                  ),
                  Dimens.boxHeight10,
                  AppDropdown(
                    selectedItem: controller.selectedGender?.isEmpty == true
                        ? '${TranslationKeys.gender.tr} '
                        : controller.selectedGender,
                    onChanged: (value) {
                      controller.selectedGender = value.toString();
                      controller.update();

                      log("selected gender:-->> ${controller.selectedGender}");
                    },
                    baseTextStyle: controller.selectedGender?.isEmpty == true
                        ? AppStyles.ubHintColor15W500
                        : null,
                    prefix: SvgPicture.asset(Assets.iconsGender),
                    items: controller.genderList,
                    itemBuilder: (context, item, isSelected) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: Dimens.edgeInsetsH20V15,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppText(
                                  text: item.toString().tr,
                                  maxLines: 1,
                                  textAlign: TextAlign.start,
                                  style: AppStyles.ubNavyBlue15W600,
                                ),
                                item == controller.selectedGender
                                    ? SvgPicture.asset(Assets.iconsCircleTick)
                                    : Dimens.box0,
                              ],
                            ),
                          ),
                          item != controller.genderList.last
                              ? Dimens.boxHeight2
                              : Dimens.box0,
                          item != controller.genderList.last
                              ? Divider(
                                  color: AppColors.dividerColor,
                                  height: Dimens.two,
                                )
                              : Dimens.box0,
                        ],
                      );
                    },
                  ),
                  Dimens.boxHeight16,
                  RichText(
                    text: TextSpan(
                      text: TranslationKeys.age.tr,
                      style: AppStyles.ubBlack16W700,
                      children: [
                        TextSpan(
                          text: ' (13-50)',
                          style: AppStyles.ubGrey16W500,
                        )
                      ],
                    ),
                    maxLines: 1,
                    textAlign: TextAlign.start,
                  ),
                  Dimens.boxHeight4,

                  /** AGE S;ECEUYDSIBADSB  */
                  FlutterSlider(
                    handler: FlutterSliderHandler(
                      child: SvgPicture.asset(Assets.iconsSliderThumb),
                    ),
                    handlerHeight: Dimens.twentyFour,
                    handlerWidth: Dimens.twentyFour,
                    rightHandler: FlutterSliderHandler(
                      child: SvgPicture.asset(Assets.iconsSliderThumb),
                    ),
                    jump: true,
                    step: const FlutterSliderStep(
                      isPercentRange: false,
                    ),
                    values: [
                      controller.ageLowerValue,
                      controller.ageHigherValue,
                    ],
                    rangeSlider: true,
                    min: 13,
                    max: 50,
                    axis: Axis.horizontal,
                    onDragging: (handlerIndex, lowerValue, upperValue) {
                      controller.ageHigherValue = upperValue;
                      controller.ageLowerValue = lowerValue;
                      controller.update();
                    },
                    handlerAnimation: FlutterSliderHandlerAnimation(
                      scale: Dimens.one,
                      duration: Duration.zero,
                    ),
                    tooltip: FlutterSliderTooltip(
                      positionOffset: FlutterSliderTooltipPositionOffset(
                        top: Dimens.fortySix,
                      ),
                      textStyle: AppStyles.ubGrey14W600,
                      custom: (value) => Padding(
                        padding: Dimens.edgeInsetsL16R16,
                        child: AppText(
                          text:
                              double.parse(value.toString()).toInt().toString(),
                          style: AppStyles.ubGrey14W600,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                        ),
                      ),
                      alwaysShowTooltip: true,
                    ),
                    trackBar: FlutterSliderTrackBar(
                      activeTrackBar: BoxDecoration(
                          color: AppColors.sliderActiveColor,
                          borderRadius: BorderRadius.circular(
                            Dimens.eight,
                          )),
                      activeTrackBarHeight: Dimens.five,
                      inactiveTrackBar: BoxDecoration(
                          color: AppColors.sliderInActiveColor,
                          borderRadius: BorderRadius.circular(
                            Dimens.eight,
                          )),
                      inactiveTrackBarHeight: Dimens.five,
                    ),
                  ),

                  Dimens.boxHeight26,

                  /** Date and time **/
                  AppText(
                    text: TranslationKeys.dateAndTime.tr,
                    style: AppStyles.ubBlack16W700,
                    maxLines: 1,
                  ),
                  Dimens.boxHeight10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await Get.dialog(
                            Center(
                              child: Padding(
                                padding: Dimens.edgeInsetsL16R16,
                                child: Material(
                                  color: Colors.transparent,
                                  borderRadius:
                                      BorderRadius.circular(Dimens.twenty),
                                  child: Container(
                                    alignment: Alignment.center,
                                    constraints: BoxConstraints(
                                      maxHeight: Dimens.fourHundredEighty,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius:
                                          BorderRadius.circular(Dimens.twenty),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: Dimens.edgeInsets10,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              AppText(
                                                text: TranslationKeys
                                                    .selectDate.tr,
                                                style: AppStyles.ubBlack16W700,
                                                maxLines: 1,
                                              ),
                                              InkWell(
                                                hoverColor: Colors.transparent,
                                                onTap: () {
                                                  Get.back();
                                                },
                                                child: SvgPicture.asset(
                                                  Assets.iconsRemove,
                                                  colorFilter:
                                                      const ColorFilter.mode(
                                                    AppColors.blackColor,
                                                    BlendMode.srcIn,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          height: Dimens.one,
                                          color: AppColors.dividerColor,
                                        ),
                                        Padding(
                                          padding: Dimens.edgeInsetsL16R16,
                                          child: GetBuilder<
                                              CustomerHomeController>(
                                            builder: (filterController) {
                                              return TableCalendar(
                                                sixWeekMonthsEnforced: true,
                                                startingDayOfWeek:
                                                    StartingDayOfWeek.monday,
                                                daysOfWeekStyle:
                                                    DaysOfWeekStyle(
                                                  weekdayStyle: AppStyles
                                                      .ubHintColor13W500,
                                                  weekendStyle: AppStyles
                                                      .ubHintColor13W500,
                                                ),
                                                calendarStyle: CalendarStyle(
                                                  defaultTextStyle:
                                                      AppStyles.ubBlack15W600,
                                                  weekendTextStyle:
                                                      AppStyles.ubBlack15W600,
                                                  outsideTextStyle: AppStyles
                                                      .ubHintColor15W500,
                                                  todayDecoration:
                                                      const BoxDecoration(
                                                    color: AppColors.navyBlue,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  todayTextStyle:
                                                      AppStyles.ubWhite15700,
                                                  selectedTextStyle:
                                                      AppStyles.ubWhite15700,
                                                  selectedDecoration:
                                                      const BoxDecoration(
                                                    color: AppColors.navyBlue,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  isTodayHighlighted: false,
                                                  markersMaxCount: 1,
                                                ),
                                                firstDay: DateTime.now(),
                                                lastDay: DateTime.utc(
                                                  DateTime.now().year + 5,
                                                ),
                                                headerStyle: HeaderStyle(
                                                  titleCentered: true,
                                                  titleTextStyle:
                                                      AppStyles.ubBlack18W600,
                                                  formatButtonVisible: false,
                                                ),
                                                selectedDayPredicate: (day) =>
                                                    day ==
                                                    controller.selectedDate,
                                                onDaySelected:
                                                    (selectedDay, focusedDay) {
                                                  log("on data select:-->.$selectedDay");
                                                  filterController
                                                          .selectedDate =
                                                      selectedDay;
                                                  filterController.update();
                                                },
                                                focusedDay: filterController
                                                    .selectedDate,
                                              );
                                            },
                                          ),
                                        ),

                                        /**apply */
                                        Padding(
                                          padding: Dimens.edgeInsetsL16R16,
                                          child: CustomButton(
                                            title: TranslationKeys.apply.tr,
                                            backGroundColor: AppColors.navyBlue,
                                            onTap: () {
                                              Get.back();
                                              // controller
                                              //     .onClickOnFilterApply();
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            useSafeArea: true,
                          );
                        },
                        child: Container(
                          height: Dimens.fifty,
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
                                Assets.iconsCalendar,
                                height: Dimens.twenty,
                                width: Dimens.twenty,
                              ),
                              Dimens.boxWidth10,
                              AppText(
                                text:
                                    '${controller.selectedDate.month.toString().padLeft(2, '0')}/${controller.selectedDate.day.toString().padLeft(2, '0')}/${controller.selectedDate.year}',
                                style: AppStyles.ubHintColor15W500,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ),
                      ),

                      //** SELECT TIME */
                      GestureDetector(
                        onTap: () {
                          Get.dialog(
                            Padding(
                              padding: Dimens.edgeInsetsL16R16,
                              child: Material(
                                color: Colors.transparent,
                                borderRadius:
                                    BorderRadius.circular(Dimens.twenty),
                                child: Center(
                                  child: Container(
                                    alignment: Alignment.center,
                                    constraints: BoxConstraints(
                                      maxHeight: Dimens.twoHundredNinety,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius:
                                          BorderRadius.circular(Dimens.twenty),
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: Dimens.edgeInsets10,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              AppText(
                                                text: TranslationKeys
                                                    .selectTime.tr,
                                                style: AppStyles.ubBlack16W700,
                                                maxLines: 1,
                                              ),
                                              InkWell(
                                                hoverColor: Colors.transparent,
                                                onTap: () {
                                                  Get.back();
                                                },
                                                child: SvgPicture.asset(
                                                  Assets.iconsRemove,
                                                  colorFilter:
                                                      const ColorFilter.mode(
                                                    AppColors.blackColor,
                                                    BlendMode.srcIn,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          height: Dimens.one,
                                          color: AppColors.dividerColor,
                                        ),
                                        Padding(
                                          padding: Dimens.edgeInsetsL16R16,
                                          child: TimePickerSpinner(
                                            is24HourMode: false,
                                            isForce2Digits: true,
                                            highlightedTextStyle:
                                                AppStyles.ubNavyBlue20W600,
                                            normalTextStyle:
                                                AppStyles.ubHintColor20W500,
                                            itemHeight: Dimens.sixty,
                                            onTimeChange: (time) {
                                              log("on time select :-->> $time");
                                              controller.selectedTime = time;
                                              controller.update();
                                            },
                                            time: controller.selectedTime,
                                          ),
                                        ),
                                        Dimens.boxHeight10,
                                        CustomButton(
                                          height: Dimens.fortySix,
                                          width: Dimens.twoHundredNinety,
                                          title: TranslationKeys.apply.tr,
                                          titleStyle: AppStyles.ubWhite14700,
                                          backGroundColor: AppColors.navyBlue,
                                          onTap: () {
                                            Get.back();
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: Dimens.fifty,
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
                                text: Utility.formatTimeTo12Hour(
                                    controller.selectedTime.toUtc().toString()),
                                // '${controller.selectedTime.hour.toString().padLeft(2, '0')}:${controller.selectedTime.minute.toString().padLeft(2, '0')} ${controller.selectedTime.hour > 12 ? 'PM' : 'AM'} ',
                                style: AppStyles.ubHintColor15W500,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
