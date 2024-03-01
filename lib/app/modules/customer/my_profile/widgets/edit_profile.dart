import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/customer/my_profile/my_profile_controller.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_app_bar.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_cache_network_image.dart';

import '../../../../res/constants/assets.dart';
import '../../../../res/theme/colors.dart';
import '../../../../res/theme/dimens.dart';
import '../../../../res/theme/styles.dart';
import '../../../../widgets/app_text.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_text_field.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) => GetBuilder<MyProfileController>(
        builder: (controller) => Scaffold(
          appBar: CustomAppbarWidget(
            title: TranslationKeys.editProfile.tr,
          ),
          body: Padding(
            padding: Dimens.edgeInsets16,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Stack(
                            clipBehavior: Clip.none,
                            fit: StackFit.passthrough,
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: Dimens.oneHundredTwenty,
                                width: Dimens.oneHundredTwenty,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(Dimens.twenty),
                                  border: Border.all(
                                    color: AppColors.primaryColor,
                                    width: Dimens.three,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.lightNavyBlue
                                          .withOpacity(.8),
                                      blurRadius: Dimens.five,
                                    )
                                  ],
                                ),
                                child: controller.imageUrl.isEmpty
                                    ? Padding(
                                        padding: Dimens.edgeInsets16,
                                        child: SvgPicture.asset(
                                          Assets.iconsProfile,
                                          fit: BoxFit.contain,
                                        ),
                                      )
                                    : CustomCacheNetworkImage(
                                        img: controller.imageUrl,
                                        size: Dimens.oneHundredTwenty,
                                        imageRadius: Dimens.eighteen,
                                        imageShape: BoxShape.rectangle,
                                      ),
                              ),
                              Positioned(
                                top: -20,
                                right: -30,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(Dimens.ten),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.greyColor
                                            .withOpacity(0.05),
                                        blurRadius: Dimens.fourteen,
                                      ),
                                    ],
                                  ),
                                  child: SvgPicture.asset(
                                    Assets.iconsUpload,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Dimens.boxHeight10,
                        AppText(
                          text:
                              '${TranslationKeys.profilePicture.tr} (${TranslationKeys.optional.tr})'
                                  .tr,
                          style: AppStyles.ubGrey15W500,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                        ),
                        Dimens.boxHeight26,
                        /** first name */
                        TextField(
                          controller: controller.firstNameTextEditingController,
                          maxLines: 1,
                          minLines: 1,
                          decoration: customFieldDeco(
                            hintText: TranslationKeys.firstName.tr,
                            prefixWidget: Padding(
                              padding: Dimens.edgeInsets12,
                              child: SvgPicture.asset(
                                Assets.iconsSmallProfile,
                                height: Dimens.ten,
                                width: Dimens.ten,
                              ),
                            ),
                          ),
                          cursorColor: AppColors.blackColor,
                          cursorWidth: Dimens.one,
                          style: AppStyles.ubBlack15W600,
                          keyboardType: TextInputType.text,
                        ),
                        Dimens.boxHeight20,

                        /** Last Name */
                        TextField(
                          controller: controller.lastNameTextEditingController,
                          maxLines: 1,
                          minLines: 1,
                          decoration: customFieldDeco(
                            hintText: TranslationKeys.lastName.tr,
                            prefixWidget: Padding(
                              padding: Dimens.edgeInsets12,
                              child: SvgPicture.asset(
                                Assets.iconsSmallProfile,
                                height: Dimens.ten,
                                width: Dimens.ten,
                              ),
                            ),
                          ),
                          cursorColor: AppColors.blackColor,
                          cursorWidth: Dimens.one,
                          style: AppStyles.ubBlack15W600,
                          keyboardType: TextInputType.text,
                        ),
                        Dimens.boxHeight20,

                        /**PHONE NUMBER */
                        TextField(
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          controller:
                              controller.phoneNumberTextEditingController,
                          maxLines: 1,
                          minLines: 1,
                          decoration: customFieldDeco(
                            hintText: '000 000 0000',
                            prefixWidget: Padding(
                              padding: Dimens.edgeInsets12,
                              child: SvgPicture.asset(
                                Assets.iconsPhone,
                                height: Dimens.ten,
                                width: Dimens.ten,
                              ),
                            ),
                          ),
                          cursorColor: AppColors.blackColor,
                          cursorWidth: Dimens.one,
                          style: AppStyles.ubBlack15W600,
                          keyboardType: TextInputType.phone,
                        ),
                        Dimens.boxHeight20,

                        /** SELECT LOCATION */
                        TextField(
                          controller: controller.locationTextEditingController,
                          maxLines: 1,
                          minLines: 1,
                          decoration: customFieldDeco(
                            hintText: TranslationKeys.selectLocation.tr,
                            prefixWidget: Padding(
                              padding: Dimens.edgeInsets12,
                              child: SvgPicture.asset(
                                Assets.iconsLocationDot,
                                height: Dimens.ten,
                                width: Dimens.ten,
                              ),
                            ),
                            suffix: Padding(
                              padding: Dimens.edgeInsets12,
                              child: SvgPicture.asset(
                                Assets.iconsLocation,
                                height: Dimens.ten,
                                width: Dimens.ten,
                              ),
                            ),
                          ),
                          cursorColor: AppColors.navyBlue,
                          cursorWidth: Dimens.one,
                          style: AppStyles.ubBlack15W600,
                          keyboardType: TextInputType.text,
                        ),
                        Dimens.boxHeight20,
                      ],
                    ),
                  ),
                ),

                /** SAVE BUTTON */
                CustomButton(
                  title: TranslationKeys.save.tr,
                  backGroundColor: AppColors.navyBlue,
                  onTap: () {
                    Get.back();
                  },
                ),
              ],
            ),
          ),
        ),
      );
}
