import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/res/res.dart';

import 'app_text.dart';

// class CustomDropDown extends StatelessWidget {
//   const CustomDropDown({super.key});
//
//   final  List<String> itemsList;
//
//   @override
//   Widget build(BuildContext context) =>
// }

class AppDropdown<T> extends StatelessWidget {
  final ValueChanged<dynamic>? onChanged;
  final List<dynamic>? items;
  final String? hintText;
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
  final InputDecoration? dropdownSearchDecoration;

  const AppDropdown({
    super.key,
    required this.selectedItem,
    required this.onChanged,
    required this.items,
    required this.hintText,
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
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: title ?? "",
          fontWeight: fontWeight ?? FontWeight.w600,
          color: textColor ?? AppColors.blackColor,
        ),
        Container(
          height: height ?? Dimens.forty,
          margin: margin ?? EdgeInsets.zero,
          width: width ?? Get.width,
          child: DropdownSearch<dynamic>(
            dropdownDecoratorProps: DropDownDecoratorProps(
                baseStyle: baseTextStyle ?? AppStyles.ubNavyBlue15W700,
                dropdownSearchDecoration: dropdownSearchDecoration),
            popupProps: PopupProps.menu(
              itemBuilder: itemBuilder,
              constraints: BoxConstraints(
                maxHeight: maxHeight ?? 200,
              ),
              menuProps: MenuProps(
                shape: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(22),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            dropdownButtonProps: dropDownButtonProps ??
                const DropdownButtonProps(
                    padding: EdgeInsets.only(left: 20),
                    icon: Icon(
                      Icons.keyboard_arrow_down_outlined,
                      size: 25,
                    )),
            onChanged: onChanged,
            items: items!,
            selectedItem: selectedItem,
          ),
        ),
      ],
    );
  }
}

// class AppDropdownNoDecoration<T> extends StatelessWidget {
//   final ValueChanged<dynamic>? onChanged;
//   final List<dynamic>? items;
//
//   final double? textSize;
//   final double? height;
//   final double? width;
//   final FontWeight? fontWeight;
//   final Widget? dropDownButton;
//   final Color? color;
//   final Color? baseColor;
//   final Color? textColor;
//   final DropdownButtonProps? dropDownButtonProps;
//   final EdgeInsetsGeometry? margin;
//   final EdgeInsetsGeometry? padding;
//   final EdgeInsetsGeometry? textPadding;
//   final bool? enableHeading;
//   final bool? enabled;
//   final bool? isSelected;
//   final TextStyle? hintTextStyle;
//   final TextStyle? baseTextStyle;
//   final T? selectedItem;
//   final double? maxHeight;
//   final InputDecoration? dropdownSearchDecoration;
//
//   const AppDropdownNoDecoration({
//     Key? key,
//     required this.selectedItem,
//     required this.onChanged,
//     required this.items,
//     this.dropDownButton,
//     this.dropDownButtonProps,
//
//     this.margin,
//     this.textSize,
//     this.fontWeight,
//     this.color,
//     this.textColor,
//     this.height,
//     this.width,
//     this.padding,
//     this.textPadding,
//     this.enableHeading,
//     this.hintTextStyle,
//     this.maxHeight,
//     this.baseColor,
//     this.baseTextStyle,
//     this.enabled,
//     this.isSelected,
//     this.dropdownSearchDecoration,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           height: height ?? 35.h,
//           margin: margin ?? EdgeInsets.zero,
//           width: width ?? context.width,
//           decoration: BoxDecoration(
//               color: const Color(0xa5fff1df),
//               borderRadius: BorderRadius.circular(8.r)),
//           child: DropdownSearch<dynamic>(
//             enabled: enabled??false,
//             dropdownDecoratorProps: DropDownDecoratorProps(
//               baseStyle: baseTextStyle ??
//                   valueStyle,
//               dropdownSearchDecoration: dropdownSearchDecoration ??
//                   fieldDeco(
//
//                       prefixPadding: const EdgeInsets.only(left: 10),
//                       border: InputBorder.none,
//                       fillColor: AppColor.transparent,
//                       hintText:"Please Select"),
//             ),
//             popupProps: PopupProps.menu(
//               fit: FlexFit.loose,
//               itemBuilder: (BuildContext context, item, bool isSelected) {
//                 return Container(
//                   padding: EdgeInsets.only(top: 15,right: 15,left: 15,bottom: 5),
//                   margin: const EdgeInsets.symmetric(horizontal: 8),
//                   decoration: !isSelected
//                       ? null
//                       : BoxDecoration(
//                     border: Border.all(color: Theme.of(context).primaryColor),
//                     borderRadius: BorderRadius.circular(5),
//                     color: AppColor.themeSettingsfffbe9d0,
//                   ),
//                   child: AppText(text: item),
//                 );
//               },
//               constraints: BoxConstraints(
//                 maxHeight: maxHeight ?? 200,
//               ),
//               menuProps: MenuProps(
//                 shape: UnderlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                   borderSide: BorderSide.none,
//                 ),
//               ),
//             ),
//
//             dropdownButtonProps: dropDownButtonProps ??
//                 DropdownButtonProps(
//                     padding: EdgeInsets.only(left: 10, right: 0),
//                     icon: (enabled??false)?Icon(
//                       Icons.keyboard_arrow_down_outlined,
//                       size: 20,
//                     ):SizedBox.shrink()),
//             onChanged: onChanged,
//             items: items!,
//             selectedItem: selectedItem,
//           ),
//         ),
//       ],
//     );
//   }
// }
