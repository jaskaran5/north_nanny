import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/res/res.dart';

import 'app_text.dart';

class CustomAppbarWidget extends PreferredSize {
  final String? title;
  final String? fontFamily;

  final Color? backgroundColor;
  final Color? textColor;
  final TextStyle? textStyle;
  final List<Widget>? actions;
  final Function()? onActionButtonTap, onBackPress;
  final double? actionButtonWidth;
  final Widget? titleWidget, leading, bottom;
  final bool addBackButton;
  final bool? centerTitle;
  final double? titleSize;
  final bool? isLeading;
  final bool toUpperCaseTitle;
  final double? leadingWidth;

  const CustomAppbarWidget({
    super.key,
    this.title = '',
    this.titleWidget,
    this.leading,
    this.addBackButton = true,
    this.toUpperCaseTitle = true,
    this.onBackPress,
    this.textColor,
    this.backgroundColor,
    this.textStyle,
    this.actions,
    this.onActionButtonTap,
    this.actionButtonWidth = 50,
    this.bottom,
    this.centerTitle,
    this.titleSize,
    this.isLeading,
    this.leadingWidth,
    this.fontFamily,
  })  : assert(
          textColor == null || textStyle == null,
          'Cannot provide both a textColor and a textStyle\n'
          'To provide both, use "textStyle: TextStyle(color: color)".',
        ),
        super(
            child: const SizedBox.shrink(),
            preferredSize: const Size.fromHeight(60.0)
            // Size.fromHeight(bottom == null ? kToolbarHeight : 50.h),
            );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: backgroundColor ?? AppColors.primaryColor,
      leading: addBackButton
          ? InkWell(
              onTap: onBackPress ?? () => Get.back(),
              child: Padding(
                padding: Dimens.edgeInsetsL15,
                child: SvgPicture.asset(
                  Assets.iconsBack,
                  height: Dimens.fortyOne,
                  width: Dimens.fortyOne,
                  alignment: Alignment.center,
                ),
              ),
            )
          : null,
      title: titleWidget ??
          AppText(
            text: toUpperCaseTitle ? title?.toUpperCase() : title,
            color: AppColors.blackColor,
            textSize: Dimens.twentyFour,
            fontFamily: fontFamily ?? AppConstants.fontFamilyUrbanist,
            fontWeight: FontWeight.w400,
          ),
      centerTitle: centerTitle ?? true,
      actions: actions,
      leadingWidth: Dimens.sixty,
      toolbarHeight: Dimens.sixty,
    );
  }
}
