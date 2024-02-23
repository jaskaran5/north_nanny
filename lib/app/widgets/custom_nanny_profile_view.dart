import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../res/constants/assets.dart';
import '../res/theme/colors.dart';
import '../res/theme/dimens.dart';
import '../res/theme/styles.dart';
import '../utils/translations/translation_keys.dart';
import 'app_text.dart';

class CustomNannyProfileView extends StatelessWidget {
  const CustomNannyProfileView({
    super.key,
    this.servicesList,
    this.nannyName,
    this.totalRating,
    this.onTapRating,
    this.totalReview,
  });
  final List<String>? servicesList;
  final String? nannyName;
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
              height: Dimens.ninty,
              width: Dimens.ninty,
              padding: Dimens.edgeInsets2,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.activeBorderColor,
                  width: Dimens.one,
                ),
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                radius: Dimens.hundred,
                backgroundImage: const AssetImage(
                  Assets.iconsImage,
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
                      text: totalRating.toString(),
                      style: AppStyles.ubBlack12W500,
                      children: [
                        TextSpan(
                          text:
                              ' (${totalReview.toString()} ${TranslationKeys.reviews.tr})',
                          style: AppStyles.ubGrey12W400,
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
              margin: Dimens.edgeInsetsL16R16,
              alignment: Alignment.center,
              child: ListView(
                padding: Dimens.edgeInsetsL15,
                scrollDirection: Axis.horizontal,
                children: List.generate(
                  servicesList?.length ?? 0,
                  (index) => Container(
                    height: Dimens.twentyEight,
                    padding: Dimens.edgeInsetsL12T6R12B6,
                    margin: Dimens.edgeInsetsR16,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.listColor,
                      borderRadius: BorderRadius.circular(Dimens.eight),
                    ),
                    child: AppText(
                      text: servicesList?[index].toString(),
                      style: AppStyles.ubGrey12W400,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
