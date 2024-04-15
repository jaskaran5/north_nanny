import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';

class MultiSelectDialogChildren extends StatefulWidget {
  final List<dynamic> options;
  final List<String> selectedOptions;
  final String title;
  final VoidCallback? onTapOnAddChild;

  const MultiSelectDialogChildren({
    super.key,
    required this.options,
    required this.selectedOptions,
    required this.title,
    required this.onTapOnAddChild,
  });

  @override
  MultiSelectDialogChildrenState createState() =>
      MultiSelectDialogChildrenState();
}

class MultiSelectDialogChildrenState extends State<MultiSelectDialogChildren> {
  late List<String> _selectedOptions;

  @override
  void initState() {
    super.initState();
    _selectedOptions = List<String>.from(widget.selectedOptions);
  }

  bool get allSelected => _selectedOptions.length == widget.options.length;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: AppText(
                text: widget.title,
                style: AppStyles.ubBlack16W600,
              ),
            ),
            Dimens.boxHeight10,
            SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        // Toggle select all or deselect all items
                        if (allSelected) {
                          _selectedOptions.clear();
                        } else {
                          _selectedOptions.clear();
                          _selectedOptions.addAll(widget.options
                              .map((option) => option.toString()));
                        }
                      });
                    },
                    child: ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText(
                            text: "Select All",
                            style: AppStyles.ubNavyBlue16W700,
                            maxLines: 1,
                          ),
                          if (allSelected)
                            SvgPicture.asset(
                              Assets.iconsCircleTick,
                              width: 24,
                              height: 24,
                            ),
                        ],
                      ),
                    ),
                    // ),
                    // Row(
                    //   children: [
                    //     const Text("Select All"),
                    //     if (allSelected)
                    //       SvgPicture.asset(
                    //         Assets.iconsCircleTick,
                    //         width: 24,
                    //         height: 24,
                    //       ),
                    //   ],
                    // ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: widget.options.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      return ListTile(
                        tileColor: Colors.transparent,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppText(
                              text: widget.options[index].toString(),
                              style: AppStyles.ubNavyBlue16W700,
                              maxLines: 1,
                            ),
                            if (_selectedOptions
                                    .contains(widget.options[index]) ||
                                allSelected)
                              SvgPicture.asset(
                                Assets.iconsCircleTick,
                                width: 24,
                                height: 24,
                              ),
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            final option = widget.options[index].toString();
                            if (_selectedOptions.contains(option)) {
                              _selectedOptions.remove(option);
                            } else {
                              _selectedOptions.add(option);
                            }
                          });
                        },
                        selected:
                            _selectedOptions.contains(widget.options[index]),
                        // selectedTileColor: Colors.grey.withOpacity(0.3),
                      );
                    },
                  ),
                ],
              ),
            ),
            Dimens.boxHeight10,
            GestureDetector(
              onTap: widget.onTapOnAddChild,
              child: AppText(
                text: "+ Add Child",
                style: AppStyles.ubBlack16W600,
              ),
            ),
            Dimens.boxHeight10,
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    AppColors.navyBlue), // Change the color here
              ),
              onPressed: () {
                Navigator.of(context).pop(_selectedOptions);
              },
              child: AppText(
                text: 'OK',
                style: AppStyles.ubWhite15700,
              ),
            ),
            Dimens.boxHeight10,
          ],
        ),
      ),
    );
  }
}
