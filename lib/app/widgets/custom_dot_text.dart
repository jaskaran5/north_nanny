import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_dot.dart';

class CustomDotText extends StatelessWidget {
  final String description;

  final String heading;
  final TextStyle? headingStyle;

  const CustomDotText({
    super.key,
    required this.heading,
    required this.description,
    this.headingStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Dimens.edgeInsets8,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: Dimens.edgeInsetsT5,
            child: CustomDot(
              size: Dimens.four,
              color: AppColors.blackColor,
            ),
          ),
          Dimens.boxWidth4, // boxWidth8 changes to boxWidth2
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              AppText(
                text: heading,
                style: headingStyle ?? AppStyles.ubBlack14W600,
                maxLines: 1,
                textAlign: TextAlign.left,
              ),
              Dimens.boxHeight4,
              Container(
                constraints: BoxConstraints(
                  maxWidth: Get.width * .7,
                ),
                child: AppText(
                  text: description,
                  style: AppStyles.ubGrey12W500,
                  textAlign: TextAlign.left,
                  maxLines: 10,
                ),
              ),
            ],
          ),
        ],
      ),
    );

    // SizedBox(
    //   // width: Get.width,
    //   child: Padding(
    //     padding: Dimens.edgeInsets10,
    //     child: Column(
    //       // crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Row(
    //           children: [
    //             const CustomDot(size: 4.16),
    //             Dimens.boxWidth10,
    //             Column(
    //               children: [
    //                 AppText(
    //                   text: heading,
    //                   style: AppStyles.b0b0Urban14w600,
    //                 ),
    //                 AppText(
    //                   text: description,
    //                   style: AppStyles.ub5E5F60Grey12W500,
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
