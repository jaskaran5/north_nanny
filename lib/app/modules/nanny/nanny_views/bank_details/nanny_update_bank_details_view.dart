import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_app_bar.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_button.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_payment_bank_delete_tile.dart';

import '../add_bank/add_bank_view.dart';

class NannyUpdateSettingBankDetailsView extends StatelessWidget {
  const NannyUpdateSettingBankDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbarWidget(
          title: TranslationKeys.bankDetails.tr,
        ),
        body: Padding(
          padding: Dimens.edgeInsets16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                itemCount: 1,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return CustomPaymentBankDeleteTile(
                    accountNumber: "XXXXXXXXXX9586",
                    asset: Assets.iconsAmericanBank,
                    cardType: "Bank of America ",
                    onTapButton: () {},
                    userName: 'Cristina Wang',
                  );
                },
              ),
              const Spacer(),
              CustomButton(
                title: TranslationKeys.addBank.tr,
                backGroundColor: AppColors.navyBlue,
                onTap: () {
                  Get.to(
                    const AddBankView(),
                  );
                },
              )
            ],
          ),
        ));
  }
}
