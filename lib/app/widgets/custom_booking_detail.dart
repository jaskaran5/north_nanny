import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/res/constants/enums.dart';
import 'package:northshore_nanny_flutter/app/res/constants/extensions.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/utils/utility.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';

class CustomBookingDetailView extends StatelessWidget {
  const CustomBookingDetailView(
      {super.key,
      required this.bookingHeader,
      required this.time,
      required this.location,
      required this.date,
      required this.hours});

  final String bookingHeader;
  final String time;
  final String location;
  final DateTime? date;
  final String hours;

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
            if (location.isNotEmpty) ...[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    BookingDetails.location.bookingDetailSvg,
                    height: Dimens.thirteen,
                    width: Dimens.twelve,
                  ),
                  Dimens.boxWidth8,
                  AppText(
                    text: location.toString(),
                    style: AppStyles.ubGrey15W500,
                    maxLines: 1,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ],
            if (hours.isNotEmpty) ...[
              Dimens.boxHeight10,
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    BookingDetails.hours.bookingDetailSvg,
                    height: Dimens.thirteen,
                    width: Dimens.twelve,
                  ),
                  Dimens.boxWidth8,
                  AppText(
                    text: '$hours Minutes',
                    style: AppStyles.ubGrey15W500,
                    maxLines: 1,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              Dimens.boxHeight10,
            ],
            if (date != null) ...[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    BookingDetails.date.bookingDetailSvg,
                    height: Dimens.thirteen,
                    width: Dimens.twelve,
                  ),
                  Dimens.boxWidth8,
                  AppText(
                    text: Utility.convertDatetimeToMMMMddYYYY(date!),
                    style: AppStyles.ubGrey15W500,
                    maxLines: 1,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              Dimens.boxHeight8,
            ],
            if (time.isNotEmpty)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    BookingDetails.time.bookingDetailSvg,
                    height: Dimens.thirteen,
                    width: Dimens.twelve,
                  ),
                  Dimens.boxWidth8,
                  AppText(
                    text: time.toString(),
                    style: AppStyles.ubGrey15W500,
                    maxLines: 1,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
          ],
        ),
      );
}
