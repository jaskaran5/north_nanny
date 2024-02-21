import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';

class SettingController extends GetxController {
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
}
