import 'package:flutter/material.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_dot.dart';

class CustomDotText extends StatelessWidget {
  final String description;

  final String heading;

  const CustomDotText({
    super.key,
    required this.heading,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Dimens.edgeInsets0_8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomDot(
                size: Dimens.four,
                color: AppColors.blackColor,
              ),
              Dimens.boxWidth4,

              // Text("asdfadsf"),
              AppText(
                text: heading,
                style: AppStyles.b0b0Urban14w600,
              ),
            ],
          ),
          Dimens.boxHeight10,
          Padding(
            padding: EdgeInsets.only(left: Dimens.ten),
            child: AppText(
              text: description,
              style: AppStyles.ub5E5F60Grey12W500,
              textAlign: TextAlign.left,
            ),
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
