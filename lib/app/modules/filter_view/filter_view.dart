import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/controllers/filter/filter_controller.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_app_bar.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_drop_down.dart';

import 'package:syncfusion_flutter_sliders/sliders.dart';

class FilterView extends StatelessWidget {
  const FilterView({super.key});

  @override
  Widget build(BuildContext context) => GetBuilder<FilterController>(
        builder: (controller) {
          return Scaffold(
            appBar: CustomAppbarWidget(
              title: TranslationKeys.filters.tr,
            ),
            body: SafeArea(
              child: Padding(
                padding: Dimens.edgeInsets16,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Dimens.boxHeight16,
                    AppText(
                      text: TranslationKeys.distance.tr,
                      style: AppStyles.ubBlack16W700,
                      maxLines: 1,
                      textAlign: TextAlign.start,
                    ),
                    Dimens.boxHeight10,
                    SfRangeSlider(
                      min: Dimens.zero,
                      max: Dimens.ten,
                      values: controller.distanceSliderValues,
                      activeColor: AppColors.sliderActiveColor,
                      inactiveColor: AppColors.sliderInActiveColor,
                      stepSize: Dimens.two,
                      startThumbIcon: SvgPicture.asset(
                        Assets.iconsSliderThumb,
                      ),
                      endThumbIcon: SvgPicture.asset(
                        Assets.iconsSliderThumb,
                      ),
                      // enableTooltip: true,
                      onChanged: (SfRangeValues values) {
                        controller.distanceSliderValues = values;
                        controller.update();
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                          text:
                              '${double.parse(controller.distanceSliderValues.start.toString()).toInt().toString()} miles',
                          style: AppStyles.ubGrey14W600,
                          maxLines: 1,
                        ),
                        AppText(
                          text:
                              '${double.parse(controller.distanceSliderValues.end.toString()).toInt().toString()} miles',
                          style: AppStyles.ubGrey14W600,
                          maxLines: 1,
                        ),
                      ],
                    ),
                    Dimens.boxHeight16,
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
                    Dimens.boxHeight10,
                    SfRangeSlider(
                      max: Dimens.fifty,
                      min: Dimens.thirteen,
                      interval: 10,
                      values: controller.ageSliderValues,
                      onChanged: (value) {
                        controller.ageSliderValues = value;
                        controller.update();
                      },
                    ),
                    Dimens.boxHeight16,
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
