import 'package:flutter/material.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';

class CustomNewMessageCountIcon extends StatelessWidget {
  final String count;

  const CustomNewMessageCountIcon({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimens.eighteen,
      width: Dimens.eighteen,
      decoration: BoxDecoration(
        color: AppColors.navyBlue3288DE,
        borderRadius: BorderRadius.circular(Dimens.fifty),
      ),
      child: Center(
        child: Text(
          count,
          textAlign: TextAlign.center,
          style: AppStyles.ubHintColor9W600,
        ),
      ),
    );
  }
}
