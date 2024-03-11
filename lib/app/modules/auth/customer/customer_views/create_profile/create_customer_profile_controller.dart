import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:northshore_nanny_flutter/app/data/api/api_helper.dart';
import 'package:northshore_nanny_flutter/app/data/storage/storage.dart';
import 'package:northshore_nanny_flutter/app/models/register_response_model.dart';
import 'package:northshore_nanny_flutter/app/res/constants/api_urls.dart';
import 'package:northshore_nanny_flutter/app/res/constants/app_constants.dart';
import 'package:northshore_nanny_flutter/app/res/constants/enums.dart';
import 'package:northshore_nanny_flutter/app/res/constants/extensions.dart';
import 'package:northshore_nanny_flutter/app/res/constants/string_contants.dart';
import 'package:northshore_nanny_flutter/app/utils/app_utils.dart';
import 'package:northshore_nanny_flutter/app/utils/custom_toast.dart';
import 'package:northshore_nanny_flutter/app/utils/extensions.dart';
import 'package:northshore_nanny_flutter/app/utils/utility.dart';
import 'package:northshore_nanny_flutter/app/utils/validators.dart';
import 'package:northshore_nanny_flutter/navigators/routes_management.dart';

class CreateCustomerProfileController extends GetxController {
  final ApiHelper _apiHelper = ApiHelper.to;
  final firstNameTextEditingController = TextEditingController();
  final lastNameTextEditingController = TextEditingController();
  final phoneNumberTextEditingController = TextEditingController();
  final locationTextEditingController = TextEditingController();
  final referrelCodeTextEditingController = TextEditingController();

  CroppedFile? pickedImage;

  String imageUrl = '';
  RxString coordinates = "".obs;

  /// selected Gender
  String? selectedGender = '';

  /// gender list.
  List<String> genderList = GenderConstant.values
      .map((e) => e.genderName.capitalizeFirst.toString())
      .toList();

  /// storeGenderValue
  void setGenderValue(String gender) {
    selectedGender = gender;
    update();
  }

  /// Show CAMERA and Gallery option
  onClickOnProfilePic() {
    Utility.showImagePicker(
      onGetImage: (image) {
        log("picker image is :-->> ${image.path}");

        pickedImage = image;
        update();
      },
    );
  }

  /// -------->>>>>>>>>> UPDATE LOCATION <<<<<<<<<<---------
  Future<void> updateLocationTextField({required String position}) async {
    locationTextEditingController.text = position;
    update();
  }

  /// CUSTOMER SIGN UP VALIDATION----------------------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  Future<void> customerSignUpValidation() async {
    bool valid = Validator.instance.customerCreateProfileValidator(
      firstName: firstNameTextEditingController.text.trim(),
      lastName: lastNameTextEditingController.text.trim(),
      coordinates: locationTextEditingController.text.trim(),
      phoneNumber: phoneNumberTextEditingController.text.trim(),
    );
    if (valid) {
      createCustomerProfileSignUp();
      // Get.to(
      //   const ChildProfileView(),
      // );

      /// sign up api
    } else {
      toast(msg: Validator.instance.error, isError: true);
    }
  }

  /// Create Customer profile API=========== >>>>>>>>>>>>>
  Future<void> createCustomerProfileSignUp() async {
    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }

      var lat = Storage.getValue(StringConstants.latitude) ?? 30.7046 ?? 30;
      var lang = Storage.getValue(StringConstants.longitude) ?? 76.7179;

      FormData body = FormData({
        if (pickedImage != null)
          'Image': MultipartFile(pickedImage!.path,
              filename: pickedImage!.path.split('/').last),

        "FirstName": firstNameTextEditingController.text.trim(),
        "LastName": lastNameTextEditingController.text.trim(),
        "MobileNumber": phoneNumberTextEditingController.text.trim(),
        if (selectedGender!.isNotEmpty)
          "gender": selectedGender == 'Male' ? 1 : 2,
        "Latitude": lat.toString(),
        "Longitude": lang.toString(),
        // "Location": firstNameTextEditingController.text.trim(),
        "ReferralCode": referrelCodeTextEditingController.text.trim()
      });

      log(body.fields.toString());
      log("auth token:-->> ${Storage.getValue(StringConstants.token)}");

      _apiHelper.postApi(ApiUrls.customerCreateProfile, body).futureValue(
          (value) {
        printInfo(info: "create customer profile response value $value");
        var res = RegisterModelResponseJson.fromJson(value);

        if (res.response == AppConstants.apiResponseSuccess) {
          toast(msg: res.message!, isError: false);

          RouteManagement.goToChooseChildProfileView();

          // Get.to(
          //   const ChildProfileView(),
          // );
        } else {
          toast(msg: res.message!, isError: true);
        }

        // if (value['status'] == 200) {
        //   var respose = RegisterModelResponseJson.fromJson(value);
        // }
      }, retryFunction: () {
        createCustomerProfileSignUp();
      });
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      printError(info: "CREATE PROFILE API ISSUE $s");
    }
  }
}
