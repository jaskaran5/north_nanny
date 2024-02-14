import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
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
    '1 ${TranslationKeys.year}',
    '2 ${TranslationKeys.year}',
    '3 ${TranslationKeys.year}',
    '4 ${TranslationKeys.year}',
    '5 ${TranslationKeys.year}',
    '6 ${TranslationKeys.year}',
    '7 ${TranslationKeys.year}',
    '7+ ${TranslationKeys.year}',
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
}
