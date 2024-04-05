import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:northshore_nanny_flutter/app/data/storage/storage.dart';
import 'package:northshore_nanny_flutter/app/modules/nanny_profile/nanny_profile_binding.dart';
import 'package:northshore_nanny_flutter/app/modules/nanny_profile/nanny_profile_controller.dart';
import 'package:northshore_nanny_flutter/app/res/constants/extensions.dart';

import '../../../../data/api/api_helper.dart';
import '../../../../models/nanny_profile_model.dart';
import '../../../../models/register_response_model.dart';
import '../../../../res/constants/api_urls.dart';
import '../../../../res/constants/app_constants.dart';
import '../../../../res/constants/enums.dart';
import '../../../../res/constants/string_contants.dart';
import '../../../../utils/app_utils.dart';
import '../../../../utils/custom_toast.dart';
import '../../../../utils/translations/translation_keys.dart';
import '../../../../utils/utility.dart';
import '../../../../utils/validators.dart';

class NannyEditProfileController extends GetxController {
  final ApiHelper _apiHelper = ApiHelper.to;

  final firstNameTextEditingController = TextEditingController();
  final lastNameTextEditingController = TextEditingController();
  DateTime? selectedDateOfBirth;
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

  List<String> selectedServices = [];

  /// gender list.
  List<String> genderList = [
    TranslationKeys.male.capitalizeFirst.toString(),
    TranslationKeys.female.capitalizeFirst.toString()
  ];

  String? selectedGender = '';
  String? selectedYear = '';
  String? licenseHaveOrNot = '';
  String? imageUrl = '';

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

  /// get api for nanny profile model
  Future<void> getEditProfile() async {
    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }
      _apiHelper
          .getPosts(
        ApiUrls.getNannyProfile,
      )
          .futureValue((value) {
        printInfo(info: "Get Nanny profile response value $value");
        var response = MyProfileModel.fromJson(value);
        if (response.response == AppConstants.apiResponseSuccess) {
          firstNameTextEditingController.text = response.data?.firstName ?? '';
          lastNameTextEditingController.text = response.data?.lastName ?? '';
          selectedDateOfBirth = response.data?.dob;
          phoneNumberTextEditingController.text = response.data?.mobileNo ?? '';
          locationTextEditingController.text = response.data?.location ?? '';
          highSchoolTextEditingController.text =
              response.data?.highSchool ?? '';
          collegeTextEditingController.text = response.data?.college ?? '';
          tellUsTextEditingController.text = response.data?.about ?? '';
          selectedGender = response.data?.gender == 1
              ? TranslationKeys.male.capitalizeFirst.toString()
              : response.data?.gender == 2
                  ? TranslationKeys.female.capitalizeFirst.toString()
                  : '';
          selectedYear = response.data?.experience;
          if (response.data?.isDrivingLicence != null) {
            if (response.data?.isDrivingLicence == true) {
              licenseHaveOrNot = TranslationKeys.yes.capitalizeFirst.toString();
            } else if (!response.data?.isDrivingLicence == false) {
              licenseHaveOrNot = TranslationKeys.no.capitalizeFirst.toString();
            }
          }

          selectedServices = response.data?.services ?? [];
          imageUrl = response.data?.image;
          update();
        } else {
          toast(msg: response.message.toString(), isError: true);
        }
      }, retryFunction: () {});
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      printError(info: "post Bank details  Nanny  API ISSUE $s");
    }
  }

  /// edit post api for create nanny profile
  Future<void> editProfile() async {
    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }
      FormData body = FormData({
        'Image': pickedImage != null || pickedImage?.path.isNotEmpty == true
            ? MultipartFile(pickedImage!.path,
                filename: pickedImage!.path.split('/').last)
            : imageUrl,
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
        "Latitude":
            Storage.getValue(StringConstants.latitude) ?? 30.7046.toString(),
        "Longitude":
            Storage.getValue(StringConstants.longitude) ?? 76.7179.toString(),
        'Experience': selectedYear,
        'NameOfHighSchool': highSchoolTextEditingController.text.trim(),
        'NameOfCollage': collegeTextEditingController.text.trim(),
        if (licenseHaveOrNot?.isNotEmpty == true)
          'IsDrivingLicense': licenseHaveOrNot?.toLowerCase() == 'yes'
              ? true
              : licenseHaveOrNot?.toLowerCase() == 'no'
                  ? false
                  : null,
        'AboutMe': tellUsTextEditingController.text.trim(),
      });

      log('edit body:${body.fields.toString()}');
      log("auth token:-->> ${Storage.getValue(StringConstants.token)}");

      _apiHelper.postApi(ApiUrls.customerCreateProfile, body).futureValue(
          (value) {
        printInfo(info: "Edit Nanny profile response value $value");
        var response = RegisterModelResponseJson.fromJson(value);
        if (response.response == AppConstants.apiResponseSuccess) {
          if (!Get.isRegistered<NannyProfileController>()) {
            NannyProfileBinding().dependencies();
          }
          Get.find<NannyProfileController>().getProfile();
          Get.find<NannyProfileController>().update();
          Get.back();
          toast(msg: response.message.toString(), isError: false);
        } else {
          toast(msg: response.message.toString(), isError: true);
        }
      }, retryFunction: () {});
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      printError(info: "Edit Nanny PROFILE API ISSUE $s");
    }
  }

  /// edit Profile Validator
  editProfileValidator() {
    bool isValidate = Validator.instance.createNannyProfileValidator(
      image: pickedImage != null || pickedImage?.path.isNotEmpty == true
          ? pickedImage?.path ?? ''
          : imageUrl.toString(),
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
      editProfile();
    } else {
      toast(msg: Validator.instance.error, isError: true);
    }
  }

  /// used to validate edit service Screen.
  editServicesValidator() {
    bool isValidate =
        Validator.instance.services(servicesList: selectedServices);
    if (isValidate) {
      editSelectServices();
    } else {
      toast(msg: Validator.instance.error, isError: true);
    }
  }

  /// edit post api for select services
  Future<void> editSelectServices() async {
    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }
      var body = {
        'services': selectedServices,
      };

      log("body:$body");

      _apiHelper.postApi(ApiUrls.addOrEditServices, body).futureValue((value) {
        printInfo(
            info: "Edit Select Services  Nanny profile response value $value");
        var response = RegisterModelResponseJson.fromJson(value);
        if (response.response == AppConstants.apiResponseSuccess) {
          if (!Get.isRegistered<NannyProfileController>()) {
            NannyProfileBinding().dependencies();
          }
          Get.find<NannyProfileController>().getProfile();
          Get.find<NannyProfileController>().update();
          Get.back();
          toast(msg: response.message.toString(), isError: false);
        } else {
          toast(msg: response.message.toString(), isError: true);
        }
      }, retryFunction: () {});
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      printError(info: "Edit Select Services  Nanny  API ISSUE $s");
    }
  }

  /// update location
  updateLocationAddress({required String address}) {
    locationTextEditingController.text = address;
    update();
  }
}
