import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';

class CustomPaymentBankDeleteTile extends StatelessWidget {
  final String accountNumber;
  final String cardType;
  final String userName;
  final Function() onTapButton;

  const CustomPaymentBankDeleteTile({
    super.key,
    required this.accountNumber,
    required this.cardType,
    required this.onTapButton,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Dimens.edgeInsetsL12T6R12B6,
      margin: Dimens.edgeInsetsB16,
      decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(Dimens.twelve),
          boxShadow: [
            BoxShadow(
              color: AppColors.lightNavyBlue.withOpacity(.8),
              blurRadius: Dimens.six,
            ),
          ]),
      child: Row(
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
                child: SvgPicture.asset(Assets.iconsBank),
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
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppText(
                        text: '$cardType  ',
                        maxLines: 1,
                        style: AppStyles.ubGrey12W500,
                      ),
                      AppText(
                        text: '| $userName',
                        maxLines: 1,
                        style: AppStyles.ubGrey12W500,
                      )
                    ],
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
      ),
    );
  }
}
