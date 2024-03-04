import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/nanny/nanny_views/create_profile/create_nanny_profile_controller.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';
import 'package:northshore_nanny_flutter/app/res/constants/extensions.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_app_bar.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_bottom_sheet.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_button.dart';

class ServicesView extends StatelessWidget {
  const ServicesView({super.key});

  @override
  Widget build(BuildContext context) =>
      GetBuilder<CreateSitterProfileController>(
        builder: (controller) => Scaffold(
          appBar: CustomAppbarWidget(
            title: TranslationKeys.selectServices.tr,
            onBackPress: () {
              controller.selectedServices.clear();
              Get.back();
            },
          ),
          bottomSheet: Container(
            padding: Dimens.edgeInsetsL16R16B20,
            child: CustomButton(
              title: TranslationKeys.continueWord.tr,
              backGroundColor: AppColors.navyBlue,
              onTap: () {
                controller.servicesValidator();
              },
            ),
          ),
          body: Padding(
            padding: Dimens.edgeInsets16,
            child: Column(
              children: List.generate(
                controller.servicesList.length,
                (index) => GestureDetector(
                  onTap: () {
                    if (controller.selectedServices
                        .contains(controller.servicesList[index].serviceName)) {
                      controller.selectedServices
                          .remove(controller.servicesList[index].serviceName);
                    } else {
                      controller.selectedServices
                          .add(controller.servicesList[index].serviceName);
                    }
                    controller.update();
                  },
                  child: SizedBox(
                    height: Dimens.seventy,
                    child: Card(
                      color: Colors.white,
                      margin: Dimens.edgeInsetsT10,
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimens.ten),
                        borderSide: BorderSide(
                          color: controller.selectedServices.contains(
                                  controller.servicesList[index].serviceName)
                              ? AppColors.navyBlue
                              : AppColors.primaryColor,
                          width: 1.5,
                        ),
                      ),
                      elevation: 5,
                      shadowColor: AppColors.lightNavyBlue.withOpacity(.8),
                      child: Padding(
                        padding: Dimens.edgeInsets10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: Dimens.thirtyFive,
                                  width: Dimens.thirtyFive,
                                  padding: Dimens.edgeInsets10,
                                  decoration: BoxDecoration(
                                    color: AppColors.lightNavyBlue,
                                    borderRadius: BorderRadius.circular(
                                      Dimens.eight,
                                    ),
                                  ),
                                  child: SvgPicture.asset(
                                    controller.servicesList[index].servicesSvg,
                                  ),
                                ),
                                Dimens.boxWidth10,
                                AppText(
                                  text: controller
                                      .servicesList[index].serviceName.tr,
                                  style: AppStyles.ubBlack14W600,
                                  maxLines: 1,
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.bottomSheet(
                                      CustomBottomSheet(
                                        heading: controller
                                            .servicesList[index].serviceName.tr,
                                        description: controller
                                            .servicesList[index]
                                            .serviceDescription
                                            .tr,
                                      ),
                                      barrierColor:
                                          AppColors.greyColor.withOpacity(.2),
                                    );
                                  },
                                  child: SvgPicture.asset(
                                    Assets.iconsInfoCircle,
                                  ),
                                ),
                                Dimens.boxWidth10,
                                SvgPicture.asset(
                                  controller.selectedServices.contains(
                                          controller
                                              .servicesList[index].serviceName)
                                      ? Assets.iconsCircleTick
                                      : Assets.iconsUncheckCircle,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
