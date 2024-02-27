import 'package:flutter/material.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_dot.dart';

class CustomChildAgeGenderTile extends StatelessWidget {
  final String age;
  final String gender;

  const CustomChildAgeGenderTile(
      {super.key, required this.age, required this.gender});

  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppText(
            text: "Age $age",
            style: AppStyles.ub5E5F60Grey12W500,
          ),
          Dimens.boxWidth4,
          CustomDot(
            size: Dimens.three,
            color: AppColors.greyColor,
          ),
          Dimens.boxWidth4,
          AppText(
            text: gender ,
            style: AppStyles.ub5E5F60Grey12W500,
          ),
        ],
      );
}
