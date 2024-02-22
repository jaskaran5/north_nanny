import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';

class CustomFAQTile extends StatelessWidget {
  final Function()? onTap;
  final bool isExpand;
  final String title;
  final String subtitle;

  const CustomFAQTile({
    super.key,
    required this.onTap,
    required this.isExpand,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        height: isExpand ? 100 : 51.0,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(
                color: isExpand ? AppColors.navyBlue : Colors.white, width: 2)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                AppText(
                  text: title,
                  style: AppStyles.ubBlack16W600,
                ),
                GestureDetector(
                  onTap: onTap,
                  child: SvgPicture.asset(
                    isExpand ? Assets.iconsMinusCirlce : Assets.iconsAddCircle,
                    height: Dimens.twenty,
                    width: Dimens.twenty,
                  ),
                ),
              ]),
              Visibility(
                  visible: isExpand,
                  child: Text(
                    subtitle,
                    style: AppStyles.ub5E5F60Grey14W400,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
