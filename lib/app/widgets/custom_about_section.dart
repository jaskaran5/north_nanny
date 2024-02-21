import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../res/theme/colors.dart';
import '../res/theme/dimens.dart';
import '../res/theme/styles.dart';
import '../utils/translations/translation_keys.dart';
import 'app_text.dart';
import 'houry_rate_view.dart';

class CustomAbout extends StatelessWidget {
  const CustomAbout({super.key, required this.aboutNanny});
  final String aboutNanny;
  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: Dimens.edgeInsetsL16R16,
            padding: Dimens.edgeInsets16,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(Dimens.ten),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: TranslationKeys.about.tr,
                  style: AppStyles.ubBlack14W700,
                  maxLines: 1,
                  textAlign: TextAlign.start,
                ),
                Dimens.boxHeight16,
                AppText(
                  text: aboutNanny,
                  style: AppStyles.ubGrey12W400,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
          Dimens.boxHeight20,
          Padding(
            padding: Dimens.edgeInsetsL16R16,
            child: HourlyRateView(
              showShadow: false,
              borderRadius: Dimens.ten,
            ),
          ),
        ],
      );
}
