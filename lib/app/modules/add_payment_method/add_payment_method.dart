import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_app_bar.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_button.dart';
import 'package:northshore_nanny_flutter/navigators/routes_management.dart';

import '../../res/theme/colors.dart';
import '../../widgets/custom_text_field.dart';

class AddPaymentMethod extends StatelessWidget {
  const AddPaymentMethod({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const CustomAppbarWidget(),
        body: Padding(
          padding: Dimens.edgeInsets16,
          child: GestureDetector(
            onTap: () {
              Get.focusScope?.unfocus();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          text: TranslationKeys.addPaymentMethod.tr,
                          maxLines: 1,
                          textAlign: TextAlign.start,
                          style: AppStyles.pdSemiBoldBlack24,
                        ),
                        Dimens.boxHeight10,
                        AppText(
                          text: TranslationKeys.cardWillCharged.tr,
                          maxLines: 2,
                          textAlign: TextAlign.start,
                          style: AppStyles.ubGrey16W400,
                        ),
                        Dimens.boxHeight16,
                        TextField(
                          maxLines: 1,
                          minLines: 1,
                          decoration: customFieldDeco(
                            hintText: TranslationKeys.cardHolderName.tr,
                            prefixWidget: Padding(
                              padding: Dimens.edgeInsets12,
                              child: SvgPicture.asset(
                                Assets.iconsSmallProfile,
                                height: Dimens.ten,
                                width: Dimens.ten,
                              ),
                            ),
                          ),
                          cursorColor: AppColors.navyBlue,
                          cursorWidth: Dimens.one,
                          style: AppStyles.ubBlack15W600,
                          keyboardType: TextInputType.text,
                        ),
                        Dimens.boxHeight16,
                        TextField(
                          maxLines: 1,
                          minLines: 1,
                          decoration: customFieldDeco(
                            hintText: TranslationKeys.creditDebit.tr,
                            prefixWidget: Padding(
                              padding: Dimens.edgeInsets12,
                              child: SvgPicture.asset(
                                Assets.iconsCard,
                                height: Dimens.ten,
                                width: Dimens.ten,
                              ),
                            ),
                          ),
                          cursorColor: AppColors.navyBlue,
                          cursorWidth: Dimens.one,
                          style: AppStyles.ubBlack15W600,
                          keyboardType: TextInputType.phone,
                        ),
                        Dimens.boxHeight16,
                        TextField(
                          maxLines: 1,
                          minLines: 1,
                          decoration: customFieldDeco(
                            hintText: TranslationKeys.expirationDate.tr,
                            prefixWidget: Padding(
                              padding: Dimens.edgeInsets12,
                              child: SvgPicture.asset(
                                Assets.iconsCalendar,
                                height: Dimens.ten,
                                width: Dimens.ten,
                              ),
                            ),
                          ),
                          cursorColor: AppColors.navyBlue,
                          cursorWidth: Dimens.one,
                          style: AppStyles.ubBlack15W600,
                          keyboardType: TextInputType.phone,
                        ),
                        Dimens.boxHeight16,
                        TextField(
                          maxLines: 1,
                          minLines: 1,
                          decoration: customFieldDeco(
                            hintText: TranslationKeys.cVV.tr,
                            prefixWidget: Padding(
                              padding: Dimens.edgeInsets12,
                              child: SvgPicture.asset(
                                Assets.iconsShieldSecurity,
                                height: Dimens.ten,
                                width: Dimens.ten,
                              ),
                            ),
                          ),
                          cursorColor: AppColors.navyBlue,
                          cursorWidth: Dimens.one,
                          style: AppStyles.ubBlack15W600,
                          keyboardType: TextInputType.phone,
                        ),
                        Dimens.boxHeight16,
                      ],
                    ),
                  ),
                ),
                CustomButton(
                  title: TranslationKeys.submit.tr,
                  backGroundColor: AppColors.navyBlue,
                  onTap: () {
                    RouteManagement.goToSuccessView(
                      buttonText: TranslationKeys.backToHome.tr,
                      successSvg: Assets.iconsSuccess,
                      header: TranslationKeys.nannyRequested.tr,
                      headerStyle: AppStyles.ubDarkBlackColor24W700,
                      subHeader: TranslationKeys.notificationNannyAccept.tr,
                      onTapButton: () {
                        RouteManagement.goToOffAllDashboard(
                            isFromSetting: false);
                      },
                      subTitleStyle: AppStyles.ubGrey16W500,
                      subHeaderMaxLines: 2,
                      headerMaxLines: 2,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );
}
