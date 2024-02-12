import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/utils/navigators/navigators.dart';
import '../../res/res.dart';
import '../../utils/translations/translation_keys.dart';
import '../../widgets/widgets.dart';

class ChooseBabySitterView extends StatelessWidget {
  const ChooseBabySitterView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Padding(
          padding: Dimens.edgeInsets16,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: Dimens.twoHundredEightyOne,
                  child: AppText(
                    text: TranslationKeys.findTheBestBabySitter.tr,
                    style: AppStyles.pdSemiBoldBlack24,
                  ),
                ),
                Dimens.boxHeight50,
                CustomButton(
                  backGroundColor: AppColors.navyBlue,
                  title: TranslationKeys.needASitter.tr,
                  onTap: () => RouteManagement.goToSignUp(),
                ),
                Dimens.boxHeight16,
                CustomButton(
                  backGroundColor: AppColors.lightNavyBlue,
                  title: TranslationKeys.iAmSitter.tr,
                  titleStyle: AppStyles.navyBlue15UbW600,
                  onTap: () => RouteManagement.goToSignUp(),
                ),
              ],
            ),
          ),
        ),
      );
}
