import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/res/constants/extensions.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';

import '../../../../res/constants/assets.dart';
import '../../../../res/theme/colors.dart';
import '../../../../res/theme/dimens.dart';
import '../../../../res/theme/styles.dart';
import '../../../../widgets/app_text.dart';
import '../../../../widgets/custom_app_bar.dart';
import '../../../../widgets/custom_bottom_sheet.dart';
import '../../../../widgets/custom_button.dart';
import 'nanny_edit_profile_controller.dart';

class NannyEditServicesView extends StatelessWidget {
  const NannyEditServicesView({super.key});

  @override
  Widget build(BuildContext context) => GetBuilder<NannyEditProfileController>(
        init: NannyEditProfileController(),
        builder: (controller) => Scaffold(
          appBar: CustomAppbarWidget(
            title: TranslationKeys.selectServices.tr,
          ),
          bottomSheet: Container(
            padding: Dimens.edgeInsetsL16R16B20,
            child: CustomButton(
              title: TranslationKeys.saveChanges.tr,
              backGroundColor: AppColors.navyBlue,
              onTap: () {
                controller.editServicesValidator();
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
