import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/models/nanny_profile_model.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';
import '../res/theme/colors.dart';
import '../res/theme/dimens.dart';
import 'custom_rating_tile.dart';

class CustomBookingReview extends StatelessWidget {
  const CustomBookingReview({super.key, required this.reviewsList});
  final List<RatingList?> reviewsList;

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
              text: TranslationKeys.reviews.capitalizeFirst.toString().tr,
              style: AppStyles.ubBlack14W700,
              maxLines: 1,
              textAlign: TextAlign.start,
            ),
            Dimens.boxHeight10,
            ListView(
              shrinkWrap: true,
              children: List.generate(
                reviewsList.length,
                (index) => Padding(
                  padding: Dimens.edgeInsetsB16,
                  child: CustomRatingTile(
                    reviewDate: reviewsList[index]?.datetime.toString(),
                    userImage: reviewsList[index]?.image,
                    userName: reviewsList[index]?.name,
                    ratingDescription: reviewsList[index]?.review,
                    totalRating: reviewsList[index]?.rating,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
