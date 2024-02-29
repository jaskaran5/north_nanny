import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../res/constants/assets.dart';
import '../res/theme/colors.dart';
import '../res/theme/dimens.dart';
import '../res/theme/styles.dart';
import '../utils/translations/translation_keys.dart';
import 'app_text.dart';

class CustomBookingTrackLocation extends StatelessWidget {
  const CustomBookingTrackLocation(
      {super.key, required this.firstWidget, required this.showTrackLocation});
  final Widget firstWidget;
  final bool showTrackLocation;

  @override
  Widget build(BuildContext context) => Container(
        padding: Dimens.edgeInsets16,
        decoration: BoxDecoration(
          color: AppColors.navyBlue,
          borderRadius: BorderRadius.circular(Dimens.twenty),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            firstWidget,
            Dimens.boxHeight14,
            if (showTrackLocation) ...[
              AppText(
                text: TranslationKeys.trackLocation.tr,
                style: AppStyles.ubWhite14700,
                maxLines: 1,
                textAlign: TextAlign.start,
              ),
              Dimens.boxHeight14,
              Container(
                height: Dimens.hundredFourteen,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimens.ten),
                ),
                child: Image.asset(Assets.imagesMap, fit: BoxFit.cover),
              ),
            ],
          ],
        ),
      );
}
