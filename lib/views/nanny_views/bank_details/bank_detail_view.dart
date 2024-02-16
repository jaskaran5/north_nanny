import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/controllers/sitter_controllers/create_profile/create_sitter_profile.dart';
import 'package:northshore_nanny_flutter/res/res.dart';
import 'package:northshore_nanny_flutter/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/widgets/widgets.dart';

import '../waiting_approval/waiting_approval_view.dart';

class BankDetailsView extends StatelessWidget {
  BankDetailsView({super.key});
  final selectedInterface = Get.arguments;
  @override
  Widget build(BuildContext context) =>
      GetBuilder<CreateSitterProfileController>(
        builder: (controller) => Scaffold(
          appBar: CustomAppbarWidget(
            title: TranslationKeys.bankDetails.tr,
          ),
          bottomSheet: Container(
            padding: Dimens.edgeInsets16,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                  title: TranslationKeys.addBank.tr,
                  backGroundColor: AppColors.navyBlue,
                  onTap: () {
                    Get.to(
                      WaitingApprovalView(),
                      arguments: selectedInterface,
                    );
                  },
                ),
                Dimens.boxHeight10,
                CustomButton(
                  title: TranslationKeys.skipForNow.tr,
                  backGroundColor: AppColors.lightNavyBlue,
                  textColor: AppColors.navyBlue,
                  onTap: () {
                    Get.to(
                      WaitingApprovalView(),
                      arguments: selectedInterface,
                    );
                  },
                ),
              ],
            ),
          ),
          body: GestureDetector(
            onTap: Get.focusScope?.unfocus,
            child: Padding(
              padding: Dimens.edgeInsets16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: controller.bankNameTextEditingController,
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
                    controller: controller.holderNameTextEditingController,
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
                    controller: controller.accountNumberTextEditingController,
                    maxLines: 1,
                    minLines: 1,
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
                    keyboardType: TextInputType.text,
                  ),
                  Dimens.boxHeight20,
                  TextField(
                    controller: controller.routingNumberTextEditingController,
                    maxLines: 1,
                    minLines: 1,
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
                    keyboardType: TextInputType.text,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
