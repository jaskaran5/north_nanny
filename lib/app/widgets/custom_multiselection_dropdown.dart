import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';

class MultiDropDownAppDropdown<T> extends StatelessWidget {
  final ValueChanged<dynamic>? onChanged;
  final List<String>? items;
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
  final List<String>? selectedItem;
  final double? maxHeight;
  final double? mainHeight;
  final InputDecoration? dropdownSearchDecoration;
  final Widget? prefix;
  final String? hintText;

  final ScrollPhysics itemBuilderPhysics;
  final void Function(List<dynamic>, dynamic) onItemRemoved;

  const MultiDropDownAppDropdown({
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
    required this.onItemRemoved,
    this.dropdownSearchDecoration,
    this.prefix,
    this.itemBuilderPhysics = const NeverScrollableScrollPhysics(),
    this.mainHeight,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width ?? Get.width,
        child: DropdownSearch<dynamic>.multiSelection(
          dropdownDecoratorProps: DropDownDecoratorProps(
            baseStyle: baseTextStyle ?? AppStyles.ubNavyBlue15W600,
            dropdownSearchDecoration: dropdownSearchDecoration ??
                InputDecoration(
                  hintText: hintText,
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
          popupProps: PopupPropsMultiSelection.menu(
            onItemRemoved: onItemRemoved,
            selectionWidget: (context, item, isSelected) {
              return isSelected
                  ? Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: SvgPicture.asset(Assets.iconsCircleTick),
                    )
                  : const SizedBox();
            },
            itemBuilder: itemBuilder,
            listViewProps: ListViewProps(physics: itemBuilderPhysics),
            // constraints: const BoxConstraints(
            //     // minHeight: mainHeight ?? Dimens.ninety,
            //     // maxHeight: maxHeight ?? Dimens.hundredFive
            //     ),
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
          selectedItems: selectedItem!,
        ));
  }
}
