import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/common/settings/components/invite_friends.dart';
import 'package:northshore_nanny_flutter/app/modules/common/settings/setting_controller.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
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
      body: GetBuilder<SettingController>(
          init: SettingController(),
          builder: (controller) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: Dimens.edgeInsets16,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppText(
                        text: "Settings",
                        style: AppStyles.pdSemiBoldBlack24,
                        maxLines: 1,
                      ),
                      Dimens.boxHeight20,
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
            if (index == 0) {
              RouteManagement.goToFilterView();
            } else if (index == 3) {
              RouteManagement.goToChnagePasswordScreen();
            } else if (index == 4) {
              controller.redirectToCommonWebView();
            } else if (index == 5) {
              Get.to(const InviteFriendsView());
            } else if (index == 7) {
              RouteManagement.goToRatingReviewScreen();
            } else if (index == 6) {
              RouteManagement.goToContactUs();
            } else if (index == 8) {
              RouteManagement.goToFAQ();
            } else if (index == 9) {
              controller.redirectToCommonWebView();
            } else if (index == 10) {
              controller.redirectToCommonWebView();
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
