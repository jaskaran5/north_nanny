import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/models/nanny_profile_model.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/utils/utility.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';
import 'package:northshore_nanny_flutter/app/widgets/review_custom_bottom_sheet.dart';

class ShortDetailProfileView extends StatelessWidget {
  const ShortDetailProfileView({
    super.key,
    required this.nannyName,
    required this.totalRating,
    required this.totalReviews,
    required this.image, required this.ratingList,
  });
  final String nannyName;
  final double totalRating;
  final int totalReviews;
  final String image;
  final List<RatingList> ratingList;

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
                radius: 50,
                backgroundColor: Colors.transparent,
                backgroundImage: NetworkImage(image),
              )

              //  CircleAvatar(
              //   backgroundImage: const AssetImage(
              //     Assets.iconsImage,
              //   ),
              //   radius: Dimens.hundred,
              // ),
              ),
          Dimens.boxWidth10,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: Get.width * .7,
                child: AppText(
                  textAlign: TextAlign.left,
                  text: nannyName,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.ubNavyBlue14W700,
                  maxLines: 1,
                ),
              ),
              Dimens.boxHeight8,
              GestureDetector(
                onTap: () {
                  Utility.openBottomSheet(CustomReviewBottomSheet(
                      totalReviews: totalReviews,
                      totalReviewsRating: totalRating,
                      reviewsList: ratingList ));
                  //   'Michael Johnson',
                  //   'Giorgio Chiellini',
                  //   'Michael Johnson',
                  //   'Alex Morgan',
                  //   'Giorgio Chiellini'
                  // ],
                },
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
                                ' (${totalReviews.toString()} ${TranslationKeys.reviews.tr})',
                            style: AppStyles.ubGrey12W400,
                          )
                        ],
                      ),
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
