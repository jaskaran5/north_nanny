import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';

class CustomBookingReceiptTile extends StatelessWidget {
  const CustomBookingReceiptTile(
      {super.key,
      required this.receiptHeader,
      required this.receiptDetailsList,
      required this.totalPriceReceived,
      required this.receiptPricesList,
      this.shoBorder = true,
      this.showHeader = true,
      this.isReferralBonus = false,
      this.netPayAbleAmount = 0});

  final String receiptHeader;
  final int totalPriceReceived;
  final int netPayAbleAmount;
  final List receiptDetailsList;
  final List<int> receiptPricesList;
  final bool shoBorder;
  final bool showHeader;
  final bool isReferralBonus;

  @override
  Widget build(BuildContext context) => Container(
        padding: Dimens.edgeInsets16,
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            Dimens.fourteen,
          ),
          border: shoBorder
              ? Border.all(color: AppColors.navyBlue, width: Dimens.two)
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showHeader) ...[
              AppText(
                text: receiptHeader,
                style: AppStyles.ubBlack14W700,
                maxLines: 1,
                textAlign: TextAlign.start,
              ),
              Dimens.boxHeight10,
            ],
            ...List.generate(
              receiptDetailsList.length,
              (index) => Padding(
                padding: Dimens.edgeInsetsB10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      text: receiptDetailsList[index].toString(),
                      style: AppStyles.ubGrey15W500,
                      maxLines: 1,
                      textAlign: TextAlign.start,
                    ),
                    AppText(
                      text: "\$${receiptPricesList[index].toString()}",
                      style: AppStyles.ubGrey15W500,
                      maxLines: 1,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            ),
            Dimens.boxHeight10,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  text: 'Total',
                  style: AppStyles.ubBlack15W600,
                  maxLines: 1,
                  textAlign: TextAlign.start,
                ),
                AppText(
                  text: '\$${totalPriceReceived.toString()}',
                  style: AppStyles.ubBlack15W600,
                  maxLines: 1,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            Dimens.boxHeight10,
            if (isReferralBonus) ...[
              Divider(
                color: AppColors.dividerColor,
                height: Dimens.one,
              ),
              Dimens.boxHeight10,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    text: 'Referral bonus',
                    style: AppStyles.ubGrey15W500,
                    maxLines: 1,
                    textAlign: TextAlign.start,
                  ),
                  AppText(
                    text: '-\$5',
                    style: AppStyles.ubGrey15W500,
                    maxLines: 1,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              Dimens.boxHeight10,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    text: 'Total payable amount ',
                    style: AppStyles.ubBlack15W600,
                    maxLines: 1,
                    textAlign: TextAlign.start,
                  ),
                  AppText(
                    text: '\$$netPayAbleAmount',
                    style: AppStyles.ubBlack15W600,
                    maxLines: 1,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              Dimens.boxHeight4,
            ],
          ],
        ),
      );
}
