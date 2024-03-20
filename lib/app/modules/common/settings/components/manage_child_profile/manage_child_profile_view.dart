import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/common/settings/components/manage_child_profile/manage_child_profile_controller.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_app_bar.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_button.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_child_profile_tile.dart';

//** this is  Manage child profile screen
class ManageChildProfileView extends StatelessWidget {
  const ManageChildProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ManageChildProfileController>(
      init: ManageChildProfileController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppbarWidget(
            title: TranslationKeys.mangeChildProfile.tr,
            centerTitle: false,
          ),
          body: controller.childList.isNotEmpty
              ? Padding(
                  padding: EdgeInsets.fromLTRB(Dimens.sixteen, Dimens.sixteen,
                      Dimens.sixteen, Dimens.fiftyThree),
                  child: ListView.builder(
                    itemCount: controller.childList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return CustomChildProfileTile(
                        aboutChild:
                            controller.childList[index].aboutChild ?? '',
                        allergies: controller
                            .childList[index].allergiesDietaryAndRestrictions!,
                        childAge: controller.childList[index].age ?? '',
                        childGender: controller.childList[index].gender ?? '',
                        childIdl:
                            controller.childList[index].childId.toString(),
                        childName: controller.childList[index].name!,
                        medicalCondition:
                            controller.childList[index].medicalCondition!,
                        onTap: () {
                          controller.updateSelectedChild(
                              id: controller.childList[index].childId!);
                          log("click on redirect to edit child screen");
                          controller.redirectToEditAndDeleteChildScreen(
                              index: index);
                        },
                      );
                    },
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Image.asset(
                        Assets.imagesNoDataPng,
                        scale: 2,
                      ),

                      //   SvgPicture.asset(
                      //   Assets.iconsNoDataFoundImage,
                      //   height: 200,
                      //   width: 200,
                      //   fit: BoxFit.cover,
                      // )
                    ),
                    SizedBox(
                      height: Get.height * .12,
                    )
                  ],
                ),
          floatingActionButton: CustomButton(
            title: TranslationKeys.addChild.tr,
            backGroundColor: AppColors.navyBlue,
            onTap: () {
              controller.redirectToAddChildScreen();
            },

            // child: AppText(
            titleStyle: AppStyles.fffUrban15w600,
            // ),
          ),
        );
      },
    );
  }
}
