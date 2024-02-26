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
  const CustomChildProfileTile({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Dimens.edgeInsets10,
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(
              Dimens.fourteen,
            )),
        width: Get.width,
        child: Padding(
          padding: Dimens.edgeInsets12,
          child: Center(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          text: "Alexander",
                          style: AppStyles.ubDarkBlackColor16W700,
                        ),

                        const CustomChildAgeGenderTile(
                          age: "7",
                          gender: "Male",
                        )
                        // const Row(
                        //   children: [
                        //     AppText(text: "NAME"),
                        //     AppText(text: "NAME"),
                        //   ],
                        // ),
                      ],
                    ),
                    GestureDetector(
                      onTap: onTap,
                      child: SvgPicture.asset(
                        Assets.iconsCard,
                        height: Dimens.thirty,
                        width: Dimens.thirty,
                      ),
                    ),
                  ],
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
                const CustomDotText(
                    heading: "Allergies/Dietary Restrictions",
                    description: "Wheat, Eggs, Tree nuts"),
                const CustomDotText(
                    heading: "Medical Conditions", description: "Chickenpox"),
                const CustomDotText(
                    heading: "Anything else?",
                    description:
                        "Enthusiastic and imaginative child with a love for learning and creativity. Curious explorer who enjoys discovering new things and making friends. Eager participant ready to embark on exciting adventures in education and play."),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
