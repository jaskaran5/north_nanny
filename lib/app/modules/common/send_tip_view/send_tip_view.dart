import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_app_bar.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_button.dart';

class SendTipView extends StatelessWidget {
  const SendTipView(
      {super.key,
      required this.userName,
      required this.image,
      required this.amountTextEditingController,
      this.onTapSubmitButton});
  final String userName;
  final String image;
  final Function()? onTapSubmitButton;
  final TextEditingController amountTextEditingController;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const CustomAppbarWidget(
          title: 'Send tip',
        ),
        body: Padding(
          padding: Dimens.edgeInsets16,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: Dimens.thirtyFour,
                      width: Dimens.thirtyFour,
                      child: image.isEmpty
                          ? CircleAvatar(
                              radius: Dimens.hundred,
                              backgroundImage: const AssetImage(
                                Assets.iconsImage,
                              ),
                            )
                          : CachedNetworkImage(
                              imageUrl: image,
                              height: Dimens.thirtyFour,
                              width: Dimens.thirtyFour,
                            ),
                    ),
                    Dimens.boxHeight10,
                    AppText(
                      text: userName,
                      style: AppStyles.ubBlack14W700,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * .11,
              ),
              Padding(
                padding: EdgeInsets.only(left: Get.width / 5),
                child: SizedBox(
                  width: Dimens.twoHundredTwenty,
                  child: TextField(
                    style: AppStyles.ubNavyBlue40W800,
                    maxLines: 1,
                    maxLength: 10,
                    cursorHeight: Dimens.forty,
                    controller: amountTextEditingController,
                    cursorColor: AppColors.navyBlue,
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '100.00',
                      hintStyle: AppStyles.ubNavyBlue40W800,
                      counterText: '',
                      focusedBorder: InputBorder.none,
                      icon: AppText(
                        text: '\$',
                        maxLines: 1,
                        style: AppStyles.ubNavyBlue40W600,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
              const Spacer(),
              CustomButton(
                title: TranslationKeys.submit.tr,
                backGroundColor: AppColors.navyBlue,
                onTap: onTapSubmitButton,
              ),
              Dimens.boxHeight20,
            ],
          ),
        ),
      );
}
