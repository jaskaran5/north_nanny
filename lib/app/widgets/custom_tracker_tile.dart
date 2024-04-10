import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_cache_network_image.dart';

import '../res/constants/assets.dart';
import '../res/theme/colors.dart';
import '../res/theme/dimens.dart';
import '../res/theme/styles.dart';
import 'app_text.dart';

class CustomTrackerTile extends StatelessWidget {
  const CustomTrackerTile({
    super.key,
    required this.image,
    required this.svgPath,
    required this.name,
    required this.rating,
    required this.reviews,
    required this.description,
    this.onTapChat,
    required this.distance,
    required this.age,
    required this.experience,
    required this.onTapRatingAndReview,
    required this.secondWidget,
    required this.showChat,
  });
  final String image;
  final String svgPath;
  final String name;
  final String rating;
  final String reviews;
  final String description;
  final String distance;
  final int age;
  final String experience;
  final Function()? onTapChat;
  final Function() onTapRatingAndReview;
  final Widget secondWidget;
  final bool showChat;

  @override
  Widget build(BuildContext context) => Container(
        padding: Dimens.edgeInsets16,
        decoration: BoxDecoration(
          color: AppColors.navyBlue,
          borderRadius: BorderRadius.circular(Dimens.twenty),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: Dimens.hundred,
                  width: Dimens.eightySix,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimens.ten),
                  ),
                  child: image.isNotEmpty
                      ? CustomCacheNetworkImage(
                          img: image,
                          size: Dimens.hundred,
                          imageRadius: Dimens.ten)
                      : Image.asset(
                          Assets.imagesUserAvatar,
                          fit: BoxFit.contain,
                          height: Dimens.hundred,
                          width: Dimens.eightySix,
                        ),
                ),
                Dimens.boxWidth10,
                SizedBox(
                  width: Dimens.oneHundredNinety,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText(
                            text: name,
                            style: AppStyles.ubWhite14700,
                            maxLines: 1,
                            textAlign: TextAlign.start,
                          ),
                          if (showChat)
                            GestureDetector(
                              onTap: onTapChat,
                              child: SvgPicture.asset(
                                svgPath,
                              ),
                            ),
                        ],
                      ),
                      Dimens.boxHeight4,
                      GestureDetector(
                        onTap: onTapRatingAndReview,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(Assets.iconsStar),
                            Dimens.boxWidth4,
                            RichText(
                              text: TextSpan(
                                text: '$rating ',
                                style: AppStyles.ubLightNavy12W500,
                                children: [
                                  TextSpan(
                                    text:
                                        '($reviews ${TranslationKeys.reviews.tr})',
                                    style: AppStyles.ubLightNavy12W400,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Dimens.boxHeight4,
                      AppText(
                        text: description,
                        maxLines: 4,
                        style: AppStyles.ubLightNavy10W400,
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Dimens.boxHeight14,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: Dimens.thirty,
                  child: Container(
                    height: Dimens.twentyFive,
                    padding: Dimens.edgeInsets6,
                    margin: Dimens.edgeInsetsR16,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.trackerBackgroundColor,
                      borderRadius: BorderRadius.circular(Dimens.eight),
                    ),
                    child: AppText(
                      text: '${TranslationKeys.distance.tr} : $distance',
                      style: AppStyles.ubLightNavy10W400,
                      maxLines: 1,
                    ),
                  ),
                ),
                SizedBox(
                  height: Dimens.thirty,
                  child: Container(
                    height: Dimens.twentyFive,
                    padding: Dimens.edgeInsets6,
                    margin: Dimens.edgeInsetsR16,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.trackerBackgroundColor,
                      borderRadius: BorderRadius.circular(Dimens.eight),
                    ),
                    child: AppText(
                      text: '${TranslationKeys.age.tr} : $age',
                      style: AppStyles.ubLightNavy10W400,
                      maxLines: 1,
                    ),
                  ),
                ),
                SizedBox(
                  height: Dimens.thirty,
                  child: Container(
                    height: Dimens.twentyFive,
                    padding: Dimens.edgeInsets6,
                    margin: Dimens.edgeInsetsR16,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.trackerBackgroundColor,
                      borderRadius: BorderRadius.circular(Dimens.eight),
                    ),
                    child: AppText(
                      text:
                          '${TranslationKeys.experience.tr} : $experience yrs',
                      style: AppStyles.ubLightNavy10W400,
                      maxLines: 1,
                    ),
                  ),
                ),
              ],
            ),
            Dimens.boxHeight14,
            AppText(
              text: TranslationKeys.trackLocation.tr,
              style: AppStyles.ubWhite14700,
              maxLines: 1,
              textAlign: TextAlign.start,
            ),
            Dimens.boxHeight14,
            secondWidget,
          ],
        ),
      );
}
