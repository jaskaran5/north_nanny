import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/res/constants/enums.dart';
import 'package:northshore_nanny_flutter/app/res/constants/extensions.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';

class CustomBookingReceiptTile extends StatelessWidget {
  const CustomBookingReceiptTile({
    super.key,
    required this.receiptHeader,
    required this.totalPriceReceived,
    this.shoBorder = true,
    this.showHeader = true,
    this.isReferralBonus = false,
    this.serviceFees = 0.0,
    required this.childCount,
    required this.servicesList,
    required this.totalTimeHour,
    required this.totalTimeHourPrice,
    this.netPayBalAmount = 0.0,
    this.isMinus = true,
  });

  final String receiptHeader;
  final dynamic totalPriceReceived;
  final double netPayBalAmount;
  final int childCount;
  final dynamic totalTimeHour;
  final dynamic totalTimeHourPrice;

  final List<String> servicesList;
  final bool shoBorder;
  final bool showHeader;
  final bool isReferralBonus;
  final bool isMinus;
  final dynamic serviceFees;

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
              servicesList.length,
              (index) => Padding(
                padding: Dimens.edgeInsetsB10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      text: servicesList[index].toString().capitalizeFirst,
                      style: AppStyles.ubGrey15W500,
                      maxLines: 1,
                      textAlign: TextAlign.start,
                    ),
                    AppText(
                      text: "\$10",
                      style: AppStyles.ubGrey15W500,
                      maxLines: 1,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  text: childCount == 1
                      ? '${childCount.toString()} ${TranslationKeys.child.tr}'
                      : '${childCount.toString()} ${TranslationKeys.children.tr}',
                  style: AppStyles.ubGrey15W500,
                  maxLines: 1,
                  textAlign: TextAlign.start,
                ),
                AppText(
                  text:
                      "\$${childCount == 1 ? HourlyChildrenRateList.oneChild.ratePricePerChildren : childCount == 2 ? HourlyChildrenRateList.twoChildren.ratePricePerChildren : childCount == 3 ? HourlyChildrenRateList.threeChildren.ratePricePerChildren : childCount == 4 ? HourlyChildrenRateList.forChildren.ratePricePerChildren : '0.0'}",
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
                  text: 'Total Time : ${totalTimeHour.toString()} Minutes',
                  style: AppStyles.ubGrey15W500,
                  maxLines: 1,
                  textAlign: TextAlign.start,
                ),
                AppText(
                  text: "\$$totalTimeHourPrice",
                  style: AppStyles.ubGrey15W500,
                  maxLines: 1,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            Dimens.boxHeight10,
            if (serviceFees != 0.0) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    text: 'Service fees',
                    style: AppStyles.ubGrey15W500,
                    maxLines: 1,
                    textAlign: TextAlign.start,
                  ),
                  AppText(
                    text: '\$${serviceFees.toStringAsFixed(2)} ',
                    style: AppStyles.ubGrey15W500,
                    maxLines: 1,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              Dimens.boxHeight10,
            ],
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
                  text:
                      '\$${double.parse(totalPriceReceived.toString()).toStringAsFixed(2)}',
                  style: AppStyles.ubBlack15W600,
                  maxLines: 1,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            if (isReferralBonus) ...[
              Dimens.boxHeight10,
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
                    text: isMinus ? '-\$5' : '+\$5',
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
                    text: '\$${netPayBalAmount.toStringAsFixed(2)} ',
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
