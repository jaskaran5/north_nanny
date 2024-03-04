import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/res/constants/enums.dart';
import 'package:northshore_nanny_flutter/app/utils/custom_toast.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/utils/utility.dart';
import 'package:northshore_nanny_flutter/app/utils/validators.dart';

import '../../../../../navigators/routes_management.dart';

class CreateNannyProfileController extends GetxController {
  /// create nanny profile controllers.
  final firstNameTextEditingController = TextEditingController();
  final lastNameTextEditingController = TextEditingController();
  final ageTextEditingController = TextEditingController();
  final phoneNumberTextEditingController = TextEditingController();
  final locationTextEditingController = TextEditingController();
  final highSchoolTextEditingController = TextEditingController();
  final referralTextEditingController = TextEditingController();
  final collegeTextEditingController = TextEditingController();
  final tellUsTextEditingController = TextEditingController();

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

  /// gender list.
  List<String> genderList = [
    TranslationKeys.male.capitalizeFirst.toString(),
    TranslationKeys.female.capitalizeFirst.toString()
  ];

  /// used to store the value of selected Gender from gender list.
  String? selectedGender = '';

  /// used to store the value of selected year from experienceList.
  String? selectedYear = '';

  /// used to store the value of License from license list.
  String? licenseHaveOrNot = '';

  /// used to store the value of image from camera or galley.
  String? imageUrl = '';

  /// method used to pick the Image from gallery
  pickImage() async {
    Utility.showImagePicker(
      onGetImage: (image) {
        if (image.path.isNotEmpty) {
          log("check image is not null -->$image");
          imageUrl = image.path;
          update();
          log("check image is -->$image");
        } else {
          log("check image is  null -->${image.path}");
        }
      },
    );
  }

  /// create Profile Validator
  profileValidator() {
    bool isValidate = Validator.instance.createNannyProfileValidator(
      image: imageUrl ?? '',
      firstname: firstNameTextEditingController.text.trim(),
      lastName: lastNameTextEditingController.text.trim(),
      experience: selectedYear ?? '',
      highSchoolName: highSchoolTextEditingController.text.trim(),
      phoneNumber: phoneNumberTextEditingController.text.trim(),
      collegeName: collegeTextEditingController.text.trim(),
      age: ageTextEditingController.text.trim(),
    );
    if (isValidate) {
      RouteManagement.goToSelectServicesView();
    } else {
      toast(msg: Validator.instance.error, isError: true);
    }
  }

  // ---------------------- Select Services view --------------------------------------

  /// used to see the services list.
  List<Services> servicesList = Services.values;

  /// used to store the selectedServices Value.
  var selectedServices = [];

  /// used to validate service Screen.
  servicesValidator() {
    bool isValidate =
        Validator.instance.services(servicesList: selectedServices);
    if (isValidate) {
      RouteManagement.goToPricingView();
    } else {
      toast(msg: Validator.instance.error, isError: true);
    }
  }

//---------------------------------- Bank details View.------------------------//

  final bankNameTextEditingController = TextEditingController();
  final holderNameTextEditingController = TextEditingController();
  final accountNumberTextEditingController = TextEditingController();
  final routingNumberTextEditingController = TextEditingController();

  /// used to validate bank Detail Screen.
  bankDetailValidator() {
    bool isValidate = Validator.instance.bankDetailValidator(
      bankName: bankNameTextEditingController.text.trim(),
      accountHolderName: holderNameTextEditingController.text.trim(),
      accountNumber: accountNumberTextEditingController.text.tr,
      routingNumber: routingNumberTextEditingController.text.trim(),
    );
    if (isValidate) {
      RouteManagement.goToOffAllWaitingApprovalView();
      Future.delayed(
        const Duration(seconds: 5),
        () => RouteManagement.goToOffAllLogIn(),
      );
    } else {
      toast(msg: Validator.instance.error, isError: true);
    }
  }
}
