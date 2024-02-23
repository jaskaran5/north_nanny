import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/common/common_web_view/common_web_view.dart';
import 'package:northshore_nanny_flutter/navigators/app_routes.dart';

import '../../../res/constants/assets.dart';

class SettingController extends GetxController {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController subjectTextEditingController = TextEditingController();
  TextEditingController messageTextEditingController = TextEditingController();

  RxBool isExpand = false.obs;

  RxInt? expandIndex;

  /// Go to Rating and Review  Screen
  redirectToPasswordChangedScreen() {
    Get.toNamed(
      Routes.passwordChnagedView,
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

  final data = [
    {
      "name": 'Favorites',
      "icon": Assets.iconsHeartOutline,
      "trallingIcon": Assets.iconsNext,
    },
    {
      "name": 'Manage child profile ',
      "icon": Assets.iconsBabyBoy,
      "trallingIcon": Assets.iconsNext
    },
    {
      "name": 'Payment method',
      "icon": Assets.iconsCard,
      "trallingIcon": Assets.iconsNext
    },
    {
      "name": 'Change password',
      "icon": Assets.iconsLock,
      "trallingIcon": Assets.iconsNext
    },
    {
      "name": 'About us',
      "icon": Assets.iconsAboutUs,
      "trallingIcon": Assets.iconsNext
    },
    {
      "name": "Invite a friend",
      "icon": Assets.iconsProfileAdd,
      "trallingIcon": Assets.iconsNext
    },
    {
      "name": "Contact us",
      "icon": Assets.iconsHeadPhone,
      "trallingIcon": Assets.iconsNext
    },
    {
      "name": "Rate app",
      "icon": Assets.iconsBlackStar,
      "trallingIcon": Assets.iconsNext
    },
    {
      "name": "FAQ",
      "icon": Assets.iconsMessageQuestion,
      "trallingIcon": Assets.iconsNext
    },
    {
      "name": "Terms & Conditions",
      "icon": Assets.iconsDocumentText,
      "trallingIcon": Assets.iconsNext
    },
    {
      "name": " Privacy Policy",
      "icon": Assets.iconsShieldSecurity,
      "trallingIcon": Assets.iconsNext
    },
    {
      "name": "Logout",
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

  /// REDIRECT TO COMMON WEB VIEW
  redirectToCommonWebView() {
    Get.to(() => const CommonWebView());
  }
}
