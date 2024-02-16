import 'package:flutter/material.dart';
import 'package:northshore_nanny_flutter/res/res.dart';
import 'package:northshore_nanny_flutter/widgets/app_text.dart';
import 'package:northshore_nanny_flutter/widgets/custom_app_bar.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView(
      {super.key,
      required this.appBarTitle,
      required this.privacyText,
      required this.privacySecondText,
      required this.headingText});

  final String appBarTitle;
  final String privacyText;
  final String privacySecondText;
  final String headingText;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: CustomAppbarWidget(
          title: appBarTitle,
        ),
        body: Padding(
          padding: Dimens.edgeInsets16,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: privacyText,
                style: AppStyles.ubBlack14W400,
                textAlign: TextAlign.start,
              ),
              Dimens.boxHeight10,
              AppText(
                text: headingText,
                style: AppStyles.ubBlack16W600,
                textAlign: TextAlign.start,
              ),
              Dimens.boxHeight10,
              AppText(
                text: privacySecondText,
                style: AppStyles.ubBlack14W400,
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
      );
}
