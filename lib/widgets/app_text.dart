import 'package:flutter/material.dart';
import 'package:northshore_nanny_flutter/res/res.dart';

class AppText extends StatelessWidget {
  final dynamic text;
  final dynamic color;
  final dynamic underlineColor;
  final TextStyle? style;
  final bool? underline;
  final bool? strikeThrough;
  final double? textSize;
  final bool? capitalise;
  final int? maxLines;
  final TextAlign? textAlign;
  final String? fontFamily;
  final FontWeight? fontWeight;
  final double? lineHeight;
  final FontStyle? fontStyle;
  final double? letterSpacing;
  final TextOverflow? overflow;
  final TextDecoration? textDecoration;

  const AppText({
    super.key,
    required this.text,
    this.color,
    this.style,
    this.maxLines,
    this.textAlign,
    this.underline,
    this.textSize,
    this.fontFamily,
    this.fontWeight,
    this.lineHeight,
    this.fontStyle,
    this.underlineColor,
    this.strikeThrough,
    this.capitalise,
    this.letterSpacing,
    this.overflow,
    this.textDecoration = TextDecoration.none,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      capitalise != null && capitalise!
          ? text.toString().toUpperCase()
          : text.toString(),
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      textAlign: textAlign ?? TextAlign.center,
      style: style ??
          TextStyle(
            overflow: overflow,
            color: color,
            letterSpacing: letterSpacing,
            fontWeight: fontWeight ?? FontWeight.w500,
            fontSize: textSize,
            fontStyle: fontStyle ?? FontStyle.normal,
            height: lineHeight ?? 1.0,
            fontFamily: fontFamily ?? AppConstants.fontFamilyUrbanist,
            decorationColor: underlineColor ?? AppColors.primaryColor,
            decorationThickness: 1,
            decoration: textDecoration,
          ),
    );
  }
}
