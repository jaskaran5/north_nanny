import 'package:flutter/cupertino.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';

class CustomGiveRate extends StatelessWidget {
  const CustomGiveRate(
      {super.key, required this.onRatingUpdate, required this.initialRating});
  final Function(double rating) onRatingUpdate;
  final double initialRating;
  @override
  Widget build(BuildContext context) => Container(
        padding: Dimens.edgeInsets16,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(Dimens.twelve),
          border: Border.all(
            color: AppColors.navyBlue,
            width: Dimens.two,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppText(
              text: 'Rate nanny',
              style: AppStyles.ubBlack14W700,
              maxLines: 1,
            ),
            Dimens.boxHeight16,
            RatingBar(
              initialRating: initialRating,
              ratingWidget: RatingWidget(
                full: SvgPicture.asset(Assets.iconsFullRating),
                half: SvgPicture.asset(Assets.iconsHalfRating),
                empty: SvgPicture.asset(Assets.iconsNoRating),
              ),
              onRatingUpdate: onRatingUpdate,
              allowHalfRating: true,
              itemSize: Dimens.twentyFour,
              itemPadding: Dimens.edgeInsets4,
            ),
          ],
        ),
      );
}
