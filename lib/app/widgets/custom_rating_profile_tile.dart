import 'package:flutter/material.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_cache_network_image.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_rich_text.dart';

class CustomRatingProfileTile extends StatelessWidget {
  const CustomRatingProfileTile({super.key});

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
            child: Image.network(
              "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg",
              height: Dimens.sixty,
              width: Dimens.sixty,
              fit: BoxFit.cover,
            ),
            // child: CustomCacheNetworkImage(
            //   img: '',
            //   size: Dimens.sixty,
            // ),
          ),
          Dimens.boxWidth8,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: "Michaekl johnson",
                style: AppStyles.ubDarkBlackColor14W700,
              ),
              const Row(
                children: [
                  Icon(
                    Icons.star,
                    color: AppColors.fFC107YellowColor,
                  ),

                  CustomRichText(firstTxt: "4.5", lastTxt: "(21 reviews)")
                  // AppText(
                  //   text: "4.5 (21 reviews)",
                  //   style: AppStyles.ubGrey10W400,
                  // ),
                ],
              ),
            ],
          )
        ]),
      ),
    );
  }
}
