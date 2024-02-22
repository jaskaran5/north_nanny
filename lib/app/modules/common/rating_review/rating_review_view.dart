import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_app_bar.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_button.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_rating_profile_tile.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_write_review_tile.dart';

class RatingReviewView extends StatelessWidget {
  const RatingReviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const CustomAppbarWidget(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: AppText(
                text: "Rating And Review",
                style: AppStyles.pdSemiBoldBlack24,
                textAlign: TextAlign.start,
              ),
            ),
            AppText(
              text: "How was your experience with this family?",
              style: AppStyles.ubGrey16W400,
            ),
            Dimens.boxHeight14,
            //=====//
            /** PROFILE section */
            const CustomRatingProfileTile(),
            Dimens.boxHeight14,

            /** RATING section */

            // SizedBox(width: Get.width, child: const CustomRatingTile()),
            Dimens.boxHeight14,

            /** REVIEW section */

            SizedBox(width: Get.width, child: const CustomWriteReviewTile()),
            // const Spacer(),
          ]),
        ),
      ),
      floatingActionButton: CustomButton(
        title: TranslationKeys.submit.tr,
        backGroundColor: AppColors.navyBlue,
        textColor: AppColors.primaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
