import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/res/res.dart';

class AppDropdown<T> extends StatelessWidget {
  final ValueChanged<dynamic>? onChanged;
  final List<dynamic>? items;
  final String? title;
  final double? textSize;
  final double? height;
  final double? width;
  final FontWeight? fontWeight;
  final Widget? dropDownButton;
  final Color? color;
  final Color? baseColor;
  final Color? textColor;
  final DropdownButtonProps? dropDownButtonProps;
  final DropdownSearchPopupItemBuilder<dynamic> itemBuilder;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? textPadding;
  final bool? enableHeading;
  final bool? isSelected;
  final TextStyle? hintTextStyle;
  final TextStyle? baseTextStyle;
  final T? selectedItem;
  final double? maxHeight;
  final double? mainHeight;
  final InputDecoration? dropdownSearchDecoration;
  final Widget? prefix;
  final ScrollPhysics itemBuilderPhysics;

  const AppDropdown({
    super.key,
    required this.selectedItem,
    required this.onChanged,
    required this.items,
    this.dropDownButton,
    this.dropDownButtonProps,
    this.title,
    this.margin,
    this.textSize,
    this.fontWeight,
    this.color,
    this.textColor,
    this.height,
    this.width,
    this.padding,
    this.textPadding,
    this.enableHeading,
    this.hintTextStyle,
    required this.itemBuilder,
    this.maxHeight,
    this.baseColor,
    this.baseTextStyle,
    this.isSelected,
    this.dropdownSearchDecoration,
    this.prefix,
    this.itemBuilderPhysics = const NeverScrollableScrollPhysics(),
    this.mainHeight,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? Get.width,
      child: DropdownSearch<dynamic>(
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: baseTextStyle ?? AppStyles.ubNavyBlue15W600,
          dropdownSearchDecoration: dropdownSearchDecoration ??
              InputDecoration(
                prefixIcon: Padding(
                  padding: Dimens.edgeInsets12,
                  child: prefix,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.lightNavyBlue,
                    width: Dimens.one,
                  ),
                  borderRadius: BorderRadius.circular(
                    Dimens.eight,
                  ),
                ),
                hintMaxLines: 1,
                contentPadding: Dimens.edgeInsets16,
                hintStyle: AppStyles.ubHintColor15W500,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.lightNavyBlue,
                    width: Dimens.one,
                  ),
                  borderRadius: BorderRadius.circular(
                    Dimens.eight,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.lightNavyBlue,
                    width: Dimens.one,
                  ),
                  borderRadius: BorderRadius.circular(
                    Dimens.eight,
                  ),
                ),
              ),
        ),
        popupProps: PopupProps.menu(
          itemBuilder: itemBuilder,
          listViewProps: ListViewProps(physics: itemBuilderPhysics),
          constraints: BoxConstraints(
            minHeight: mainHeight ?? Dimens.ninty,
            maxHeight: maxHeight ?? Dimens.hundredFive,
          ),
          menuProps: MenuProps(
            shape: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(Dimens.eight),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        dropdownButtonProps: dropDownButtonProps ??
            DropdownButtonProps(
              iconSize: Dimens.twentyFive,
              icon: SvgPicture.asset(
                Assets.iconsDownArrow,
              ),
            ),
        onChanged: onChanged,
        items: items!,
        selectedItem: selectedItem,
      ),
    );
  }
}
