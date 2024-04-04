import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/res/constants/enums.dart';
import 'package:northshore_nanny_flutter/app/res/constants/extensions.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';

class CustomBookingServiceTile extends StatelessWidget {
  const CustomBookingServiceTile(
      {super.key,
      required this.serviceHeader,
      required this.serviceDetailsList});

  final String serviceHeader;
  final List<String> serviceDetailsList;

  @override
  Widget build(BuildContext context) => Container(
        padding: Dimens.edgeInsets16,
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            Dimens.fourteen,
          ),
          border: Border.all(color: AppColors.navyBlue, width: Dimens.two),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              text: serviceHeader,
              style: AppStyles.ubBlack14W700,
              maxLines: 1,
              textAlign: TextAlign.start,
            ),
            Dimens.boxHeight10,
            ...List.generate(
              serviceDetailsList.length,
              (index) => Padding(
                padding: Dimens.edgeInsetsB10,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      Services.values
                          .firstWhere((element) =>
                              element.serviceName ==
                              serviceDetailsList[index].toString())
                          .servicesSvg,
                      height: Dimens.thirteen,
                      width: Dimens.twelve,
                    ),
                    Dimens.boxWidth8,
                    AppText(
                      text: Services.values
                          .firstWhere((element) =>
                      element.serviceName ==
                          serviceDetailsList[index].toString())
                          .serviceName.tr,
                      style: AppStyles.ubGrey15W500,
                      maxLines: 1,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
