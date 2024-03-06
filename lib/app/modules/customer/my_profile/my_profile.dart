import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/customer/my_profile/my_profile_controller.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_app_bar.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_button.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_cache_network_image.dart';
import 'package:northshore_nanny_flutter/navigators/routes_management.dart';

class MyProfileView extends StatelessWidget {
  const MyProfileView({super.key});

  @override
  Widget build(BuildContext context) => GetBuilder<MyProfileController>(
        builder: (controller) => Scaffold(
          appBar: CustomAppbarWidget(
            title: TranslationKeys.myProfile.tr,
          ),
          bottomSheet: Container(
            padding: Dimens.edgeInsets16,
            color: Colors.transparent,
            child: CustomButton(
              title: TranslationKeys.editProfile.tr,
              backGroundColor: AppColors.navyBlue,
              onTap: () {
                RouteManagement.goToEditProfileView();
              },
            ),
          ),
          body: Padding(
            padding: Dimens.edgeInsets16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: Dimens.edgeInsets16,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimens.twenty),
                    border: Border.all(
                      color: AppColors.primaryColor,
                      width: Dimens.two,
                    ),
                    color: AppColors.primaryColor,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.settingBackgroundColor.withOpacity(.4),
                        blurRadius: Dimens.ten,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: Dimens.hundredTwo,
                        width: Dimens.hundredTwo,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.primaryColor,
                            width: Dimens.two,
                          ),
                          borderRadius: BorderRadius.circular(Dimens.twenty),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.lightNavyBlue.withOpacity(.8),
                              blurRadius: Dimens.five,
                            )
                          ],
                        ),
                        child: controller.imageUrl.isEmpty
                            ? Image.asset(
                                Assets.iconsImage,
                                fit: BoxFit.fill,
                              )
                            : CustomCacheNetworkImage(
                                img: controller.imageUrl,
                                size: Dimens.hundredTwo,
                                imageRadius: Dimens.twenty,
                              ),
                      ),
                      Dimens.boxHeight16,
                      AppText(
                        text: controller.userName,
                        style: AppStyles.ubBlack16W700,
                        maxLines: 1,
                      ),
                      Dimens.boxHeight10,
                      AppText(
                        text: controller.userEmail,
                        style: AppStyles.ubGrey14W500,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                Dimens.boxHeight24,
                Container(
                  padding: Dimens.edgeInsets12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimens.twenty),
                    color: AppColors.primaryColor,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.settingBackgroundColor.withOpacity(.3),
                        blurRadius: Dimens.ten,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: Dimens.forty,
                            width: Dimens.forty,
                            padding: Dimens.edgeInsets10,
                            decoration: BoxDecoration(
                              color: AppColors.lightNavyBlue,
                              borderRadius: BorderRadius.circular(Dimens.eight),
                            ),
                            child: SvgPicture.asset(
                              Assets.iconsBookingLocation,
                              colorFilter: const ColorFilter.mode(
                                AppColors.navyBlue,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          Dimens.boxWidth10,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AppText(
                                text: TranslationKeys.address.tr,
                                style: AppStyles.ubBlack14W600,
                                maxLines: 1,
                              ),
                              Dimens.boxHeight4,
                              AppText(
                                text: controller.userAddress,
                                style: AppStyles.ubGrey14W500,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Dimens.boxHeight24,
                      Row(
                        children: [
                          Container(
                            height: Dimens.forty,
                            width: Dimens.forty,
                            padding: Dimens.edgeInsets10,
                            decoration: BoxDecoration(
                              color: AppColors.lightNavyBlue,
                              borderRadius: BorderRadius.circular(Dimens.eight),
                            ),
                            child: SvgPicture.asset(
                              Assets.iconsPhone,
                              colorFilter: const ColorFilter.mode(
                                AppColors.navyBlue,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          Dimens.boxWidth10,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AppText(
                                text: TranslationKeys.phoneNumber.tr,
                                style: AppStyles.ubBlack14W600,
                                maxLines: 1,
                              ),
                              Dimens.boxHeight4,
                              AppText(
                                text: controller.userPhoneNumber,
                                style: AppStyles.ubGrey14W500,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Dimens.boxHeight24,
                      Row(
                        children: [
                          Container(
                            height: Dimens.forty,
                            width: Dimens.forty,
                            padding: Dimens.edgeInsets10,
                            decoration: BoxDecoration(
                              color: AppColors.lightNavyBlue,
                              borderRadius: BorderRadius.circular(Dimens.eight),
                            ),
                            child: SvgPicture.asset(
                              Assets.iconsDollarCircle,
                              colorFilter: const ColorFilter.mode(
                                AppColors.navyBlue,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          Dimens.boxWidth10,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AppText(
                                text: TranslationKeys.referralEarned.tr,
                                style: AppStyles.ubBlack14W600,
                                maxLines: 1,
                              ),
                              Dimens.boxHeight4,
                              AppText(
                                text: '\$5.00',
                                style: AppStyles.ubGrey14W500,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
