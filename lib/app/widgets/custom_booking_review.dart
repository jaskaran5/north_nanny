import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';

import '../res/constants/assets.dart';
import '../res/theme/colors.dart';
import '../res/theme/dimens.dart';
import 'custom_rating_tile.dart';

class CustomBookingReview extends StatelessWidget {
  const CustomBookingReview({super.key, required this.reviewsList});
  final List<String> reviewsList;

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
                    reviewDate: '01/03/204',
                    userImage: Assets.iconsImage,
                    userName: reviewsList[index].toString(),
                    ratingDescription:
                        'It has been an absolute joy caring for [Child\'s Name] during my time with your family. I want to express my gratitude for the trust you placed in me.',
                    totalRating: 4.5,
                    personRating: 4.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
