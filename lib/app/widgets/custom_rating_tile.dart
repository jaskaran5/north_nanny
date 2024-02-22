import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';

class CustomRatingTile extends StatelessWidget {
  const CustomRatingTile(
      {super.key,
      required this.reviewDate,
      required this.userImage,
      required this.userName,
      required this.ratingDescription,
      required this.totalRating});
  final String reviewDate;
  final String userImage;
  final String userName;
  final String ratingDescription;
  final double totalRating;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: Dimens.forty,
                    width: Dimens.forty,
                    child: CircleAvatar(
                      radius: Dimens.hundred,
                      backgroundImage: AssetImage(userImage),
                    ),
                  ),
                  Dimens.boxWidth10,
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        text: userName,
                        maxLines: 1,
                        style: AppStyles.ubBlack15W600,
                        textAlign: TextAlign.start,
                      ),
                      Dimens.boxHeight4,
                      RatingBar(
                        initialRating: totalRating,
                        minRating: 1,
                        maxRating: Dimens.five,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemPadding: Dimens.edgeInsets4,
                        itemCount: 5,
                        ratingWidget: RatingWidget(
                          full: SvgPicture.asset(Assets.iconsFullRating),
                          half: SvgPicture.asset(Assets.iconsHalfRating),
                          empty: SvgPicture.asset(Assets.iconsNoRating),
                        ),
                        onRatingUpdate: (double value) {},
                      ),
                    ],
                  ),
                ],
              ),
              AppText(
                  text: reviewDate, style: AppStyles.ubGrey12W400, maxLines: 1),
            ],
          ),
          Dimens.boxHeight8,
          Flexible(
            child: AppText(
              text: ratingDescription,
              style: AppStyles.ubGrey12W500,
              maxLines: 4,
            ),
          ),
        ],
      );
}
