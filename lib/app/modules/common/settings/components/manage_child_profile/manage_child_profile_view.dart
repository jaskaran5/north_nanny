import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/common/settings/components/manage_child_profile/manage_child_profile_controller.dart';
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
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppbarWidget(
            title: TranslationKeys.mangeChildProfile.tr,
            centerTitle: false,
          ),
          body: Padding(
            padding: Dimens.edgeInsets16,
            child: ListView.builder(
              itemCount: 2,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return CustomChildProfileTile(
                  onTap: () {
                    log("click on redirect to edit child screen");
                    controller.redirectToEditChildScreen();
                  },
                );
              },
            ),
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
