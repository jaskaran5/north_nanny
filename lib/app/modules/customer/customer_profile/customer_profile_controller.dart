import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:northshore_nanny_flutter/app/data/api/api_helper.dart';
import 'package:northshore_nanny_flutter/app/data/storage/storage.dart';
import 'package:northshore_nanny_flutter/app/models/customer_profile_response_model.dart';
import 'package:northshore_nanny_flutter/app/models/register_response_model.dart';
import 'package:northshore_nanny_flutter/app/res/constants/api_urls.dart';
import 'package:northshore_nanny_flutter/app/res/constants/app_constants.dart';
import 'package:northshore_nanny_flutter/app/res/constants/string_contants.dart';
import 'package:northshore_nanny_flutter/app/utils/app_utils.dart';
import 'package:northshore_nanny_flutter/app/utils/custom_toast.dart';
import 'package:northshore_nanny_flutter/app/utils/extensions.dart';
import 'package:northshore_nanny_flutter/app/utils/helper.dart';
import 'package:northshore_nanny_flutter/app/utils/utility.dart';
import 'package:northshore_nanny_flutter/navigators/app_routes.dart';

class CustomerProfileController extends GetxController {
  final ApiHelper _apiHelper = ApiHelper.to;

  RxString customerName = ''.obs;
  RxString customerEmail = ''.obs;
  RxString referralEarned = '0'.obs;
  CroppedFile? pickedImage;

  RxString customerImageUrl =
      'https://images.unsplash.com/photo-1544005313-94ddf0286df2?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8cGVyc29ufGVufDB8fDB8fHww'
          .obs;
  RxString customerAddress = ''.obs;
  RxString customerPhoneNumber = ''.obs;
  final firstNameTextEditingController = TextEditingController();
  final lastNameTextEditingController = TextEditingController();
  final phoneNumberTextEditingController = TextEditingController();
  final locationTextEditingController = TextEditingController();

  @override
  void onInit() {
    // editProfileInit();

    super.onInit();
  }

  // editProfileInit() {
  //   firstNameTextEditingController.text = 'Michael';
  //   lastNameTextEditingController.text = 'Johnson';
  //   phoneNumberTextEditingController.text = '+1-773 856 9258';
  //   locationTextEditingController.text = 'Chicago, Naperville';
  //   update();
  // }

  /// GET CUSTOMER PROFILE API

  getCustomerProfileApi() {
    _apiHelper.getPosts(ApiUrls.customerGetProfile).futureValue(
      (value) {
        printInfo(info: "get customer profile api:-->> $value");

        var res = CustomerProfileResponseModel.fromJson(value);

        if (res.response == AppConstants.apiResponseSuccess) {
          customerName.value = addStringsWithSpace(
              res.customerProfileData!.firstName!,
              res.customerProfileData!.lastName!);

          customerAddress.value = res.customerProfileData!.location!;
          customerEmail.value = res.customerProfileData!.email!;
          customerPhoneNumber.value = res.customerProfileData!.mobileNo!;
          customerImageUrl.value = res.customerProfileData!.image!;
          referralEarned.value = res.customerProfileData!.referralsEarned;

          updateEditProfileFields(
            firstName: res.customerProfileData!.firstName!,
            lastName: res.customerProfileData!.lastName!,
            location: res.customerProfileData!.location!,
            phoneNumber: res.customerProfileData!.mobileNo!,
          );
          update();
        }
      },
      retryFunction: () {
        getCustomerProfileApi();
      },
    );
  }

  @override
  void onReady() {
    getCustomerProfileApi();
    super.onReady();
  }

  updateEditProfileFields({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String location,
  }) {
    firstNameTextEditingController.text = firstName;
    lastNameTextEditingController.text = lastName;
    phoneNumberTextEditingController.text = phoneNumber;
    locationTextEditingController.text = location;
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

  /// ===========>>>>>>>>>> UPDATE CUSTOMER DATA---------------

  Future<void> updateCustomerData() async {
    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }

      var lat = Storage.getValue(StringConstants.latitude);
      var lang = Storage.getValue(StringConstants.longitude);

      FormData body = FormData({
        'Image': ((pickedImage != null) == true)
            ? MultipartFile(pickedImage!.path,
                filename: pickedImage!.path.split('/').last)
            : customerImageUrl.value,
        "FirstName": firstNameTextEditingController.text.trim(),
        "LastName": lastNameTextEditingController.text.trim(),
        "MobileNumber": phoneNumberTextEditingController.text.trim(),
        "Latitude": lat.toString(),
        "Logngitude": lang.toString(),
      });

      log(body.fields.toString());
      log("auth token:-->> ${Storage.getValue(StringConstants.token)}");

      _apiHelper.postApi(ApiUrls.customerCreateProfile, body).futureValue(
          (value) {
        printInfo(info: "create customer profile response value $value");
        var res = RegisterModelResponseJson.fromJson(value);

        if (res.response == AppConstants.apiResponseSuccess) {
          toast(msg: res.message!, isError: false);

          Get.back(result: true);
        } else {
          toast(msg: res.message!, isError: true);
        }
      }, retryFunction: () {
        updateCustomerData();
      });
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      printError(info: "CREATE PROFILE API ISSUE $s");
    }
  }

  redirectToEditProfileScreen() async {
    bool check = await Get.toNamed(
      Routes.ediProfileView,
    );

    if (check) {
      getCustomerProfileApi();
    }
  }

  /// update location

  updateLocationAddress({required String address}) {
    locationTextEditingController.text = address;
    update();
  }
}
