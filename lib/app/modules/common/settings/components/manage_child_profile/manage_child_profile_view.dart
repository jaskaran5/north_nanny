import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/common/settings/components/manage_child_profile/manage_child_profile_controller.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_app_bar.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_button.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_child_profile_tile.dart';

class ManageChildProfileView extends StatelessWidget {
  const ManageChildProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ManageChildProfileController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.primaryColor.withOpacity(.98),
          appBar: CustomAppbarWidget(
            backgroundColor: AppColors.primaryColor.withOpacity(0.98),
            titleWidget: Text(
              "Manage Child Profile",
              style: AppStyles.pdSemiBoldBlack24,
            ),
            centerTitle: true,
          ),
          body: ListView.builder(
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
          floatingActionButton: CustomButton(
            title: "Add Child",
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
