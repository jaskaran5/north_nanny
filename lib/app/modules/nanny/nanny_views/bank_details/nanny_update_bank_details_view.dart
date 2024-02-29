import 'package:flutter/material.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_payment_bank_delete_tile.dart';

class NannyUpdateSettingBankDetailsView extends StatelessWidget {
  const NannyUpdateSettingBankDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
      itemCount: 5,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return CustomPaymentBankDeleteTile(
          accountNumber: "XXXXXXXXXX9586",
          assest: Assets.iconsSearch,
          cardType: "VISA",
          onTapButton: () {},
        );
      },
    ));
  }
}
