import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:northshore_nanny_flutter/app/data/storage/storage.dart';
import 'package:northshore_nanny_flutter/app/models/register_response_model.dart';
import 'package:northshore_nanny_flutter/app/res/constants/enums.dart';
import 'package:northshore_nanny_flutter/app/res/constants/extensions.dart';
import 'package:northshore_nanny_flutter/app/utils/custom_toast.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/utils/utility.dart';
import 'package:northshore_nanny_flutter/app/utils/validators.dart';

import '../../../../../navigators/routes_management.dart';
import '../../../../data/api/api_helper.dart';
import '../../../../res/constants/api_urls.dart';
import '../../../../res/constants/app_constants.dart';
import '../../../../res/constants/string_contants.dart';
import '../../../../utils/app_utils.dart';

class CreateNannyProfileController extends GetxController {
  final ApiHelper _apiHelper = ApiHelper.to;

  /// create nanny profile controllers.
  final firstNameTextEditingController = TextEditingController();
  final lastNameTextEditingController = TextEditingController();
  DateTime? selectedDateOfBirth;
  final phoneNumberTextEditingController = TextEditingController();
  final locationTextEditingController = TextEditingController();
  final highSchoolTextEditingController = TextEditingController();
  final referralTextEditingController = TextEditingController();
  final collegeTextEditingController = TextEditingController();
  final tellUsTextEditingController = TextEditingController();

  String latitude = '';
  String longitude = '';

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
  CroppedFile? pickedImage;

  /// method used to pick the Image from gallery
  pickImage() async {
    Utility.showImagePicker(
      onGetImage: (image) {
        if (image.path.isNotEmpty) {
          log("check image is not null -->${image.path}");
          pickedImage = image;
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
    log('selectedDob:${selectedDateOfBirth.toString()}');
    bool isValidate = Validator.instance.createNannyProfileValidator(
      image: pickedImage?.path ?? '',
      firstname: firstNameTextEditingController.text.trim(),
      lastName: lastNameTextEditingController.text.trim(),
      experience: selectedYear ?? '',
      highSchoolName: highSchoolTextEditingController.text.trim(),
      phoneNumber: phoneNumberTextEditingController.text.trim(),
      collegeName: collegeTextEditingController.text.trim(),
      age: selectedDateOfBirth == null ? '' : selectedDateOfBirth.toString(),
      location: locationTextEditingController.text.trim(),
      aboutYourSelf: tellUsTextEditingController.text.trim(),
    );
    if (isValidate) {
      createProfile();
    } else {
      toast(msg: Validator.instance.error, isError: true);
    }
  }

  /// post api for create nanny profile
  Future<void> createProfile() async {
    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }
      FormData body = FormData({
        if (pickedImage != null)
          'Image': MultipartFile(pickedImage!.path,
              filename: pickedImage!.path.split('/').last),
        "FirstName": firstNameTextEditingController.text.trim(),
        "LastName": lastNameTextEditingController.text.trim(),
        'Dob': selectedDateOfBirth,
        "MobileNumber": phoneNumberTextEditingController.text.trim(),
        if (selectedGender?.isNotEmpty == true)
          "Gender": selectedGender?.toLowerCase() == 'male'
              ? 1
              : selectedGender?.toLowerCase() == "female"
                  ? 2
                  : 0,
        "Location": locationTextEditingController.text.trim(),
        "Latitude": latitude.isNotEmpty
            ? latitude
            : Storage.getValue(StringConstants.latitude),
        "Longitude": longitude.isNotEmpty
            ? longitude
            : Storage.getValue(StringConstants.longitude),
        'Experience': selectedYear,
        'NameOfHighSchool': highSchoolTextEditingController.text.trim(),
        'NameOfCollage': collegeTextEditingController.text.trim(),
        if (licenseHaveOrNot?.isNotEmpty == true)
          'IsDrivingLicense':
              licenseHaveOrNot?.toLowerCase() == 'yes' ? true : false,
        'AboutMe': tellUsTextEditingController.text.trim(),
        if (referralTextEditingController.text.isNotEmpty)
          "ReferralCode": referralTextEditingController.text.trim()
      });

      log('body of  create nanny profile :${body.fields.toString()}');
      log("auth token:-->> ${Storage.getValue(StringConstants.token)}");

      _apiHelper.postApi(ApiUrls.customerCreateProfile, body).futureValue(
          (value) {
        printInfo(info: "create Nanny profile response value $value");
        var response = RegisterModelResponseJson.fromJson(value);
        if (response.response == AppConstants.apiResponseSuccess) {
          RouteManagement.goToSelectServicesView();
          toast(msg: response.message.toString(), isError: false);
        } else {
          toast(msg: response.message.toString(), isError: true);
        }
      }, retryFunction: () {});
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      printError(info: "CREATE Nanny PROFILE API ISSUE $s");
    }
  }

  /// ---------------------- Select Services view --------------------------------------

  /// used to see the services list.
  List<Services> servicesList = Services.values;

  /// used to store the selectedServices Value.
  var selectedServices = [];

  /// used to validate service Screen.
  servicesValidator() {
    bool isValidate =
        Validator.instance.services(servicesList: selectedServices);
    if (isValidate) {
      selectServices();
    } else {
      toast(msg: Validator.instance.error, isError: true);
    }
  }

  /// post api for select services
  Future<void> selectServices() async {
    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }
      var body = {
        'services': selectedServices,
      };

      log("body:$body");

      _apiHelper.postApi(ApiUrls.addOrEditServices, body).futureValue((value) {
        printInfo(info: "Select Services  Nanny profile response value $value");
        var response = RegisterModelResponseJson.fromJson(value);
        if (response.response == AppConstants.apiResponseSuccess) {
          RouteManagement.goToPricingView();
          toast(msg: response.message.toString(), isError: false);
        } else {
          toast(msg: response.message.toString(), isError: true);
        }
      }, retryFunction: () {});
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      printError(info: "Select Services  Nanny  API ISSUE $s");
    }
  }

//---------------------------------- Bank details View.------------------------//

  final bankNameTextEditingController = TextEditingController();
  final holderNameTextEditingController = TextEditingController();
  final accountNumberTextEditingController = TextEditingController();
  final routingNumberTextEditingController = TextEditingController();
  final addressOne = TextEditingController();
  final addressTwo = TextEditingController();
  final cityTextEditingController = TextEditingController();
  final stateTextEditingController = TextEditingController();
  final postalCodeTextEditingController = TextEditingController();
  final countryTextEditingController = TextEditingController();

  /// used to validate bank Detail Screen.
  bankDetailValidator() {
    bool isValidate = Validator.instance.bankDetailValidator(
      bankName: bankNameTextEditingController.text.trim(),
      accountHolderName: holderNameTextEditingController.text.trim(),
      accountNumber: accountNumberTextEditingController.text.tr,
      routingNumber: routingNumberTextEditingController.text.trim(),
      addressOne: addressOne.text.trim(),
      // otherAddress: addressTwo.text.trim(),
      city: cityTextEditingController.text.trim(),
      state: stateTextEditingController.text.trim(),
      country: countryTextEditingController.text.trim(),
      postalCode: postalCodeTextEditingController.text.trim(),
    );
    if (isValidate) {
      postBankDetails(isComeFromSkip: false);
    } else {
      toast(msg: Validator.instance.error, isError: true);
    }
  }

  /// post api for bank details.
  Future<void> postBankDetails({required bool isComeFromSkip}) async {
    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }
      dynamic body;
      if (isComeFromSkip) {
        body = {
          'isSkipBankDetail': isComeFromSkip,
        };
      } else {
        body = {
          'isSkipBankDetail': isComeFromSkip,
          'bankName': bankNameTextEditingController.text.trim(),
          'accountHolderName': holderNameTextEditingController.text.trim(),
          'accountNumber': accountNumberTextEditingController.text.trim(),
          'routingNumber': routingNumberTextEditingController.text.trim(),
          "address1": addressOne.text.trim(),
          "address2": addressTwo.text.trim(),
          "city": cityTextEditingController.text.trim(),
          "postalCode": postalCodeTextEditingController.text.trim(),
          "state": stateTextEditingController.text.trim(),
          "country": countryTextEditingController.text.trim(),
        };
      }

      log("body of bank details :$body");

      _apiHelper.postApi(ApiUrls.addOrEditBankDetails, body).futureValue(
          (value) {
        printInfo(
            info: "Post bank details Nanny profile response value $value");
        var response = RegisterModelResponseJson.fromJson(value);
        if (response.response == AppConstants.apiResponseSuccess) {
          if (isComeFromSkip) {
            RouteManagement.goToOffAllWaitingApprovalView();
          } else {
            RouteManagement.goToOffAllWaitingApprovalView();
          }
        } else {
          toast(msg: response.message.toString(), isError: true);
        }
      }, retryFunction: () {});
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      printError(info: "post Bank details  Nanny  API ISSUE $s");
    }
  }

  /// -------->>>>>>>>>> UPDATE LOCATION <<<<<<<<<<---------
  Future<void> updateLocationTextField({
    required String formatAddress,
    required String lat,
    required String long,
  }) async {
    log('location in Nanny create profile >>>>>>> $formatAddress  $lat $long');

    locationTextEditingController.text = formatAddress;
    latitude = lat;
    longitude = long;
    update();
  }
}
