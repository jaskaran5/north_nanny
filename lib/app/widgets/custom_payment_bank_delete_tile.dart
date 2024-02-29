import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';

class CustomPaymentBankDeleteTile extends StatelessWidget {
  final String accountNumber;
  final String assest;
  final String cardType;
  final Function() onTapButton;

  const CustomPaymentBankDeleteTile({
    super.key,
    required this.accountNumber,
    required this.assest,
    required this.cardType,
    required this.onTapButton,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: Dimens.fiftyFive + Dimens.three,
              width: Dimens.fiftyFive + Dimens.three,
              padding: Dimens.edgeInsets6,
              decoration: BoxDecoration(
                color: AppColors.colorEEF5FCLightNavyBlue,
                borderRadius: BorderRadius.circular(Dimens.ten),
              ),
              child: SvgPicture.asset(assest),
            ),
            Dimens.boxWidth10,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: accountNumber,
                  maxLines: 1,
                  style: AppStyles.ubBlack16W600,
                ),
                Dimens.boxHeight4,
                AppText(
                  text: cardType,
                  maxLines: 1,
                  style: AppStyles.ubGrey12W500,
                )
              ],
            ),
          ],
        ),
        GestureDetector(
          onTap: onTapButton,
          child: SvgPicture.asset(
            Assets.iconsDelete,
            height: Dimens.thirty,
            width: Dimens.thirty,
          ),
        )
      ],
    );
  }
}
