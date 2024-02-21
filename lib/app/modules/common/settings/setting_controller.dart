import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';

class SettingController extends GetxController {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController subjectTextEditingController = TextEditingController();
  TextEditingController messageTextEditingController = TextEditingController();

  RxBool isExpand = false.obs;

  RxInt? expandIndex;

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
      "icon": Assets.favIcon,
      "trallingIcon": Assets.nextIcon
    },
    {
      "name": 'Manage child profile ',
      "icon": Assets.childIcon,
      "trallingIcon": Assets.nextIcon
    },
    {
      "name": 'Payment method',
      "icon": Assets.paymentIcon,
      "trallingIcon": Assets.nextIcon
    },
    {
      "name": 'Change password',
      "icon": Assets.passwordIcon,
      "trallingIcon": Assets.nextIcon
    },
    {
      "name": 'About us',
      "icon": Assets.aboutIcon,
      "trallingIcon": Assets.nextIcon
    },
    {
      "name": "Invite a friend",
      "icon": Assets.addIcon,
      "trallingIcon": Assets.nextIcon
    },
    {
      "name": "Contact us",
      "icon": Assets.contactIcon,
      "trallingIcon": Assets.nextIcon
    },
    {
      "name": "Rate app",
      "icon": Assets.starIcon,
      "trallingIcon": Assets.nextIcon
    },
    {"name": "FAQ", "icon": Assets.faqIcon, "trallingIcon": Assets.nextIcon},
    {
      "name": "Terms & Conditions",
      "icon": Assets.docIcon,
      "trallingIcon": Assets.nextIcon
    },
    {
      "name": " Privacy Policy",
      "icon": Assets.privacyIcon,
      "trallingIcon": Assets.nextIcon
    },
    {
      "name": "Logout",
      "icon": Assets.exitIcon,
      "trallingIcon": Assets.nextIcon
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
}
