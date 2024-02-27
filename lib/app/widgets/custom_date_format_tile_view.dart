import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';

import '../res/theme/dimens.dart';
import '../res/theme/styles.dart';
import 'app_text.dart';

class CustomDateFormatTile extends StatelessWidget {
  const CustomDateFormatTile(
      {super.key,
      required this.day,
      required this.dateFormatInMonthYearDayOfWeek,
      required this.timing,
      required this.totalPrice});
  final String day;
  final String dateFormatInMonthYearDayOfWeek;
  final String timing;
  final String totalPrice;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppText(
                text: day.toString(),
                style: AppStyles.ubBlack30W600,
                maxLines: 1,
              ),
              Dimens.boxWidth16,
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                      text: dateFormatInMonthYearDayOfWeek,
                      style: AppStyles.ubGrey12W400,
                      maxLines: 1,
                      textAlign: TextAlign.start),
                  Dimens.boxHeight8,
                  AppText(
                    text: timing,
                    style: AppStyles.ubBlack14W700,
                    maxLines: 1,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ],
          ),
          totalPrice.isNotEmpty
              ? AppText(
                  text: '\$$totalPrice',
                  style: AppStyles.ubBlack16W700,
                  maxLines: 1,
                )
              : SvgPicture.asset(
                  Assets.iconsRightGrey,
                  height: Dimens.twentyFour,
                  width: Dimens.twentyFour,
                ),
        ],
      );
}
