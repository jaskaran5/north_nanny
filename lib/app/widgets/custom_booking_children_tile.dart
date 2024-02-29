import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    required this.isExpand,
    required this.expansionCallback,
  });

  final String childrenHeader;
  final List<String> childrenDetailsList;
  final bool isExpand;
  final Function(int panelIndex, bool isExpand) expansionCallback;

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
              (index) => Container(
                margin: Dimens.edgeInsetsB10,
                decoration: BoxDecoration(
                  color: AppColors.listColor,
                  borderRadius: BorderRadius.circular(Dimens.ten),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(Dimens.ten),
                  child: ExpansionPanelList(
                    children: [
                      ExpansionPanel(
                        headerBuilder: (context, isExpanded) {
                          return Padding(
                            padding: Dimens.edgeInsets16,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  text: childrenDetailsList[index].toString(),
                                  style: AppStyles.ubBlack14W700,
                                  maxLines: 1,
                                  textAlign: TextAlign.start,
                                ),
                                Dimens.boxHeight4,
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    AppText(
                                      text: 'Age 7 ',
                                      style: AppStyles.ubGrey12W500,
                                      maxLines: 1,
                                      textAlign: TextAlign.start,
                                    ),
                                    Dimens.boxWidth2,
                                    CustomDot(
                                        size: Dimens.three,
                                        color: AppColors.blackColor),
                                    Dimens.boxWidth2,
                                    AppText(
                                      text: ' Male ',
                                      style: AppStyles.ubGrey12W500,
                                      maxLines: 1,
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                        body: Padding(
                          padding: Dimens.edgeInsets8,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Divider(
                                height: Dimens.one,
                                color: AppColors.hintColor,
                              ),
                              CustomDotText(
                                heading: "Allergies/Dietary Restrictions",
                                description: "Wheat, Eggs, Tree nuts ",
                                headingStyle: AppStyles.ubBlack12W600,
                              ),
                              CustomDotText(
                                heading: TranslationKeys.medicalCondition.tr,
                                description: "Chickenpox",
                                headingStyle: AppStyles.ubBlack12W600,
                              ),
                            ],
                          ),
                        ),
                        isExpanded: isExpand,
                        backgroundColor: AppColors.listColor,
                        canTapOnHeader: true,
                      ),
                    ],
                    dividerColor: AppColors.dividerColor,
                    expansionCallback: expansionCallback,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
