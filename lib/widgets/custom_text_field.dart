import 'package:flutter/material.dart';
import 'package:northshore_nanny_flutter/res/res.dart';

final customBorder = OutlineInputBorder(
  borderSide: BorderSide(
    color: AppColors.lightNavyBlue,
    width: Dimens.one,
  ),
  borderRadius: BorderRadius.circular(Dimens.eight),
);
InputDecoration customFieldDeco({
  String? labelText,
  String? hintText,
  IconData? prefixIcon,
  Widget? prefixWidget,
  Widget? suffix,
  InputBorder? border,
  InputBorder? focusBorder,
  InputBorder? focusErrorBorder,
  InputBorder? errorBorder,
  InputBorder? disableBorder,
  bool isFilled = true,
  bool value = false,
  double? yPadding,
  double? outlineBorderRadius,
  Color? borderColor = AppColors.navyBlue,
  String? helperText,
  Color? fillColor,
  TextStyle? hintStyle,
  BorderRadius? classBorderRadius,
}) {
  return InputDecoration(
    filled: isFilled,
    fillColor: fillColor ?? Colors.transparent,
    border: InputBorder.none,
    contentPadding: Dimens.edgeInsets16,
    labelText: labelText,
    hintText: hintText,
    counterText: '',
    labelStyle: AppStyles.ubBlack15W600,
    helperText: helperText,
    hintStyle:hintStyle ??  AppStyles.ubHintColor15W500,
    prefixIcon: prefixWidget ??
        (prefixIcon != null
            ? Icon(
                prefixIcon,
                size: Dimens.twenty,
              )
            : null),
    suffixIcon: suffix,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.lightNavyBlue,
        width: Dimens.one,
      ),
      borderRadius: BorderRadius.circular(Dimens.eight),
    ),
    disabledBorder: InputBorder.none,
    errorBorder: errorBorder ?? customBorder,
    focusedErrorBorder: focusErrorBorder ?? customBorder,
    focusedBorder: focusBorder ??
        OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.activeBorderColor,
            width: Dimens.one,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(Dimens.eight),
        ),
    // constraints: BoxConstraints.expand(
    //   height: Dimens.fiftyThree,
    //   width: Dimens.threeHundredThirtyOne,
    // ),
  );
}
