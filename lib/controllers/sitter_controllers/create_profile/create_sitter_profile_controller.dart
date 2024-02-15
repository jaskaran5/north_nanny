import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/res/constants/assets.dart';
import 'package:northshore_nanny_flutter/utils/translations/translation_keys.dart';

class CreateSitterProfileController extends GetxController {
  final firstNameTextEditingController = TextEditingController();
  final lastNameTextEditingController = TextEditingController();
  final ageTextEditingController = TextEditingController();
  final phoneNumberTextEditingController = TextEditingController();
  final locationTextEditingController = TextEditingController();
  final highSchoolTextEditingController = TextEditingController();
  final collegeTextEditingController = TextEditingController();
  final tellUsTextEditingController = TextEditingController();
  final bankNameTextEditingController = TextEditingController();
  final holderNameTextEditingController = TextEditingController();
  final accountNumberTextEditingController = TextEditingController();
  final routingNumberTextEditingController = TextEditingController();

  List<String> experienceList = [
    '1 ${TranslationKeys.year.capitalizeFirst}',
    '2 ${TranslationKeys.year.capitalizeFirst}s',
    '3 ${TranslationKeys.year.capitalizeFirst}s',
    '4 ${TranslationKeys.year.capitalizeFirst}s',
    '5 ${TranslationKeys.year.capitalizeFirst}s',
    '6 ${TranslationKeys.year.capitalizeFirst}s',
    '7 ${TranslationKeys.year.capitalizeFirst}s',
    '7+ ${TranslationKeys.year.capitalizeFirst}s',
  ];

  List<String> licenseList = [TranslationKeys.yes, TranslationKeys.no];

  List<String> servicesList = [
    TranslationKeys.houseKeeping,
    TranslationKeys.driving,
    TranslationKeys.petCare,
    TranslationKeys.homeWorkHelp,
    TranslationKeys.runningErrands,
    TranslationKeys.funActivityOutHouse,
  ];

  List<String> servicesSvgList = [
    Assets.iconsHouseKeeping,
    Assets.iconsStaringWheel,
    Assets.iconsPetThumb,
    Assets.iconsHomeWork,
    Assets.iconsShoppingCart,
    Assets.iconsFunActivity,
  ];

  List<String> childrenList = [
    '4+ ',
    '4 ',
    '3 ',
    '2 ',
    '1 ',
  ];
  List<int> pricingList = [
    27,
    26,
    24,
    23,
    22,
  ];

  String? selectedGender = '';
  String? selectedYear = '';
  String? licenseHaveOrNot = '';
}
