import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_button.dart';

class SuccessUnSuccessView extends StatelessWidget {
  const SuccessUnSuccessView({
    super.key,
    required this.buttonText,
    required this.successSvg,
    required this.header,
    required this.subHeader,
    this.onTapButton,
    this.buttonColor,
    this.headerStyle,
    this.subHeaderStyle,
    required this.subHeaderMaxLines,
    required this.headerMaxLines,
  });
  final String buttonText;
  final String successSvg;
  final String header;
  final String subHeader;
  final Function()? onTapButton;
  final Color? buttonColor;
  final TextStyle? headerStyle;
  final TextStyle? subHeaderStyle;
  final int subHeaderMaxLines;
  final int headerMaxLines;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Padding(
          padding: Dimens.edgeInsets16,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                successSvg,
                alignment: Alignment.center,
                height: Dimens.hundred,
                width: Dimens.hundred,
              ),
              Dimens.boxHeight24,
              AppText(
                text: header,
                style: headerStyle ?? AppStyles.ubDarkBlackColor26W700,
                maxLines: headerMaxLines,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
              Dimens.boxHeight14,
              SizedBox(
                width: Dimens.twoHundredFifty,
                child: AppText(
                  text: subHeader,
                  style: subHeaderStyle ?? AppStyles.ubGreyA116W500,
                  maxLines: subHeaderMaxLines,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
              Dimens.boxHeight32,
              CustomButton(
                title: buttonText,
                backGroundColor: buttonColor ?? AppColors.navyBlue,
                onTap: onTapButton,
              ),
            ],
          ),
        ),
      );
}
