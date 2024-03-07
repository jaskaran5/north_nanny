import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_child_age_gender_tile.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_dot_text.dart';

class CustomChildProfileTile extends StatelessWidget {
  final void Function()? onTap;
  final String childIdl;
  final String childName;
  final dynamic childAge;
  final dynamic childGender;
  final String allergies;
  final String medicalCondition;
  final String aboutChild;

  const CustomChildProfileTile({
    super.key,
    required this.onTap,
    required this.childIdl,
    required this.childName,
    required this.childAge,
    required this.childGender,
    required this.allergies,
    required this.medicalCondition,
    required this.aboutChild,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: Dimens.edgeInsetsB16,
      padding: Dimens.edgeInsets10,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(
          Dimens.fourteen,
        ),
        boxShadow: [
          BoxShadow(
              color: AppColors.blackColor.withOpacity(.058),
              blurRadius: Dimens.ten)
        ],
      ),
      width: Get.width,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: Dimens.edgeInsetsL6,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppText(
                        text: childName,
                        style: AppStyles.ubBlack16W700,
                        maxLines: 1,
                        textAlign: TextAlign.start,
                      ),
                      Dimens.boxHeight8,
                      CustomChildAgeGenderTile(
                        age: childAge,
                        gender: childGender != null
                            ? childGender.toString() == "1"
                                ? "Male"
                                : childGender.toString() == "2"
                                    ? "Female"
                                    : ''
                            : '',
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: onTap,
                    child: SvgPicture.asset(
                      Assets.iconsEditChild,
                      height: Dimens.thirty,
                      width: Dimens.thirty,
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: SizedBox(
                width: Get.width / 1.2,
                child: const Divider(
                  color: AppColors.dividerColor,
                  thickness: 0.5,
                ),
              ),
            ),
            CustomDotText(
                heading: "Allergies/Dietary Restrictions",
                description: allergies),
            CustomDotText(
                heading: "Medical Conditions", description: medicalCondition),
            CustomDotText(heading: "Anything else?", description: aboutChild),
          ],
        ),
      ),
    );
  }
}
