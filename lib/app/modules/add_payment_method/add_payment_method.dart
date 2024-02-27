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

import '../../res/theme/colors.dart';
import '../../widgets/custom_text_field.dart';

class AddPaymentMethod extends StatelessWidget {
  const AddPaymentMethod({super.key, required this.isComeFromNannyProfile, required this.buttonTitle, required this.onTapButton});
  final bool isComeFromNannyProfile;
  final String buttonTitle;
  final Function() onTapButton;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: CustomAppbarWidget(
          title: !isComeFromNannyProfile
              ? TranslationKeys.addPaymentMethod.tr
              : '',
        ),
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
                        if (isComeFromNannyProfile) ...[
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
                        ],
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
                  title: buttonTitle,
                  backGroundColor: AppColors.navyBlue,
                  onTap:onTapButton,
                ),
              ],
            ),
          ),
        ),
      );
}
