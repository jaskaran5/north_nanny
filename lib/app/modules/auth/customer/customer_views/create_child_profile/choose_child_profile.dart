import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/auth/customer/customer_views/create_child_profile/create_child_profile_controller.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_app_bar.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_button.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_text_field.dart';
import 'package:northshore_nanny_flutter/navigators/routes_management.dart';

class ChooseChildProfileView extends StatelessWidget {
  const ChooseChildProfileView({super.key});
  @override
  Widget build(BuildContext context) =>
      GetBuilder<CreateChildProfileController>(
        init: CreateChildProfileController(),
        builder: (controller) => Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: const CustomAppbarWidget(),
          bottomSheet: Container(
            color: Colors.white,
            padding: Dimens.edgeInsetsL16R16B20,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /** SUBMIT BUTTON */
                CustomButton(
                  title: TranslationKeys.submit.tr,
                  backGroundColor: AppColors.navyBlue,
                  onTap: () {
                    controller.updateNoOfChildren(
                        val: int.parse(controller
                            .noOfChildrenTextEditingController.text
                            .trim()));

                    // Get.to(
                    //   const CreateChildProfileView(),
                    // );
                  },
                ),
                Dimens.boxHeight10,
                CustomButton(
                  title: TranslationKeys.skipForNow.tr,
                  backGroundColor: AppColors.lightNavyBlue,
                  textColor: AppColors.navyBlue,
                  onTap: () {
                    controller.skipChildApi();
                  },
                ),
              ],
            ),
          ),
          body: GestureDetector(
            onTap: () {
              Get.focusScope?.unfocus();
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: Dimens.edgeInsets16,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: TranslationKeys.childProfile.tr,
                      maxLines: 1,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.pdSemiBoldBlack24,
                    ),
                    Dimens.boxHeight16,
                    AppText(
                      text: TranslationKeys.noOfChildren.tr,
                      maxLines: 1,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.ubGrey16W400,
                    ),
                    Dimens.boxHeight20,

                    /** NO OF CHILDREN TEXTFIELD */
                    TextField(
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      controller: controller.noOfChildrenTextEditingController,
                      maxLines: 1,
                      minLines: 1,
                      decoration: customFieldDeco(
                        hintText: TranslationKeys.noOfChildren.tr,
                        prefixWidget: Padding(
                          padding: Dimens.edgeInsets12,
                          child: SvgPicture.asset(
                            Assets.iconsNoOfChild,
                            height: Dimens.ten,
                            width: Dimens.ten,
                          ),
                        ),
                      ),
                      cursorColor: AppColors.navyBlue,
                      cursorWidth: Dimens.one,
                      style: AppStyles.ubBlack15W600,
                      keyboardType: TextInputType.phone,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
