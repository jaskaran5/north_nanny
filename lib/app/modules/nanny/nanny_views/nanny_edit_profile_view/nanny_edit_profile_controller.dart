import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../res/constants/enums.dart';
import '../../../../utils/translations/translation_keys.dart';

class NannyEditProfileController extends GetxController{
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

  List<String> licenseList = [
    TranslationKeys.yes.capitalizeFirst.toString(),
    TranslationKeys.no.capitalizeFirst.toString()
  ];

  List<Services> servicesList = Services.values;

  var selectedServices = [];


  /// gender list.
  List<String> genderList = [
    TranslationKeys.male.capitalizeFirst.toString(),
    TranslationKeys.female.capitalizeFirst.toString()
  ];

  String? selectedGender = '';
  String? selectedYear = '';
  String? licenseHaveOrNot = '';
  String? imageUrl = '';
}