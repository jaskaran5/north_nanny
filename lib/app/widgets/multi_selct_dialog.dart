import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';

class MultiSelectDialog extends StatefulWidget {
  final List<dynamic> options;
  final List<String> selectedOptions;
  final String title;

  const MultiSelectDialog({
    super.key,
    required this.options,
    required this.selectedOptions,
    required this.title,
  });

  @override
  MultiSelectDialogState createState() => MultiSelectDialogState();
}

class MultiSelectDialogState extends State<MultiSelectDialog> {
  final List<String> _selectedOptions = [];

  @override
  void initState() {
    super.initState();
    _selectedOptions.addAll(widget.selectedOptions);
  }

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
                text: widget.title.capitalizeFirst,
                style: AppStyles.ubBlack16W600,
                textAlign: TextAlign.center,
              ),
            ),
            Dimens.boxHeight10,
            SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
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
                                .contains(widget.options[index]))
                              SvgPicture.asset(
                                Assets.iconsCircleTick,
                                width: 24,
                                height: 24,
                              ),
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            if (_selectedOptions
                                .contains(widget.options[index])) {
                              _selectedOptions.remove(widget.options[index]);
                            } else {
                              _selectedOptions.add(widget.options[index]);
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
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(_selectedOptions);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    AppColors.navyBlue), // Change the color here
              ),
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
