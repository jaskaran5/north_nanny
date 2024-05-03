import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_cache_network_image.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_rich_text.dart';

class CustomRatingProfileTile extends StatelessWidget {
  const CustomRatingProfileTile(
      {super.key,
      required this.image,
      required this.name,
      required this.rating,
      required this.totalReviews});
  final String image;
  final String name;
  final double rating;
  final int totalReviews;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: Dimens.two, color: AppColors.navyBlue),
          borderRadius: BorderRadius.circular(
            Dimens.ten,
          )),
      child: Padding(
        padding: EdgeInsets.all(Dimens.eight),
        child: Row(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(Dimens.ten),
            child: image.isNotEmpty
                ? CustomCacheNetworkImage(
                    imageRadius: Dimens.eight,
                    img: image,
                    size: Dimens.sixty,
                  )
                : Image.asset(
                    Assets.imagesUserAvatar,
                    height: Dimens.sixty,
                    width: Dimens.sixty,
                  ),
          ),
          Dimens.boxWidth8,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: Dimens.twoHundred,
                child: AppText(
                  text: name,
                  style: AppStyles.ubDarkBlackColor14W700,
                  maxLines: 2,
                  textAlign: TextAlign.left,
                ),
              ),
              Dimens.boxHeight4,
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    Assets.iconsStar,
                    height: Dimens.ten,
                    width: Dimens.ten,
                  ),
                  Dimens.boxWidth4,
                  CustomRichText(
                    firstTxt: rating == 0.0 ? '0' : rating.toString(),
                    lastTxt: "($totalReviews ${TranslationKeys.reviews.tr})",
                  )
                ],
              ),
            ],
          )
        ]),
      ),
    );
  }
}
