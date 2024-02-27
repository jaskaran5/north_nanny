import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_app_bar.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_button.dart';

class CustomPaymentDetails extends StatelessWidget {
  const CustomPaymentDetails({
    super.key,
    required this.paymentDetails,
    required this.appBarTitle,
    required this.addNewCardButtonTitle,
    required this.addNewCardButtonBackgroundColor,
    required this.onTapAddNewCardButton,
    required this.submitButtonTitle,
    required this.submitButtonBackgroundColor,
    required this.onTapSubmitButton,
    required this.onTapDeleteButton,
    required this.showDeleteButton,
    required this.addNewCardButtonStyle,
    required this.submitButtonStyle,
  });
  final List paymentDetails;
  final String appBarTitle;
  final String addNewCardButtonTitle;
  final Color addNewCardButtonBackgroundColor;
  final Function()? onTapAddNewCardButton;
  final String submitButtonTitle;
  final Color? submitButtonBackgroundColor;
  final Function()? onTapSubmitButton;
  final Function()? onTapDeleteButton;
  final bool showDeleteButton;
  final TextStyle? addNewCardButtonStyle;
  final TextStyle? submitButtonStyle;
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: CustomAppbarWidget(
          title: appBarTitle,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          height:
              showDeleteButton ? Dimens.eightySix : Dimens.oneHundredSeventy,
          padding: Dimens.edgeInsets16,
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomButton(
                title: addNewCardButtonTitle,
                backGroundColor: addNewCardButtonBackgroundColor,
                onTap: onTapAddNewCardButton,
                titleStyle: addNewCardButtonStyle,
              ),
              if (!showDeleteButton) ...[
                Dimens.boxHeight16,
                CustomButton(
                  title: submitButtonTitle,
                  backGroundColor: submitButtonBackgroundColor,
                  onTap: onTapSubmitButton,
                  titleStyle: submitButtonStyle,
                ),
              ],
            ],
          ),
        ),
        body: Padding(
          padding: Dimens.edgeInsets16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              paymentDetails.length,
              (index) => Container(
                padding: Dimens.edgeInsets10,
                margin: Dimens.edgeInsetsB16,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  border: Border.all(
                    color: paymentDetails[index]['isSelected']
                        ? AppColors.navyBlue
                        : AppColors.primaryColor,
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.lightNavyBlue.withOpacity(.8),
                      blurRadius: Dimens.eight,
                    )
                  ],
                  borderRadius: BorderRadius.circular(Dimens.twenty),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: Dimens.fiftyFive + Dimens.three,
                          width: Dimens.fiftyFive + Dimens.three,
                          padding: Dimens.edgeInsets6,
                          decoration: BoxDecoration(
                            color: AppColors.colorEEF5FCLightNavyBlue,
                            borderRadius: BorderRadius.circular(Dimens.ten),
                          ),
                          child: SvgPicture.asset(
                              paymentDetails[index]['asset'].toString()),
                        ),
                        Dimens.boxWidth10,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              text: paymentDetails[index]['accountNumber']
                                  .toString(),
                              maxLines: 1,
                              style: AppStyles.ubBlack16W600,
                            ),
                            Dimens.boxHeight4,
                            AppText(
                              text:
                                  paymentDetails[index]['cardType'].toString(),
                              maxLines: 1,
                              style: AppStyles.ubGrey12W500,
                            )
                          ],
                        ),
                      ],
                    ),
                    showDeleteButton
                        ? GestureDetector(
                            onTap: onTapDeleteButton,
                            child: SvgPicture.asset(
                              Assets.iconsDelete,
                              height: Dimens.thirty,
                              width: Dimens.thirty,
                            ),
                          )
                        : SvgPicture.asset(
                            paymentDetails[index]['isSelected']
                                ? Assets.iconsCircleTick
                                : Assets.iconsUncheckCircle,
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
