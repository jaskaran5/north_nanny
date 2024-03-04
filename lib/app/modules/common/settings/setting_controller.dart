import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/data/storage/storage.dart';
import 'package:northshore_nanny_flutter/app/modules/common/common_web_view/common_web_view.dart';
import 'package:northshore_nanny_flutter/app/res/constants/string_contants.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/navigators/app_routes.dart';

import '../../../res/constants/assets.dart';

class SettingController extends GetxController {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController subjectTextEditingController = TextEditingController();
  TextEditingController messageTextEditingController = TextEditingController();

  RxBool isExpand = false.obs;
  RxString loginType = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getAndUpdateLoginType();
  }

  getAndUpdateLoginType() async {
    loginType.value = await Storage.getValue(StringConstants.loginType);

    log("login type is:-->> ${loginType.value}");

    update();
  }

  RxInt? expandIndex;

  /// Go to Rating and Review  Screen
  redirectToPasswordChangedScreen() {
    Get.toNamed(
      Routes.passwordChangedView,
    );
  }

  updateIsExpand({index}) {
    // if (index != expandIndex) {
    //   isExpand.value = !isExpand.value;
    //   print(expandIndex!.value);
    // }
    faqlist.elementAt(index)["isExpand"] =
        !faqlist.elementAt(index)["isExpand"];

    update();
  }

  /// CUSTOMER SETTING LIST------------------------------------- 12  CUSTOMER

  final customerSettingList = [
    {
      "name": TranslationKeys.favorites.tr,
      "icon": Assets.iconsHeartOutline,
      "trallingIcon": Assets.iconsNext,
    },
    {
      "name": TranslationKeys.mangeChildProfile.tr,
      "icon": Assets.iconsBabyBoy,
      "trallingIcon": Assets.iconsNext
    },
    {
      "name": TranslationKeys.paymentMethod.tr,
      "icon": Assets.iconsCard,
      "trallingIcon": Assets.iconsNext
    },
    {
      "name": TranslationKeys.changePassword.tr,
      "icon": Assets.iconsLock,
      "trallingIcon": Assets.iconsNext
    },
    {
      "name": TranslationKeys.aboutUs.tr,
      "icon": Assets.iconsAboutUs,
      "trallingIcon": Assets.iconsNext
    },
    {
      "name": TranslationKeys.inviteAFriend.tr,
      "icon": Assets.iconsProfileAdd,
      "trallingIcon": Assets.iconsNext
    },
    {
      "name": TranslationKeys.contactUs.tr,
      "icon": Assets.iconsHeadPhone,
      "trallingIcon": Assets.iconsNext
    },
    {
      "name": TranslationKeys.rateApp.tr,
      "icon": Assets.iconsBlackStar,
      "trallingIcon": Assets.iconsNext
    },
    {
      "name": TranslationKeys.fAQ.tr,
      "icon": Assets.iconsMessageQuestion,
      "trallingIcon": Assets.iconsNext
    },
    {
      "name": TranslationKeys.termAndConditions.tr,
      "icon": Assets.iconsDocumentText,
      "trallingIcon": Assets.iconsNext
    },
    {
      "name": TranslationKeys.privacyPolicy.tr,
      "icon": Assets.iconsShieldSecurity,
      "trallingIcon": Assets.iconsNext
    },
    {
      "name": TranslationKeys.logOut.tr,
      "icon": Assets.iconsLogout,
      "trallingIcon": Assets.iconsNext
    },
  ];

  /// NANNY SETTING LIST ---------------------------------------------- 10  NANNY

  final nannySettingList = [
    /***m BANK DETAILS */
    {
      "name": TranslationKeys.bankDetails.tr,
      "icon": Assets.iconsBank,
      "trallingIcon": Assets.iconsNext
    },

    /** CHANGE PASSWORD */

    {
      "name": TranslationKeys.changePassword.tr,
      "icon": Assets.iconsLock,
      "trallingIcon": Assets.iconsNext
    },

    /** ABOUT US */
    {
      "name": TranslationKeys.aboutUs.tr,
      "icon": Assets.iconsAboutUs,
      "trallingIcon": Assets.iconsNext
    },

    /** INVITE A FRIEND */

    {
      "name": TranslationKeys.inviteAFriend.tr,
      "icon": Assets.iconsProfileAdd,
      "trallingIcon": Assets.iconsNext
    },

    /** CONTACT US */

    {
      "name": TranslationKeys.contactUs.tr,
      "icon": Assets.iconsHeadPhone,
      "trallingIcon": Assets.iconsNext
    },

    /** RATE APP */
    {
      "name": TranslationKeys.rateApp.tr,
      "icon": Assets.iconsBlackStar,
      "trallingIcon": Assets.iconsNext
    },
    /** FAQ */
    {
      "name": TranslationKeys.fAQ.tr,
      "icon": Assets.iconsMessageQuestion,
      "trallingIcon": Assets.iconsNext
    },

    /** TERMS AND CONDITIONS */
    {
      "name": TranslationKeys.termAndConditions.tr,
      "icon": Assets.iconsDocumentText,
      "trallingIcon": Assets.iconsNext
    },

    /** PRIVACY POLICY */
    {
      "name": TranslationKeys.privacyPolicy.tr,
      "icon": Assets.iconsShieldSecurity,
      "trallingIcon": Assets.iconsNext
    },
    /** LOG OUT */
    {
      "name": TranslationKeys.logOut.tr,
      "icon": Assets.iconsLogout,
      "trallingIcon": Assets.iconsNext
    },
  ];

  RxList faqlist = [
    {
      "title": "How are you? click on me",
      "subtitle": "This is m,y expanded suybttile",
      "isExpand": false,
    },
    {
      "title": "How are you? click on me",
      "subtitle": "This is m,y expanded suybttile",
      "isExpand": false,
    },
    {
      "title": "How are you? click on me",
      "subtitle": "This is m,y expanded suybttile",
      "isExpand": true,
    },
    {
      "title": "How are you? click on me",
      "subtitle": "This is m,y expanded suybttile",
      "isExpand": false,
    },
    {
      "title": "How are you? click on me",
      "subtitle": "This is m,y expanded suybttile",
      "isExpand": false,
    }
  ].obs;

  /// card list.
  List cardList = [
    {
      'asset': Assets.iconsMasterCard,
      'accountNumber': "9587 5498 8569 7569",
      'cardType': 'Master Card',
      'isSelected': true,
    },
    {
      'asset': Assets.iconsVisa,
      'accountNumber': "9587 5498 8569 7569",
      'cardType': 'Visa',
      'isSelected': false,
    }
  ];

  /// REDIRECT TO COMMON WEB VIEW
  redirectToCommonWebView() {
    Get.to(() => const CommonWebView());
  }

  /// invite friend list to do
  var inviteList = [
    'Download the Northshore Nanny app using your unique link below',
    'Create an account on the app',
    'Accept a job!',
  ];
}
