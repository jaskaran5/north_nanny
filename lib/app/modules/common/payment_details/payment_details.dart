import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_app_bar.dart';

class PaymentDetails extends StatelessWidget {
  const PaymentDetails({
    super.key,
    required this.paymentDetails,
  });
  final Map<String, String> paymentDetails;
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: CustomAppbarWidget(
          title: TranslationKeys.paymentDetails.tr,
        ),
        body: Padding(
          padding: Dimens.edgeInsets16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              paymentDetails.length,
              (index) => Container(
                padding: Dimens.edgeInsetsT16B16,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.navyBlue,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(Dimens.twenty),
                ),
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
                          child: SvgPicture.asset(
                              paymentDetails['asset'].toString()),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              text: paymentDetails['accountNumber'].toString(),
                              maxLines: 1,
                              style: AppStyles.ubBlack16W600,
                            ),
                            Dimens.boxHeight8,
                            AppText(
                              text: paymentDetails['cardType'].toString(),
                              maxLines: 1,
                              style: AppStyles.ubGrey12W500,
                            )
                          ],
                        ),
                      ],
                    ),
                    SvgPicture.asset(
                      paymentDetails['isSelected'] == true
                          ? Assets.iconsCircleTick
                          : Assets.iconsUncheckCircle,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
