import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/models/nanny_profile_model.dart';
import 'package:northshore_nanny_flutter/app/utils/extensions.dart';

import '../../data/api/api_helper.dart';
import '../../res/constants/api_urls.dart';
import '../../res/constants/app_constants.dart';
import '../../utils/app_utils.dart';
import '../../utils/custom_toast.dart';
import '../../utils/translations/translation_keys.dart';

class NannyProfileController extends GetxController {
  final ApiHelper _apiHelper = ApiHelper.to;

  /// used to store data from backend
  var profileData = MyProfileModel();

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

  /// used to set the referral
  bool? isReferral = false;

  /// get api for nanny profile model
  Future<void> getProfile() async {
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
          profileData = response;
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
}
