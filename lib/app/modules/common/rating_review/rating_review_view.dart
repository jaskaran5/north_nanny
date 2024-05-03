import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/res/constants/string_contants.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_app_bar.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_button.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_rating_profile_tile.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_write_review_tile.dart';

import '../../../widgets/custom_rate_view.dart';
import '../rating_and_review/rating_and_review_controller.dart';

class RatingReviewView extends StatelessWidget {
  const RatingReviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RatingAndReviewController>(
      init: RatingAndReviewController(),
      builder: (controller) => Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: const CustomAppbarWidget(),
        body: Padding(
          padding: Dimens.edgeInsets16,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: "Rating And Review",
                  style: AppStyles.pdSemiBoldBlack24,
                  textAlign: TextAlign.start,
                ),
                Dimens.boxHeight10,
                AppText(
                  text:
                      "How was your experience with this ${controller.logInType == StringConstants.customer ? 'this sitter' : 'this family'}?",
                  style: AppStyles.ubGrey16W400,
                ),
                Dimens.boxHeight16,
                //=====//
                /** PROFILE section */
                CustomRatingProfileTile(
                  image: controller.userImage ?? '',
                  name: '${controller.userName ?? ' '}${controller.gender}',
                  rating: controller.totalRating ?? 0.0,
                  totalReviews: controller.totalReview ?? 0,
                ),
                Dimens.boxHeight16,

                /** RATING section */

                SizedBox(
                  width: Get.width,
                  child: CustomGiveRate(
                    onRatingUpdate: controller.onRatingUpdate,
                    initialRating: controller.givingRating,
                    logInType: controller.logInType ?? '',
                  ),
                ),
                Dimens.boxHeight16,

                /** REVIEW section */

                SizedBox(
                  width: Get.width,
                  child: CustomWriteReviewTile(
                    writeAReviewController: controller.writeAReviewController,
                    logInType: controller.logInType ?? '',
                  ),
                ),
                // const Spacer(),
              ],
            ),
          ),
        ),
        floatingActionButton: CustomButton(
          title: TranslationKeys.submit.tr,
          backGroundColor: AppColors.navyBlue,
          textColor: AppColors.primaryColor,
          onTap: () {
            controller.ratingReviewValidator(
                rating: controller.givingRating,
                message: controller.writeAReviewController.text);
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
