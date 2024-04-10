import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/data/api/api_helper.dart';
import 'package:northshore_nanny_flutter/app/models/get_bank_detail_model.dart';
import 'package:northshore_nanny_flutter/app/res/constants/extensions.dart';

import '../../../../models/register_response_model.dart';
import '../../../../res/constants/api_urls.dart';
import '../../../../res/constants/app_constants.dart';
import '../../../../utils/app_utils.dart';
import '../../../../utils/custom_toast.dart';
import '../../../../utils/validators.dart';

class AddBankDetailController extends GetxController {
  ApiHelper apiHelper = ApiHelper.to;

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
  bankDetailValidator({required bool isComeFromBooking}) {
    bool isValidate = Validator.instance.bankDetailValidator(
      bankName: bankNameTextEditingController.text.trim(),
      accountHolderName: holderNameTextEditingController.text.trim(),
      accountNumber: accountNumberTextEditingController.text.tr,
      routingNumber: routingNumberTextEditingController.text.trim(),
      addressOne: addressOne.text.trim(),
      otherAddress: addressTwo.text.trim(),
      city: cityTextEditingController.text.trim(),
      state: stateTextEditingController.text.trim(),
      country: countryTextEditingController.text.trim(),
      postalCode: postalCodeTextEditingController.text.trim(),
    );
    if (isValidate) {
      postBankDetails(isComeFromBooking: isComeFromBooking);
    } else {
      toast(msg: Validator.instance.error, isError: true);
    }
  }

  /// post api for bank details.
  Future<void> postBankDetails({required bool isComeFromBooking}) async {
    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }
      dynamic body;

      body = {
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

      log("body of bank details :$body");

      apiHelper.postApi(ApiUrls.addOrEditBankDetails, body).futureValue(
          (value) async {
        printInfo(
            info: "Post bank details Nanny profile response value $value");
        var response = RegisterModelResponseJson.fromJson(value);
        if (response.response == AppConstants.apiResponseSuccess) {
          if (isComeFromBooking) {
            Get.back();
            Get.back();
          } else {
            Get.back();
          }
          getBankDetails();
        } else {
          toast(msg: response.message.toString(), isError: true);
        }
      }, retryFunction: () {});
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      printError(info: "post Bank details  Nanny  API ISSUE $s");
    }
  }

  /// post api for delete  bank details.
  Future<void> deleteBankDetails() async {
    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }

      apiHelper.postApi(ApiUrls.deleteBankDetails, null).futureValue((value) {
        printInfo(
            info: "Delete  bank details Nanny profile response value $value");
        var response = RegisterModelResponseJson.fromJson(value);
        if (response.response == AppConstants.apiResponseSuccess) {
          getBankDetails();
        } else {
          toast(msg: response.message.toString(), isError: true);
        }
      }, retryFunction: () {});
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      printError(info: "Delete Bank details  Nanny  API ISSUE $s");
    }
  }

  /// used to store the bankDetail.
  GetBankDetailResponse? bankDetailResponse;

  /// get api for bank details.
  Future<void> getBankDetails() async {
    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }

      apiHelper
          .getPosts(
        ApiUrls.getBankDetail,
      )
          .futureValue((value) {
        printInfo(info: "Get bank details Nanny profile response value $value");
        var response = GetBankDetailResponse.fromJson(value);
        if (response.response == AppConstants.apiResponseSuccess) {
          bankDetailResponse = response;
          update();
        } else {
          toast(msg: response.message.toString(), isError: true);
        }
      }, retryFunction: () {});
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      printError(info: "Get Bank details  Nanny  API ISSUE $s");
    }
  }
}
