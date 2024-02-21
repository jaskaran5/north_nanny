import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';

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
    required this.servicesList,
    this.onTapSvg,
  });
  final String image;
  final String svgPath;
  final String name;
  final String rating;
  final String reviews;
  final String description;
  final List<String> servicesList;
  final Function()? onTapSvg;
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: Dimens.hundred,
                  width: Dimens.eightySix,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimens.ten),
                  ),
                  child: Image.asset(
                    image,
                    fit: BoxFit.contain,
                  ),
                ),
                Dimens.boxWidth16,
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppText(
                      text: name,
                      style: AppStyles.ubWhite14700,
                      maxLines: 1,
                      textAlign: TextAlign.start,
                    ),
                    Dimens.boxHeight4,
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(Assets.iconsStar),
                        Dimens.boxWidth4,
                        RichText(
                          text: TextSpan(
                            text: rating,
                            style: AppStyles.ubLightNavy12W500,
                            children: [
                              TextSpan(
                                text: reviews,
                                style: AppStyles.ubLightNavy12W400,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Dimens.boxHeight4,
                    SizedBox(
                      width: Dimens.oneHundredFifty,
                      child: AppText(
                        text: description,
                        maxLines: 4,
                        style: AppStyles.ubLightNavy10W400,
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
                Dimens.boxWidth16,
                GestureDetector(
                  onTap: onTapSvg,
                  child: SvgPicture.asset(
                    svgPath,
                  ),
                ),
              ],
            ),
            Dimens.boxHeight14,
            SizedBox(
              height: Dimens.thirty,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(
                  servicesList.length,
                  (index) => Container(
                    height: Dimens.twentyFive,
                    padding: Dimens.edgeInsets6,
                    margin: Dimens.edgeInsetsR16,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.trackerBackgroundColor,
                      borderRadius: BorderRadius.circular(Dimens.eight),
                    ),
                    child: AppText(
                      text: servicesList[index].toString(),
                      style: AppStyles.ubLightNavy10W400,
                      maxLines: 1,
                    ),
                  ),
                ),
              ),
            ),
            Dimens.boxHeight14,
            AppText(
              text: TranslationKeys.trackLocation.tr,
              style: AppStyles.ubWhite14700,
              maxLines: 1,
              textAlign: TextAlign.start,
            ),
            Dimens.boxHeight14,
            Container(
              height: Dimens.hundredFourteen,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimens.ten),
              ),
            ),
          ],
        ),
      );
}
