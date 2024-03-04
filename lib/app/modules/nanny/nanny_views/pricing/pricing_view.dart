import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/nanny/nanny_views/create_profile/create_nanny_profile_controller.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_app_bar.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_button.dart';
import 'package:northshore_nanny_flutter/app/widgets/houry_rate_view.dart';
import 'package:northshore_nanny_flutter/navigators/routes_management.dart';

class PricingView extends StatelessWidget {
  const PricingView({super.key});
  @override
  Widget build(BuildContext context) =>
      GetBuilder<CreateSitterProfileController>(
        builder: (controller) => Scaffold(
          appBar: const CustomAppbarWidget(),
          bottomSheet: Container(
            padding: Dimens.edgeInsetsL16R16B20,
            child: CustomButton(
              title: TranslationKeys.continueWord.tr,
              backGroundColor: AppColors.navyBlue,
              onTap: () {
                RouteManagement.goToBankDetailView();
              },
            ),
          ),
          body: Padding(
            padding: Dimens.edgeInsets16,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: TranslationKeys.pricing.tr,
                  style: AppStyles.pdSemiBoldBlack24,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                ),
                Dimens.boxHeight10,
                AppText(
                  text: TranslationKeys.aFixedHourlyRate.tr,
                  style: AppStyles.ubBlack14W400,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                ),
                Dimens.boxHeight16,
                const HourlyRateView(
                  showShadow: true,
                ),
              ],
            ),
          ),
        ),
      );
}
