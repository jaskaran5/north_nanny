import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/common/settings/setting_controller.dart';
import 'package:northshore_nanny_flutter/app/res/constants/string_contants.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/utils/helper.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_setting_item_tile.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_setting_profile_tile.dart';
import 'package:northshore_nanny_flutter/navigators/routes_management.dart';

import '../../../utils/utility.dart';
import '../../../widgets/custom_log_out.dart';

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
                        text: TranslationKeys.settings.tr,
                        style: AppStyles.pdSemiBoldBlack24,
                        maxLines: 1,
                      ),
                      Dimens.boxHeight20,
                      (controller.loginType.value == StringConstants.customer)
                          ? CustomSettingProfileTile(
                              onTap: () {
                                controller.redirectToCustomerProfileScreen();
                                // RouteManagement.goToMyProfileView();
                              },
                              title: addStringsWithSpace(
                                  controller.customerFirstName.value,
                                  controller.customerLastName.value),
                              subtitle: controller.customerEmail.value,
                              img: controller.customerImg.value,
                              trailingIcon: controller.customerSettingList[0]
                                      ["trallingIcon"]
                                  .toString())
                          : CustomSettingProfileTile(
                              onTap: () {
                                RouteManagement.goToNannyProfileView();
                              },
                              title: controller.nannyName.value,
                              subtitle: controller.nannyEmail.value,
                              img: controller.nannyImage.value,
                              trailingIcon: controller.customerSettingList[0]
                                      ["trallingIcon"]
                                  .toString()),
                      (controller.loginType.value == StringConstants.customer)
                          ? customerListOfTiles(context, controller)
                          : nannyListOfTiles(context, controller),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  //===========list of itmes CUSTOMER=======//
  Widget customerListOfTiles(context, SettingController controller) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return CustomSettingItemTile(
          onTap: () {
            log("index: $index");
            if (index == 0) {
              RouteManagement.goToFavoriteScreen();
            } else if (index == 1) {
              RouteManagement.goToManageChildProfileScreen();

              log("click on index 1");
            } else if (index == 2) {
              log("click on index 2");
              RouteManagement.goToCustomPaymentView(
                  isComeFromSendTip: false, isComeFromConfirmBooking: false, isCardAdded: true,

                  // paymentDetails: controller.cardList ?? [],
                  // appBarTitle: ,
                  // addNewCardButtonTitle:,
                  // addNewCardButtonBackgroundColor: ,
                  // onTapDeleteButton: (index) {
                  //   /// used to delete the card .
                  //   controller.deleteCard(
                  //       cardId: controller.cardList?[index].cardId ?? '');
                  // },
                  // onTapAddNewCardButton: () {
                  //   controller.postAddCard();
                  //   // RouteManagement.goToAddPaymentMethodScreen(
                  //   //   isComeFromNannyProfile: true,
                  //   //   buttonText: TranslationKeys.add.tr,
                  //   //   onTapButton: () {
                  //   //     Get.back();
                  //   //   },
                  //   // );
                  // },
                  // showDeleteButton: true,
                  );
            } else if (index == 3) {
              RouteManagement.goToChangePasswordScreen();
            } else if (index == 4) {
              controller.redirectToCommonWebView(
                  appBarTitle: TranslationKeys.aboutUs.tr);
            } else if (index == 5) {
              RouteManagement.goToInviteAFriendView();
            } else if (index == 6) {
              RouteManagement.goToContactUs();
            } else if (index == 7) {
              RouteManagement.goToRatingReviewScreen();
            } else if (index == 8) {
              RouteManagement.goToFAQ();
            } else if (index == 9) {
              controller.redirectToCommonWebView(
                  appBarTitle: TranslationKeys.termAndConditions.tr);
            } else if (index == 10) {
              controller.redirectToCommonWebView(
                  appBarTitle: TranslationKeys.privacyPolicy.tr);
            } else if (index == 11) {
              Utility.openBottomSheet(CustomLogOut(
                onTapLogOut: () {
                  controller.logOutApi();
                },
              ));
            }
          },
          text: controller.customerSettingList[index]["name"].toString(),
          leadingIcon: controller.customerSettingList[index]["icon"].toString(),
          trallingIcon:
              controller.customerSettingList[index]["trallingIcon"].toString(),
        );
      },
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.customerSettingList.length,
      shrinkWrap: true,
    );
  }

  //===========list of itmes NANNY=======//
  Widget nannyListOfTiles(context, SettingController controller) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return CustomSettingItemTile(
          onTap: () {
            log("index: $index");
            if (index == 0) {
              RouteManagement.goToUpdateBankDetailView();
              /** BANK DETAILS */
            } else if (index == 1) {
              /** CHANGE PASSWORD */

              RouteManagement.goToChangePasswordScreen();
            } else if (index == 2) {
              /**  ABOUT US */

              controller.redirectToCommonWebView(
                  appBarTitle: TranslationKeys.aboutUs.tr);
            } else if (index == 3) {
              /** INVITE A FIREND  */

              RouteManagement.goToInviteAFriendView();
            } else if (index == 4) {
              /** CONTACT US */

              RouteManagement.goToContactUs();
            } else if (index == 5) {
              /** RATE A APP */

              RouteManagement.goToRatingReviewScreen();
            } else if (index == 6) {
              /** FAQ */

              RouteManagement.goToFAQ();
            } else if (index == 7) {
              /** TERMS AND CONDITIONS */

              controller.redirectToCommonWebView(
                  appBarTitle: TranslationKeys.termAndConditions.tr);
            } else if (index == 8) {
              /** PRIVACY POLICY */

              controller.redirectToCommonWebView(
                  appBarTitle: TranslationKeys.privacyPolicy.tr);
            } else if (index == 9) {
              /** LOG OUT */

              Utility.openBottomSheet(CustomLogOut(
                onTapLogOut: () {
                  controller.logOutApi();
                },
              ));
            }
          },
          text: controller.nannySettingList[index]["name"].toString(),
          leadingIcon: controller.nannySettingList[index]["icon"].toString(),
          trallingIcon:
              controller.nannySettingList[index]["trallingIcon"].toString(),
        );
      },
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.nannySettingList.length,
      shrinkWrap: true,
    );
  }
}
