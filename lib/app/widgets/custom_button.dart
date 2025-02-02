import 'package:flutter/material.dart';
import 'package:northshore_nanny_flutter/app/res/constants/app_constants.dart';

import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';

class CustomButton extends StatefulWidget {
  final String? title;
  final double? borderRadius;
  final Widget? child;
  final double? textPadding;
  final EdgeInsetsGeometry? customPadding;
  final bool? loading;
  final double? width;
  final double? loaderWidth;
  final double? loaderHeight;
  final double? height;
  final VoidCallback? onTap;
  final Color? backGroundColor;
  final Color? loaderColor;
  final Color? borderColor;
  final Color? textColor;
  final double? textSize;
  final double? borderWidth;
  final TextStyle? titleStyle;
  final List<BoxShadow>? boxShadow;
  final EdgeInsetsGeometry? margin;

  const CustomButton({
    super.key,
    this.title,
    this.onTap,
    this.backGroundColor,
    this.titleStyle,
    this.textColor,
    this.child,
    this.borderColor,
    this.borderWidth,
    this.loaderWidth,
    this.loaderHeight,
    this.loading,
    this.borderRadius,
    this.loaderColor,
    this.width,
    this.height,
    this.textPadding,
    this.customPadding,
    this.boxShadow,
    this.textSize,
    this.margin,
  });

  @override
  State<CustomButton> createState() => CustomButtonState();
}

class CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: null,
      onTap: (widget.loading ?? false) ? null : widget.onTap,
      child: Container(
        width: widget.width ?? Dimens.threeHundredThirtyOne,
        height: widget.height ?? Dimens.fiftyThree,
        margin: widget.margin,
        decoration: BoxDecoration(
          color: widget.backGroundColor ?? AppColors.primaryColor,
          borderRadius:
              BorderRadius.circular(widget.borderRadius ?? Dimens.twelve),
          boxShadow: widget.boxShadow,
          border: Border.all(
            color: widget.borderColor ?? Colors.transparent,
            width: widget.borderWidth ?? Dimens.zero,
          ),
        ),
        child: Padding(
          padding: widget.customPadding ??
              EdgeInsets.all(widget.textPadding ?? Dimens.fifteen),
          child: Center(
            child: Text(
              (widget.title ?? ""),
              style: widget.titleStyle ??
                  TextStyle(
                    fontSize: widget.textSize ?? Dimens.fifteen,
                    fontFamily: AppConstants.fontFamilyUrbanist,
                    fontWeight: FontWeight.w600,
                    color: widget.textColor ?? AppColors.primaryColor,
                  ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
