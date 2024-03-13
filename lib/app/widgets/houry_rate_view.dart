import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/res/constants/extensions.dart';

import '../res/constants/assets.dart';
import '../res/constants/enums.dart';
import '../res/theme/colors.dart';
import '../res/theme/dimens.dart';
import '../res/theme/styles.dart';
import '../utils/translations/translation_keys.dart';
import 'app_text.dart';

class HourlyRateView extends StatelessWidget {
  const HourlyRateView(
      {super.key, this.borderRadius, required this.showShadow});

  final double? borderRadius;
  final bool? showShadow;

  @override
  Widget build(BuildContext context) => Container(
        padding: Dimens.edgeInsets10,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(
            borderRadius ?? Dimens.eight,
          ),
          boxShadow: [
            BoxShadow(
              color: showShadow == true
                  ? AppColors.lightNavyBlue.withOpacity(.8)
                  : AppColors.lightNavyBlue.withOpacity(.5),
              blurRadius: Dimens.five,
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText(
              text: TranslationKeys.hourlyRate.tr,
              style: AppStyles.ubBlack14W700,
              maxLines: 1,
              textAlign: TextAlign.start,
            ),
            Dimens.boxHeight10,
            ...List.generate(
              HourlyChildrenRateList.values.length,
              (index) => Container(
                margin: Dimens.edgeInsetsT10,
                height: Dimens.sixty,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(Assets.iconsDoller),
                        Dimens.boxWidth8,
                        AppText(
                          text:
                              "${HourlyChildrenRateList.values[index].childrenName.toString().tr} ",
                          style: AppStyles.ubBlack14W600,
                          maxLines: 1,
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    AppText(
                      text:
                          "\$${HourlyChildrenRateList.values[index].ratePricePerChildren.toString()}",
                      style: AppStyles.ubNavyBlue16W700,
                      maxLines: 1,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
}
