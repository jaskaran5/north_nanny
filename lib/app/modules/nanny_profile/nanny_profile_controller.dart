import 'package:get/get.dart';

import '../../utils/translations/translation_keys.dart';

class NannyProfileController extends GetxController {
  List<String> homeCustomList = [
    'Distance: 3 miles',
    'Age: 40',
    'Experience: 7+ yrs',
  ];
  int selectedIndex = 0;

  DateTime selectedDate = DateTime.now();

  List<String>? priceList = [
    '\$ 10',
    '\$ 10',
    '\$ 10',
    '\$ 10',
    '\$ 10',
    '',
  ];
  bool isFavorite = false;

  List<String> profileTabList = [
    TranslationKeys.about.tr,
    TranslationKeys.services.tr,
    TranslationKeys.availability.tr
  ];

  List nannyMyProfileData = [
    {"name ": "My Nanny Profile"},
    {"gender ": "Female"},
    {"age ": "40"},
    {"experience ": "7+ yrs"},
    {
      "about ":
          "Dedicated nanny providing loving Care and guidance to littleones. Experienced in nurturing children's development andensuring a safe, happy environment."
    },
    {"colleage ": "Hebrew Theological College"},
    {"high school ": "Austin Community Academy High School"},
    {"location": "Chicago, Naperville"},
    {"phone": "985 968 8745"},
    {"driverLicense": "Yes"},
    {"refrerrelBonus": "5"},
  ];
}
