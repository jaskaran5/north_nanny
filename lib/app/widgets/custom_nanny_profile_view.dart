import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_cache_network_image.dart';

import '../res/constants/assets.dart';
import '../res/theme/colors.dart';
import '../res/theme/dimens.dart';
import '../res/theme/styles.dart';
import '../utils/translations/translation_keys.dart';
import 'app_text.dart';

class CustomNannyProfileView extends StatelessWidget {
  const CustomNannyProfileView({
    super.key,
    this.nannyName,
    this.totalRating,
    this.onTapRating,
    this.totalReview,
    this.nannyAge,
    this.nannyGender,
    this.nannyExperience,
    this.distance,
    this.imageUrl,
  });
  final String? nannyName;
  final String? distance;
  final String? imageUrl;
  final String? nannyAge;
  final String? nannyGender;
  final String? nannyExperience;
  final double? totalRating;
  final Function()? onTapRating;
  final int? totalReview;
  @override
  Widget build(BuildContext context) => Container(
        color: AppColors.primaryColor,
        width: Get.width,
        padding: Dimens.edgeInsets16,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: Dimens.ninety,
              width: Dimens.ninety,
              padding: Dimens.edgeInsets2,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.activeBorderColor,
                  width: Dimens.one,
                ),
                shape: BoxShape.circle,
              ),
              child: imageUrl?.isNotEmpty == true
                  ? CustomCacheNetworkImage(
                      img: imageUrl.toString(),
                      size: Dimens.ninety,
                      imageRadius: Dimens.hundred,
                    )
                  : CircleAvatar(
                      radius: Dimens.hundred,
                      backgroundImage: const AssetImage(
                        Assets.imagesUserAvatar,
                      ),
                    ),
            ),
            Dimens.boxHeight8,
            AppText(
              text: nannyName.toString(),
              style: AppStyles.ubBlack16W700,
              maxLines: 1,
              textAlign: TextAlign.center,
            ),
            Dimens.boxHeight8,
            GestureDetector(
              onTap: onTapRating,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(Assets.iconsStar),
                  Dimens.boxWidth4,
                  RichText(
                    text: TextSpan(
                      text: totalRating == 0.0 ? '0' : totalRating.toString(),
                      style: AppStyles.ubBlack12W500,
                      children: [
                        TextSpan(
                          text:
                              ' (${totalReview.toString()} ${TranslationKeys.reviews.tr})',
                          style: AppStyles.ubBlack0B0B0B12W400,
                        )
                      ],
                    ),
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            Dimens.boxHeight8,
            Container(
              height: Dimens.thirty,
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (nannyGender?.isNotEmpty == true)
                    Container(
                      height: Dimens.twentyEight,
                      padding: Dimens.edgeInsetsL12T6R12B6,
                      margin: Dimens.edgeInsets0.copyWith(right: Dimens.ten),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.listColor,
                        borderRadius: BorderRadius.circular(Dimens.eight),
                      ),
                      child: AppText(
                        text: ' ${TranslationKeys.gender.tr}: $nannyGender',
                        style: AppStyles.ubBlack0B0B0B12W400,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  if (distance?.isNotEmpty == true)
                    Container(
                      height: Dimens.twentyEight,
                      padding: Dimens.edgeInsetsL12T6R12B6,
                      margin: Dimens.edgeInsets0.copyWith(right: Dimens.ten),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.listColor,
                        borderRadius: BorderRadius.circular(Dimens.eight),
                      ),
                      child: AppText(
                        text:
                            ' ${TranslationKeys.distance.tr}: $distance miles',
                        style: AppStyles.ubBlack0B0B0B12W400,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  if (nannyAge?.isNotEmpty == true)
                    Container(
                      height: Dimens.twentyEight,
                      padding: Dimens.edgeInsetsL12T6R12B6,
                      margin: Dimens.edgeInsets0.copyWith(right: Dimens.ten),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.listColor,
                        borderRadius: BorderRadius.circular(Dimens.eight),
                      ),
                      child: AppText(
                        text: ' ${TranslationKeys.age.tr}: $nannyAge',
                        style: AppStyles.ubBlack0B0B0B12W400,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  if (nannyExperience?.isNotEmpty == true)
                    Container(
                      height: Dimens.twentyEight,
                      padding: Dimens.edgeInsetsL12T6R12B6,
                      // margin: Dimens.edgeInsets0.copyWith(right: Dimens.ten),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.listColor,
                        borderRadius: BorderRadius.circular(Dimens.eight),
                      ),
                      child: AppText(
                        text:
                            ' ${TranslationKeys.experience.tr}: $nannyExperience yrs',
                        style: AppStyles.ubBlack0B0B0B12W400,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      );
}
