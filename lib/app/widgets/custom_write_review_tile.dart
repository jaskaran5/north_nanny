import 'package:flutter/material.dart';
import 'package:northshore_nanny_flutter/app/res/constants/string_contants.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';

class CustomWriteReviewTile extends StatelessWidget {
  const CustomWriteReviewTile(
      {super.key,
      required this.writeAReviewController,
      required this.logInType});
  final TextEditingController writeAReviewController;
  final String logInType;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: Dimens.two, color: AppColors.navyBlue),
        borderRadius: BorderRadius.circular(
          Dimens.ten,
        ),
      ),
      //=====//
      child: Padding(
        padding: EdgeInsets.all(Dimens.eight),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            AppText(
              text: "Write a review",
              style: AppStyles.ubBlack14W700,
              textAlign: TextAlign.start,
              maxLines: 1,
            ),
            Dimens.boxHeight14,
            Padding(
              padding: Dimens.edgeInsets4,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Dimens.eight),
                child: TextFormField(
                  controller: writeAReviewController,
                  minLines: 5,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: logInType != StringConstants.customer
                        ? "Please let us know how the job went!"
                        : "Let us know how your nanny did!",
                    hintStyle: AppStyles.ubHintColor15W500,
                    fillColor: AppColors.lightNavyBlue.withOpacity(.5),
                    filled: true,
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
