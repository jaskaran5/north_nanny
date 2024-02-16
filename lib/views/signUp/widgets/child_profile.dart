import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/controllers/controllers.dart';
import 'package:northshore_nanny_flutter/res/res.dart';
import 'package:northshore_nanny_flutter/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/views/signUp/signup.dart';
import 'package:northshore_nanny_flutter/widgets/app_text.dart';
import 'package:northshore_nanny_flutter/widgets/custom_app_bar.dart';

import '../../../utils/navigators/routes_management.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';

class ChildProfileView extends StatelessWidget {
  ChildProfileView({super.key});
  final selectedInterface = Get.arguments;
  @override
  Widget build(BuildContext context) => GetBuilder<SignupViewController>(
        builder: (controller) => Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: const CustomAppbarWidget(),
          bottomSheet: Container(
            color: Colors.white,
            padding: Dimens.edgeInsetsL16R16B20,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomButton(
                  title: TranslationKeys.submit.tr,
                  backGroundColor: AppColors.navyBlue,
                  onTap: () {
                    Get.to(CreateChildProfileView(),
                        arguments: selectedInterface);
                  },
                ),
                Dimens.boxHeight10,
                CustomButton(
                  title: TranslationKeys.skipForNow.tr,
                  backGroundColor: AppColors.lightNavyBlue,
                  textColor: AppColors.navyBlue,
                  onTap: () {
                    RouteManagement.goToOffAllHome(selectedInterface);
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
