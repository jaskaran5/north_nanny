import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/res/res.dart';
import 'package:northshore_nanny_flutter/widgets/app_text.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet(
      {super.key, required this.heading, required this.description});

  final String heading;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Dimens.edgeInsetsT16B16,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            Dimens.twenty,
          ),
          topRight: Radius.circular(
            Dimens.twenty,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: Dimens.edgeInsetsL10T10R16B10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: heading,
                  style: AppStyles.ubBlack16W700,
                  maxLines: 1,
                ),
                GestureDetector(
                  onTap: Get.back,
                  child: SvgPicture.asset(
                    Assets.iconsRemoveBottomSheet,
                  ),
                ),
              ],
            ),
          ),
          Divider(color: AppColors.dividerColor, height: Dimens.one),
          Padding(
            padding: Dimens.edgeInsets16,
            child: Text(
              description,
              style: AppStyles.ubGrey16W400,
            ),
          ),
        ],
      ),
    );
  }
}
