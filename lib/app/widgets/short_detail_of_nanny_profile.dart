import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';

class ShortDetailProfileView extends StatelessWidget {
  const ShortDetailProfileView(
      {super.key,
      required this.nannyName,
      required this.totalRating,
      required this.totalReviews});
  final String nannyName;
  final double totalRating;
  final int totalReviews;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: Dimens.edgeInsetsT16B16,
      child: Row(
        children: [
          SizedBox(
            height: Dimens.fifty,
            width: Dimens.fifty,
            child: CircleAvatar(
              backgroundImage: const AssetImage(
                Assets.iconsImage,
              ),
              radius: Dimens.hundred,
            ),
          ),
          Dimens.boxWidth10,
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppText(
                text: nannyName,
                style: AppStyles.ubNavyBlue14W700,
                maxLines: 1,
              ),
              Dimens.boxHeight8,
              Row(
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
                              '(${totalReviews.toString()} ${TranslationKeys.reviews.tr})',
                          style: AppStyles.ubGrey12W400,
                        )
                      ],
                    ),
                    maxLines: 1,
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
