import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/nanny/nanny_views/bank_details/add_bank_detail_controller.dart';

import '../../../../res/constants/assets.dart';
import '../../../../res/theme/colors.dart';
import '../../../../res/theme/dimens.dart';
import '../../../../res/theme/styles.dart';
import '../../../../utils/translations/translation_keys.dart';
import '../../../../widgets/custom_app_bar.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_text_field.dart';

class AddBankView extends StatelessWidget {
  const AddBankView({super.key});

  @override
  Widget build(BuildContext context) => GetBuilder<AddBankDetailController>(
        builder: (controller) => Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: CustomAppbarWidget(
            title: TranslationKeys.addBank.tr,
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
                            maxLines: 1,
                            minLines: 1,
                            controller:
                                controller.bankNameTextEditingController,
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
                            maxLines: 1,
                            minLines: 1,
                            controller:
                                controller.holderNameTextEditingController,
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
                            maxLines: 1,
                            minLines: 1,
                            maxLength: 12,
                            controller:
                                controller.accountNumberTextEditingController,
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
                            maxLines: 1,
                            minLines: 1,
                            maxLength: 8,
                            controller:
                                controller.routingNumberTextEditingController,
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
                Dimens.boxHeight32,
              ],
            ),
          ),
        ),
      );
}
