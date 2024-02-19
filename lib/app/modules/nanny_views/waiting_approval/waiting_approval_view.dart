import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';

import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';

class WaitingApprovalView extends StatelessWidget {
  WaitingApprovalView({super.key});
  final selectedInterface = Get.arguments;
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Padding(
          padding: Dimens.edgeInsets16,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(Assets.iconsTimer),
                Dimens.boxHeight10,
                AppText(
                  text: TranslationKeys.waitingForApproval.tr,
                  style: AppStyles.ubBlack24W700,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                ),
                Dimens.boxHeight10,
                AppText(
                  text: TranslationKeys.submissionPendingForApproval.tr,
                  style: AppStyles.ubGrey16W500,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                ),
                Dimens.boxHeight8,
                AppText(
                  text: TranslationKeys.administrationReviewOrApproveIt.tr,
                  style: AppStyles.ubGrey16W500,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ),
      );
}
