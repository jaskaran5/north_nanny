import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/models/nanny_profile_model.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_rating_tile.dart';

class CustomReviewBottomSheet extends StatelessWidget {
  const CustomReviewBottomSheet(
      {super.key,
      required this.totalReviews,
      required this.totalReviewsRating,
      required this.reviewsList});
  final int totalReviews;
  final double totalReviewsRating;
  final List<RatingList> reviewsList;

  @override
  Widget build(BuildContext context) => Container(
        height: Dimens.fiveHundred,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimens.twenty),
            topRight: Radius.circular(Dimens.twenty),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: Dimens.edgeInsets16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    text:
                        '${TranslationKeys.reviews.capitalizeFirst.toString().tr} ($totalReviews) ',
                    style: AppStyles.ubBlack16W700,
                    textAlign: TextAlign.start,
                    maxLines: 1,
                  ),
                  GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: SvgPicture.asset(Assets.iconsRemoveBottomSheet)),
                ],
              ),
            ),
            Dimens.boxHeight10,
            Divider(
              color: AppColors.dividerColor,
              height: Dimens.one,
            ),
            if (reviewsList.isEmpty) ...[
              Dimens.boxHeight20,
              Center(
                child: AppText(
                  text: TranslationKeys.noResultFound.tr,
                  style: AppStyles.pdNavyBlue20W600,
                ),
              ),
            ],
            if (reviewsList.isNotEmpty) ...[
              Container(
                margin: Dimens.edgeInsets16,
                padding: Dimens.edgeInsets10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimens.eight),
                  border: Border.all(
                    color: AppColors.dividerColor,
                    width: Dimens.one,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RatingBar(
                          ratingWidget: RatingWidget(
                            full: SvgPicture.asset(Assets.iconsFullRating),
                            half: SvgPicture.asset(Assets.iconsHalfRating),
                            empty: SvgPicture.asset(Assets.iconsNoRating),
                          ),
                          onRatingUpdate: (value) {},
                          allowHalfRating: true,
                          initialRating: totalReviewsRating,
                          itemPadding: Dimens.edgeInsets4,
                          itemSize: Dimens.eighteen,
                        ),
                        Dimens.boxHeight8,
                        AppText(
                          text:
                              '($totalReviews ${TranslationKeys.reviews.tr}) ',
                          style: AppStyles.ubGrey12W400,
                          textAlign: TextAlign.start,
                          maxLines: 1,
                        ),
                      ],
                    ),
                    AppText(
                      text: totalReviewsRating == 0.0
                          ? '0'
                          : totalReviewsRating.toString(),
                      style: AppStyles.ubNavyBlue30W600,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  children: List.generate(
                    reviewsList.length,
                    (index) => Padding(
                      padding: Dimens.edgeInsets16,
                      child: CustomRatingTile(
                        reviewDate:
                            reviewsList[index].datetime?.toLocal().toString(),
                        userImage: reviewsList[index].image,
                        userName: reviewsList[index].name,
                        ratingDescription: reviewsList[index].review,
                        totalRating: reviewsList[index].rating,
                      ),
                    ),
                  ),
                ),
              ),
              Dimens.boxHeight10,
            ]
          ],
        ),
      );
}
