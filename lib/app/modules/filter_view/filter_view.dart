import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/controllers/filter/filter_controller.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_app_bar.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_button.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_drop_down.dart';

class FilterView extends StatelessWidget {
  const FilterView({super.key});

  @override
  Widget build(BuildContext context) => GetBuilder<FilterController>(
        builder: (controller) {
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
                  CustomButton(
                    height: Dimens.fiftyThree,
                    width: Dimens.oneHundredFifty,
                    borderRadius: Dimens.twelve,
                    title: TranslationKeys.reset.tr,
                    backGroundColor: AppColors.lightNavyBlue,
                    textColor: AppColors.navyBlue,
                  ),
                  CustomButton(
                    height: Dimens.fiftyThree,
                    width: Dimens.oneHundredFifty,
                    borderRadius: Dimens.twelve,
                    title: TranslationKeys.apply.tr,
                    backGroundColor: AppColors.navyBlue,
                  ),
                ],
              ),
            ),
            body: SafeArea(
              child: Padding(
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
                    FlutterSlider(
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
                      max: Dimens.ten,
                      axis: Axis.horizontal,
                      onDragging: (handlerIndex, lowerValue, upperValue) {
                        controller.distanceHigherValue = upperValue;
                        controller.distanceLowerValue = lowerValue;
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                      min: Dimens.thirteen,
                      max: Dimens.fifty,
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
                            text: double.parse(value.toString())
                                .toInt()
                                .toString(),
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
                    AppText(
                      text: TranslationKeys.dateAndTime.tr,
                      style: AppStyles.ubBlack16W700,
                      maxLines: 1,
                    ),
                    Dimens.boxHeight10,
                    const Row(),
                  ],
                ),
              ),
            ),
          );
        },
      );
}
