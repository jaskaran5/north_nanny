import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/data/local/db_wrapper.dart';
import 'package:northshore_nanny_flutter/app/res/constants/constants.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/utils/utility.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';
import 'package:northshore_nanny_flutter/navigators/routes_management.dart';

import '../../../widgets/custom_button.dart';

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
                AppText(
                  text: TranslationKeys.findTheBestBabySitter.tr,
                  style: AppStyles.pdSemiBoldBlack24,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Dimens.boxHeight32,
                CustomButton(
                  backGroundColor: AppColors.navyBlue,
                  title: TranslationKeys.needASitter.tr,
                  onTap: () {
                    DBWrapper().saveValue<bool>(StringConstants.isNanny, false);
                    print('value:${Utility.isNannyInterFace()}');
                    RouteManagement.goToSignUp();
                  },
                ),
                Dimens.boxHeight16,
                CustomButton(
                  backGroundColor: AppColors.lightNavyBlue,
                  title: TranslationKeys.iAmSitter.tr,
                  titleStyle: AppStyles.navyBlue15UbW600,
                  onTap: () async {
                    DBWrapper().saveValue<bool>(StringConstants.isNanny, true);
                    print('value:${Utility.isNannyInterFace()}');
                    RouteManagement.goToSignUp();
                  },
                ),
              ],
            ),
          ),
        ),
      );
}
