import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';

class CustomRatingTile extends StatelessWidget {
  const CustomRatingTile({super.key});

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
          child: Column(
            children: [
              AppText(
                text: "Rate family",
                style: AppStyles.B0B0BUrbanist14W700,
              ),
              Padding(
                padding: Dimens.edgeInsets8,
                child: RatingBar.builder(
                  initialRating: 1,
                  minRating: 1,
                  unratedColor: AppColors.dEDFE0GreyColor,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  glow: false,
                  updateOnDrag: true,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: AppColors.fFC107YellowColor,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
              )
            ],
          )),
    );
  }
}
