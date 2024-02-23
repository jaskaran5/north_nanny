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
}
