import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/res/constants/constants.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';

class CustomBookingDetailView extends StatelessWidget {
  const CustomBookingDetailView(
      {super.key,
      required this.bookingHeader,
      required this.bookingDetailsList});

  final String bookingHeader;
  final List<String> bookingDetailsList;

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
              text: bookingHeader,
              style: AppStyles.ubBlack14W700,
              maxLines: 1,
              textAlign: TextAlign.start,
            ),
            Dimens.boxHeight10,
            ...List.generate(
              bookingDetailsList.length,
              (index) => Padding(
                padding: Dimens.edgeInsetsB10,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      BookingDetails.values[index].bookingDetailSvg,
                      height: Dimens.thirteen,
                      width: Dimens.twelve,
                    ),
                    Dimens.boxWidth8,
                    AppText(
                      text: bookingDetailsList[index].toString(),
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
