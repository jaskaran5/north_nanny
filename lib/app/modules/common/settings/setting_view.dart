import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/common/settings/setting_controller.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_setting_item_tile.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_setting_profile_tile.dart';
import 'package:northshore_nanny_flutter/navigators/routes_management.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.settingBackgroundColor.withOpacity(.18),
      body: GetBuilder<SettingController>(
          init: SettingController(),
          builder: (controller) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: AppText(
                        text: "Settings",
                        style: AppStyles.B0B0BPlayfair24,
                      ),
                    ),
                    CustomSettingProfileTile(
                        onTap: () {},
                        title: "Michael Jorden",
                        subtitle: "example@gmail.com",
                        img: "",
                        trailingIcon:
                            controller.data[0]["trallingIcon"].toString()),
                    listOfTiles(context, controller),
                  ],
                ),
              ),
            );
          }),
    );
  }

  //===========list of itmes =======//
  Widget listOfTiles(context, controller) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return CustomSettingItemTile(
          onTap: () {
            log("index: $index");

            if (index == 7) {
              RouteManagement.goToRatingReviewScreen();
            } else if (index == 6) {
              RouteManagement.goToContactUs();
            } else if (index == 8) {
              RouteManagement.goToFAQ();
            }
          },
          text: controller.data[index]["name"].toString(),
          leadingIcon: controller.data[index]["icon"].toString(),
          trallingIcon: controller.data[index]["trallingIcon"].toString(),
        );
      },
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.data.length,
      shrinkWrap: true,
    );
  }
}
