import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/nanny/nanny_views/create_profile/create_nanny_profile_controller.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_app_bar.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_button.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_text_field.dart';

class BankDetailsView extends StatelessWidget {
  const BankDetailsView({super.key});
  @override
  Widget build(BuildContext context) =>
      GetBuilder<CreateNannyProfileController>(
        init: CreateNannyProfileController(),
        builder: (controller) => Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: CustomAppbarWidget(
            title: TranslationKeys.bankDetails.tr,
            onBackPress: () {
              Get.focusScope?.unfocus();
              Get.back();
              controller.bankNameTextEditingController.clear();
              controller.holderNameTextEditingController.clear();
              controller.accountNumberTextEditingController.clear();
              controller.routingNumberTextEditingController.clear();
            },
          ),
          body: GestureDetector(
            onTap: () {
              Get.focusScope?.unfocus();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: Dimens.edgeInsets16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            controller:
                                controller.bankNameTextEditingController,
                            maxLines: 1,
                            minLines: 1,
                            decoration: customFieldDeco(
                              hintText: TranslationKeys.bankName.tr,
                              prefixWidget: Padding(
                                padding: Dimens.edgeInsets12,
                                child: SvgPicture.asset(
                                  Assets.iconsBank,
                                  height: Dimens.ten,
                                  width: Dimens.ten,
                                ),
                              ),
                            ),
                            cursorColor: AppColors.blackColor,
                            cursorWidth: Dimens.one,
                            style: AppStyles.ubBlack15W600,
                            keyboardType: TextInputType.text,
                          ),
                          Dimens.boxHeight20,
                          TextField(
                            controller:
                                controller.holderNameTextEditingController,
                            maxLines: 1,
                            minLines: 1,
                            decoration: customFieldDeco(
                              hintText: TranslationKeys.accountHolderName.tr,
                              prefixWidget: Padding(
                                padding: Dimens.edgeInsets12,
                                child: SvgPicture.asset(
                                  Assets.iconsSmallProfile,
                                  height: Dimens.ten,
                                  width: Dimens.ten,
                                ),
                              ),
                            ),
                            cursorColor: AppColors.blackColor,
                            cursorWidth: Dimens.one,
                            style: AppStyles.ubBlack15W600,
                            keyboardType: TextInputType.text,
                          ),
                          Dimens.boxHeight20,
                          TextField(
                            controller:
                                controller.accountNumberTextEditingController,
                            maxLines: 1,
                            minLines: 1,
                            maxLength: 12,
                            decoration: customFieldDeco(
                              hintText: TranslationKeys.accountNumber.tr,
                              prefixWidget: Padding(
                                padding: Dimens.edgeInsets12,
                                child: SvgPicture.asset(
                                  Assets.iconsMoreSquare,
                                  height: Dimens.ten,
                                  width: Dimens.ten,
                                ),
                              ),
                            ),
                            cursorColor: AppColors.blackColor,
                            cursorWidth: Dimens.one,
                            style: AppStyles.ubBlack15W600,
                            keyboardType: TextInputType.phone,
                          ),
                          Dimens.boxHeight20,
                          TextField(
                            controller:
                                controller.routingNumberTextEditingController,
                            maxLines: 1,
                            minLines: 1,
                            maxLength: 12,
                            decoration: customFieldDeco(
                              hintText: TranslationKeys.routingNumber.tr,
                              prefixWidget: Padding(
                                padding: Dimens.edgeInsets12,
                                child: SvgPicture.asset(
                                  Assets.iconsShieldSecurity,
                                  height: Dimens.ten,
                                  width: Dimens.ten,
                                ),
                              ),
                            ),
                            cursorColor: AppColors.blackColor,
                            cursorWidth: Dimens.one,
                            style: AppStyles.ubBlack15W600,
                            keyboardType: TextInputType.phone,
                          ),
                          Dimens.boxHeight20,
                          TextField(
                            controller: controller.addressOne,
                            maxLines: 1,
                            minLines: 1,
                            maxLength: 40,
                            decoration: customFieldDeco(
                              hintText: TranslationKeys.address.tr,
                              prefixWidget: Padding(
                                padding: Dimens.edgeInsets12,
                                child: SvgPicture.asset(
                                  Assets.iconsAddress,
                                  height: Dimens.ten,
                                  width: Dimens.ten,
                                ),
                              ),
                            ),
                            cursorColor: AppColors.blackColor,
                            cursorWidth: Dimens.one,
                            style: AppStyles.ubBlack15W600,
                            keyboardType: TextInputType.text,
                          ),
                          Dimens.boxHeight20,
                          TextField(
                            controller: controller.addressTwo,
                            maxLines: 1,
                            minLines: 1,
                            maxLength: 40,
                            decoration: customFieldDeco(
                              hintText: 'Other ${TranslationKeys.address.tr}',
                              prefixWidget: Padding(
                                padding: Dimens.edgeInsets12,
                                child: SvgPicture.asset(
                                  Assets.iconsAddress,
                                  height: Dimens.ten,
                                  width: Dimens.ten,
                                ),
                              ),
                            ),
                            cursorColor: AppColors.blackColor,
                            cursorWidth: Dimens.one,
                            style: AppStyles.ubBlack15W600,
                            keyboardType: TextInputType.text,
                          ),
                          Dimens.boxHeight20,
                          TextField(
                            controller: controller.cityTextEditingController,
                            maxLines: 1,
                            minLines: 1,
                            maxLength: 10,
                            decoration: customFieldDeco(
                              hintText: TranslationKeys.city.tr,
                              prefixWidget: Padding(
                                padding: Dimens.edgeInsets12,
                                child: SvgPicture.asset(
                                  Assets.iconsCity,
                                  height: Dimens.ten,
                                  width: Dimens.ten,
                                ),
                              ),
                            ),
                            cursorColor: AppColors.blackColor,
                            cursorWidth: Dimens.one,
                            style: AppStyles.ubBlack15W600,
                            keyboardType: TextInputType.text,
                          ),
                          Dimens.boxHeight20,
                          TextField(
                            controller: controller.stateTextEditingController,
                            maxLines: 1,
                            minLines: 1,
                            maxLength: 9,
                            decoration: customFieldDeco(
                              hintText: TranslationKeys.state.tr,
                              prefixWidget: Padding(
                                padding: Dimens.edgeInsets12,
                                child: SvgPicture.asset(
                                  Assets.iconsState,
                                  height: Dimens.ten,
                                  width: Dimens.ten,
                                ),
                              ),
                            ),
                            cursorColor: AppColors.blackColor,
                            cursorWidth: Dimens.one,
                            style: AppStyles.ubBlack15W600,
                            keyboardType: TextInputType.text,
                          ),
                          Dimens.boxHeight20,
                          TextField(
                            controller: controller.countryTextEditingController,
                            maxLines: 1,
                            minLines: 1,
                            maxLength: 9,
                            decoration: customFieldDeco(
                              hintText: TranslationKeys.country.tr,
                              prefixWidget: Padding(
                                padding: Dimens.edgeInsets12,
                                child: SvgPicture.asset(
                                  Assets.iconsCountry,
                                  height: Dimens.ten,
                                  width: Dimens.ten,
                                ),
                              ),
                            ),
                            cursorColor: AppColors.blackColor,
                            cursorWidth: Dimens.one,
                            style: AppStyles.ubBlack15W600,
                            keyboardType: TextInputType.text,
                          ),
                          Dimens.boxHeight20,
                          TextField(
                            controller:
                                controller.postalCodeTextEditingController,
                            maxLines: 1,
                            minLines: 1,
                            maxLength: 9,
                            decoration: customFieldDeco(
                              hintText: TranslationKeys.postalCode.tr,
                              prefixWidget: Padding(
                                padding: Dimens.edgeInsets12,
                                child: SvgPicture.asset(
                                  Assets.iconsPostalCode,
                                  height: Dimens.ten,
                                  width: Dimens.ten,
                                ),
                              ),
                            ),
                            cursorColor: AppColors.blackColor,
                            cursorWidth: Dimens.one,
                            style: AppStyles.ubBlack15W600,
                            keyboardType: TextInputType.text,
                          ),
                          Dimens.boxHeight20,
                        ],
                      ),
                    ),
                  ),
                ),
                Center(
                  child: CustomButton(
                    title: TranslationKeys.addBank.tr,
                    backGroundColor: AppColors.navyBlue,
                    onTap: () {
                      controller.bankDetailValidator();
                    },
                  ),
                ),
                Dimens.boxHeight10,
                CustomButton(
                  title: TranslationKeys.skipForNow.tr,
                  backGroundColor: AppColors.lightNavyBlue,
                  textColor: AppColors.navyBlue,
                  onTap: () {
                    controller.postBankDetails(isComeFromSkip: true);
                  },
                ),
                Dimens.boxHeight32,
              ],
            ),
          ),
        ),
      );
}
