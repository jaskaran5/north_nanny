import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
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
    return Container(
      padding: Dimens.edgeInsets10,
      margin: Dimens.edgeInsetsB10,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimens.sixteen),
        border: Border.all(
          color: isExpand ? AppColors.navyBlue : Colors.white,
          width: Dimens.two,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.lightNavyBlue.withOpacity(.8),
            blurRadius: Dimens.seven,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: Get.width / 1.3,
                child: AppText(
                  text: title,
                  style: AppStyles.ubBlack16W600,
                  textAlign: TextAlign.left,
                ),
              ),
              GestureDetector(
                onTap: onTap,
                child: SvgPicture.asset(
                  isExpand ? Assets.iconsMinusCirlce : Assets.iconsAddCircle,
                  height: Dimens.twenty,
                  width: Dimens.twenty,
                ),
              ),
            ],
          ),
          isExpand ? Dimens.boxHeight8 : Dimens.box0,
          Visibility(
            visible: isExpand,
            child: Text(
              subtitle,
              style: AppStyles.ub5E5F60Grey14W400,
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}
