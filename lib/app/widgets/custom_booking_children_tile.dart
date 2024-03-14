import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/models/booking_details_model.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_dot.dart';

import 'custom_dot_text.dart';

class CustomBookingChildrenTile extends StatelessWidget {
  const CustomBookingChildrenTile({
    super.key,
    required this.childrenHeader,
    required this.childrenDetailsList,
    required this.expansionCallback,
  });

  final String childrenHeader;
  final List<Child> childrenDetailsList;
  final Function(int index) expansionCallback;

  @override
  Widget build(BuildContext context) => Container(
        padding: Dimens.edgeInsets16,
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            Dimens.fourteen,
          ),
          border: Border.all(color: AppColors.navyBlue, width: Dimens.two),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              text: childrenHeader,
              style: AppStyles.ubBlack14W700,
              maxLines: 1,
              textAlign: TextAlign.start,
            ),
            Dimens.boxHeight10,
            ...List.generate(
              childrenDetailsList.length,
              (index) => GestureDetector(
                onTap: () {
                  expansionCallback(index);
                },
                child: Container(
                  margin: Dimens.edgeInsetsB10,
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: AppColors.listColor,
                    borderRadius: BorderRadius.circular(Dimens.ten),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppText(
                                  text: childrenDetailsList[index]
                                      .name
                                      .toString(),
                                  style: AppStyles.ubBlack14W700,
                                  maxLines: 2,
                                  textAlign: TextAlign.start,
                                ),
                                SvgPicture.asset(
                                    childrenDetailsList[index].isExpand == true
                                        ? Assets.iconsArrowUp
                                        : Assets.iconsArrowDown),
                              ],
                            ),
                            Dimens.boxHeight4,
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AppText(
                                  text:
                                      '${TranslationKeys.age.tr}: ${childrenDetailsList[index].age}',
                                  style: AppStyles.ubGrey12W500,
                                  maxLines: 1,
                                  textAlign: TextAlign.start,
                                ),
                                Dimens.boxWidth8,
                                CustomDot(
                                    size: Dimens.three,
                                    color: AppColors.blackColor),
                                Dimens.boxWidth8,
                                AppText(
                                  text: childrenDetailsList[index].gender == 1
                                      ? TranslationKeys.male.tr.capitalizeFirst
                                      : TranslationKeys
                                          .female.tr.capitalizeFirst,
                                  style: AppStyles.ubGrey12W500,
                                  maxLines: 1,
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: childrenDetailsList[index].isExpand ?? false,
                        child: Padding(
                          padding: Dimens.edgeInsets8,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (childrenDetailsList[index]
                                          .allergiesDietaryAndRestrictions
                                          ?.isNotEmpty ==
                                      true &&
                                  childrenDetailsList[index]
                                          .medicalCondition
                                          ?.isNotEmpty ==
                                      true) ...[
                                Dimens.boxHeight4,
                                Divider(
                                  height: Dimens.one,
                                  color: AppColors.hintColor,
                                ),
                                Dimens.boxHeight4,
                              ],
                              if (childrenDetailsList[index]
                                      .allergiesDietaryAndRestrictions
                                      ?.isNotEmpty ==
                                  true) ...[
                                CustomDotText(
                                  heading: "Allergies/Dietary Restrictions",
                                  description: childrenDetailsList[index]
                                      .allergiesDietaryAndRestrictions
                                      .toString(),
                                  headingStyle: AppStyles.ubBlack12W600,
                                ),
                              ],
                              if (childrenDetailsList[index]
                                      .medicalCondition
                                      ?.isNotEmpty ==
                                  true)
                                CustomDotText(
                                  heading: TranslationKeys.medicalCondition.tr,
                                  description: childrenDetailsList[index]
                                      .medicalCondition
                                      .toString(),
                                  headingStyle: AppStyles.ubBlack12W600,
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
