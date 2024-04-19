import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/nanny/nanny_views/bank_details/add_bank_detail_controller.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_app_bar.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_button.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_payment_bank_delete_tile.dart';
import 'package:northshore_nanny_flutter/navigators/routes_management.dart';

class NannyUpdateSettingBankDetailsView extends StatelessWidget {
  const NannyUpdateSettingBankDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddBankDetailController>(
      init: AddBankDetailController(),
      initState: (_) {
        Get.find<AddBankDetailController>().getBankDetails();
      },
      builder: (controller) => Scaffold(
        appBar: CustomAppbarWidget(
          title: TranslationKeys.bankDetails.tr,
        ),
        body: Padding(
          padding: Dimens.edgeInsets16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              controller.bankDetailResponse?.data != null
                  ? Expanded(
                      child: Column(
                        children: [
                          CustomPaymentBankDeleteTile(
                            accountNumber:
                                "XXXXXXXX${controller.bankDetailResponse?.data?.accountNumber?.substring(5)}",
                            cardType:
                                controller.bankDetailResponse?.data?.bankName ??
                                    '',
                            onTapButton: () {
                              /// used to delete the bank details.
                              controller.deleteBankDetails();
                            },
                            userName: controller
                                    .bankDetailResponse?.data?.accountHolderName
                                    .toString() ??
                                '',
                          ),
                        ],
                      ),
                    )
                  : Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: AppText(
                          text: TranslationKeys.noResultFound.tr,
                          style: AppStyles.pdNavyBlue20W600,
                        ),
                      ),
                    ),
              if (controller.bankDetailResponse?.data == null) ...[
                CustomButton(
                  title: TranslationKeys.addBank.tr,
                  backGroundColor: AppColors.navyBlue,
                  onTap: () {
                    RouteManagement.goToAddBankView(isComeFromBooking: false);
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
