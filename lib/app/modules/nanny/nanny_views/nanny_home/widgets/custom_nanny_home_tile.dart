import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_cache_network_image.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_date_format_tile_view.dart';

import '../../../../../res/constants/assets.dart';
import '../../../../../res/theme/colors.dart';
import '../../../../../res/theme/dimens.dart';
import '../../../../../res/theme/styles.dart';
import '../../../../../widgets/app_text.dart';

class CustomNannyHomeTile extends StatelessWidget {
  const CustomNannyHomeTile(
      {super.key,
      required this.day,
      required this.dateFormatInMonthYearDayOfWeek,
      required this.timing,
      required this.totalPrice,
      required this.image,
      required this.name,
      required this.rating,
      required this.reviews,
      required this.onTapRating,
      required this.noOfKids,
      required this.distance});
  final String day;
  final String dateFormatInMonthYearDayOfWeek;
  final String timing;
  final String totalPrice;
  final String image;
  final String name;
  final String rating;
  final String reviews;
  final int noOfKids;
  final dynamic distance;
  final Function() onTapRating;

  @override
  Widget build(BuildContext context) => Container(
        height: Dimens.twoHundredThirteen,
        padding: Dimens.edgeInsets16,
        margin: Dimens.edgeInsetsB16,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          border: Border.all(
            color: AppColors.navyBlue,
            width: Dimens.two,
          ),
          borderRadius: BorderRadius.circular(Dimens.fourteen),
          boxShadow: [
            BoxShadow(
              color: AppColors.lightNavyBlue.withOpacity(.9),
              blurRadius: Dimens.eight,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: Dimens.seventy,
                  width: Dimens.seventy,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimens.fourteen),
                  ),
                  child: image.isEmpty
                      ? Image.asset(
                          Assets.imagesUserAvatar,
                          fit: BoxFit.contain,
                        )
                      : CustomCacheNetworkImage(
                          img: image,
                          size: Dimens.seventy,
                          imageRadius: Dimens.fourteen),
                ),
                Dimens.boxWidth16,
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: Dimens.twoHundred,
                      child: AppText(
                        text: name,
                        style: AppStyles.ubBlack14W700,
                        maxLines: 2,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Dimens.boxHeight4,
                    GestureDetector(
                      onTap: onTapRating,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(Assets.iconsStar),
                          Dimens.boxWidth2,
                          RichText(
                            text: TextSpan(
                              text: '$rating ',
                              style: AppStyles.ubBlack12W500,
                              children: [
                                TextSpan(
                                  text:
                                      '($reviews ${TranslationKeys.reviews.tr})',
                                  style: AppStyles.ubGrey12W400,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Dimens.boxHeight4,
                    RichText(
                      text: TextSpan(
                        text: '${TranslationKeys.price.tr} ',
                        style: AppStyles.ubBlack14W500,
                        children: [
                          TextSpan(
                            text: '\$${totalPrice.toString()}',
                            style: AppStyles.ubNavyBlue14W700,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Dimens.boxHeight14,
            SizedBox(
              height: Dimens.twentyFive,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: Dimens.twentyFive,
                    padding: Dimens.edgeInsetsL12T6R12B6,
                    margin: Dimens.edgeInsetsR16,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.listColor,
                      borderRadius: BorderRadius.circular(Dimens.eight),
                    ),
                    child: AppText(
                      text:
                          '${TranslationKeys.distance.tr.capitalizeFirst} : ${distance.toString()} miles',
                      style: AppStyles.ubGrey10W400,
                      maxLines: 1,
                    ),
                  ),
                  if (noOfKids != 0)
                    Container(
                      height: Dimens.twentyFive,
                      padding: Dimens.edgeInsetsL12T6R12B6,
                      margin: Dimens.edgeInsetsR16,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.listColor,
                        borderRadius: BorderRadius.circular(Dimens.eight),
                      ),
                      child: AppText(
                        text:
                            '${TranslationKeys.numberOfKids.tr} : ${noOfKids.toString()}',
                        style: AppStyles.ubGrey10W400,
                        maxLines: 1,
                      ),
                    ),
                ],
              ),
            ),
            Dimens.boxHeight8,
            Divider(
              color: AppColors.lightNavyBlue,
              height: Dimens.one,
              thickness: Dimens.one,
            ),
            Dimens.boxHeight14,
            CustomDateFormatTile(
              day: day,
              dateFormatInMonthYearDayOfWeek: dateFormatInMonthYearDayOfWeek,
              timing: timing,
              totalPrice: '',
            ),
          ],
        ),
      );
}
