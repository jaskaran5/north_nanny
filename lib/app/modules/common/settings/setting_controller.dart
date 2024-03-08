import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/data/storage/storage.dart';
import 'package:northshore_nanny_flutter/app/models/customer_profile_response_model.dart';
import 'package:northshore_nanny_flutter/app/modules/common/common_web_view/common_web_view.dart';
import 'package:northshore_nanny_flutter/app/modules/nanny/nanny_views/nanny_edit_profile/nanny_edit_profile_controller.dart';
import 'package:northshore_nanny_flutter/app/modules/nanny_profile/nanny_profile_binding.dart';
import 'package:northshore_nanny_flutter/app/modules/nanny_profile/nanny_profile_controller.dart';
import 'package:northshore_nanny_flutter/app/res/constants/string_contants.dart';
import 'package:northshore_nanny_flutter/app/utils/custom_toast.dart';
import 'package:northshore_nanny_flutter/app/utils/extensions.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/utils/validators.dart';
import 'package:northshore_nanny_flutter/navigators/app_routes.dart';

import '../../../../navigators/routes_management.dart';
import '../../../data/api/api_helper.dart';
import '../../../models/register_response_model.dart';
import '../../../res/constants/api_urls.dart';
import '../../../res/constants/app_constants.dart';
import '../../../res/constants/assets.dart';
import '../../../res/theme/dimens.dart';
import '../../../utils/app_utils.dart';
import '../../../utils/utility.dart';
import '../../nanny/nanny_views/nanny_edit_profile/nanny_edit_profile_binding.dart';

class SettingController extends GetxController {
  final ApiHelper _apiHelper = ApiHelper.to;

  /// ------------ contact us textEditing controllers ------------------//
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController subjectTextEditingController = TextEditingController();
  TextEditingController messageTextEditingController = TextEditingController();

  RxBool isExpand = false.obs;
  RxString loginType = ''.obs;

  RxString customerFirstName = ''.obs;
  RxString customerLastName = ''.obs;

  RxString customerEmail = ''.obs;
  RxString customerImg = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getAndUpdateLoginType();
  }

  getAndUpdateLoginType() async {
    loginType.value = await Storage.getValue(StringConstants.loginType);

    log("login type is:-->> ${loginType.value}");

    if (loginType.value == StringConstants.nanny) {
      getNannyProfileApi();
    } else if (loginType.value == StringConstants.customer) {
      getCustomerProfileApi();
    }

    update();
  }

  RxInt? expandIndex;

  /// Go to Rating and Review  Screen
  redirectToPasswordChangedScreen() {
    Get.toNamed(
      Routes.passwordChangedView,
    );
  }

  updateIsExpand({index}) {
    // if (index != expandIndex) {
    //   isExpand.value = !isExpand.value;
    //   print(expandIndex!.value);
    // }
    faqlist.elementAt(index)["isExpand"] =
        !faqlist.elementAt(index)["isExpand"];

    update();
  }

  /// CUSTOMER SETTING LIST------------------------------------- 12  CUSTOMER

  final customerSettingList = [
    {
      "name": TranslationKeys.favorites.tr,
      "icon": Assets.iconsHeartOutline,
      "trallingIcon": Assets.iconsNext,
    },
    {
      "name": TranslationKeys.mangeChildProfile.tr,
      "icon": Assets.iconsBabyBoy,
      "trallingIcon": Assets.iconsNext
    },
    {
      "name": TranslationKeys.paymentMethod.tr,
      "icon": Assets.iconsCard,
      "trallingIcon": Assets.iconsNext
    },
    {
      "name": TranslationKeys.changePassword.tr,
      "icon": Assets.iconsLock,
      "trallingIcon": Assets.iconsNext
    },
    {
      "name": TranslationKeys.aboutUs.tr,
      "icon": Assets.iconsAboutUs,
      "trallingIcon": Assets.iconsNext
    },
    {
      "name": TranslationKeys.inviteAFriend.tr,
      "icon": Assets.iconsProfileAdd,
      "trallingIcon": Assets.iconsNext
    },
    {
      "name": TranslationKeys.contactUs.tr,
      "icon": Assets.iconsHeadPhone,
      "trallingIcon": Assets.iconsNext
    },
    {
      "name": TranslationKeys.rateApp.tr,
      "icon": Assets.iconsBlackStar,
      "trallingIcon": Assets.iconsNext
    },
    {
      "name": TranslationKeys.fAQ.tr,
      "icon": Assets.iconsMessageQuestion,
      "trallingIcon": Assets.iconsNext
    },
    {
      "name": TranslationKeys.termAndConditions.tr,
      "icon": Assets.iconsDocumentText,
      "trallingIcon": Assets.iconsNext
    },
    {
      "name": TranslationKeys.privacyPolicy.tr,
      "icon": Assets.iconsShieldSecurity,
      "trallingIcon": Assets.iconsNext
    },
    {
      "name": TranslationKeys.logOut.tr,
      "icon": Assets.iconsLogout,
      "trallingIcon": Assets.iconsNext
    },
  ];

  /// NANNY SETTING LIST ---------------------------------------------- 10  NANNY

  final nannySettingList = [
    /***m BANK DETAILS */
    {
      "name": TranslationKeys.bankDetails.tr,
      "icon": Assets.iconsBank,
      "trallingIcon": Assets.iconsNext
    },

    /** CHANGE PASSWORD */

    {
      "name": TranslationKeys.changePassword.tr,
      "icon": Assets.iconsLock,
      "trallingIcon": Assets.iconsNext
    },

    /** ABOUT US */
    {
      "name": TranslationKeys.aboutUs.tr,
      "icon": Assets.iconsAboutUs,
      "trallingIcon": Assets.iconsNext
    },

    /** INVITE A FRIEND */

    {
      "name": TranslationKeys.inviteAFriend.tr,
      "icon": Assets.iconsProfileAdd,
      "trallingIcon": Assets.iconsNext
    },

    /** CONTACT US */

    {
      "name": TranslationKeys.contactUs.tr,
      "icon": Assets.iconsHeadPhone,
      "trallingIcon": Assets.iconsNext
    },

    /** RATE APP */
    {
      "name": TranslationKeys.rateApp.tr,
      "icon": Assets.iconsBlackStar,
      "trallingIcon": Assets.iconsNext
    },
    /** FAQ */
    {
      "name": TranslationKeys.fAQ.tr,
      "icon": Assets.iconsMessageQuestion,
      "trallingIcon": Assets.iconsNext
    },

    /** TERMS AND CONDITIONS */
    {
      "name": TranslationKeys.termAndConditions.tr,
      "icon": Assets.iconsDocumentText,
      "trallingIcon": Assets.iconsNext
    },

    /** PRIVACY POLICY */
    {
      "name": TranslationKeys.privacyPolicy.tr,
      "icon": Assets.iconsShieldSecurity,
      "trallingIcon": Assets.iconsNext
    },
    /** LOG OUT */
    {
      "name": TranslationKeys.logOut.tr,
      "icon": Assets.iconsLogout,
      "trallingIcon": Assets.iconsNext
    },
  ];

  RxList faqlist = [
    {
      "title": "How are you? click on me",
      "subtitle": "This is m,y expanded suybttile",
      "isExpand": false,
    },
    {
      "title": "How are you? click on me",
      "subtitle": "This is m,y expanded suybttile",
      "isExpand": false,
    },
    {
      "title": "How are you? click on me",
      "subtitle": "This is m,y expanded suybttile",
      "isExpand": true,
    },
    {
      "title": "How are you? click on me",
      "subtitle": "This is m,y expanded suybttile",
      "isExpand": false,
    },
    {
      "title": "How are you? click on me",
      "subtitle": "This is m,y expanded suybttile",
      "isExpand": false,
    }
  ].obs;

  /// card list.
  List cardList = [
    {
      'asset': Assets.iconsMasterCard,
      'accountNumber': "9587 5498 8569 7569",
      'cardType': 'Master Card',
      'isSelected': true,
    },
    {
      'asset': Assets.iconsVisa,
      'accountNumber': "9587 5498 8569 7569",
      'cardType': 'Visa',
      'isSelected': false,
    }
  ];

  /// REDIRECT TO COMMON WEB VIEW
  redirectToCommonWebView() {
    Get.to(() => const CommonWebView());
  }

  /// invite friend list to do
  var inviteList = [
    'Download the Northshore Nanny app using your unique link below',
    'Create an account on the app',
    'Accept a job!',
  ];

  /// validator for contact us
  contactUsValidator() {
    bool isValidate = Validator.instance.contactUsValidator(
      emailTextEditingController.text.trim(),
      subjectTextEditingController.text.trim(),
      messageTextEditingController.text.trim(),
    );
    if (isValidate) {
      postContactUsData();
    } else {
      toast(msg: Validator.instance.error, isError: true);
    }
  }

  /// post api to upload contact us
  postContactUsData() async {
    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }

      var body = {
        'email': emailTextEditingController.text.trim(),
        "subject": subjectTextEditingController.text.trim(),
        "message": messageTextEditingController.text.trim()
      };

      log("Contact Us body :$body");

      _apiHelper.postApi(ApiUrls.contactUs, body).futureValue((value) {
        printInfo(info: "Contact Us response value $value");
        var response = RegisterModelResponseJson.fromJson(value);
        if (response.response == AppConstants.apiResponseSuccess) {
          Utility.showDialog(
            assetName: Assets.iconsSuccess,
            title: 'Thank You',
            subTitle: 'Your submission has been sent.',
            buttonTitleText: 'okay',
            assetWidth: Dimens.sixtyEight,
            assetHeight: Dimens.sixtyEight,
            titleMaxLine: 1,
            subTitleMaxLine: 1,
            onTapButton: Get.back,
            isImage: false,
            showCrossSvg: false,
          );
          toast(msg: response.message.toString(), isError: false);
        } else {
          toast(msg: response.message.toString(), isError: true);
        }
      }, retryFunction: () {});
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      printError(info: "Contact Us post  API ISSUE $s");
    }
  }

  /// log out api
  logOutApi() async {
    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }

      _apiHelper.postApi(ApiUrls.customerLogOut, null).futureValue((value) {
        printInfo(info: "log out value $value");
        var response = RegisterModelResponseJson.fromJson(value);
        if (response.response == AppConstants.apiResponseSuccess) {
          Storage.removeValue(StringConstants.isLogin);
          RouteManagement.goToOffAllLogIn();
          toast(msg: response.message.toString(), isError: false);
        } else {
          toast(msg: response.message.toString(), isError: true);
        }
      }, retryFunction: () {});
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      printError(info: "log out  post API ISSUE $s");
    }
  }

  /// nanny Name
  RxString nannyName = ''.obs;

  /// nanny email
  RxString nannyEmail = ''.obs;

  /// nanny image
  RxString nannyImage = ''.obs;

  /// get nanny Profile Api
  getNannyProfileApi() {
    if (!Get.isRegistered<NannyProfileController>()) {
      NannyProfileBinding().dependencies();
    }
    var controller = Get.find<NannyProfileController>();
    controller.getProfile();
    if (!Get.isRegistered<NannyEditProfileController>()) {
      NannyEditProfileBinding().dependencies();
    }
    Get.find<NannyEditProfileController>().getEditProfile();

    update();
  }

  /// GET CUSTOMER PROFILE API

  getCustomerProfileApi() {
    _apiHelper.getPosts(ApiUrls.customerGetProfile).futureValue(
      (value) {
        printInfo(info: "get customer profile api:-->> $value");

        var res = CustomerProfileResponseModel.fromJson(value);

        if (res.response == AppConstants.apiResponseSuccess) {
          customerFirstName.value = res.customerProfileData!.firstName!;
          customerLastName.value = res.customerProfileData!.lastName!;
          customerEmail.value = res.customerProfileData!.email!;

          customerImg.value = res.customerProfileData!.image!;

          update();
        }
      },
      retryFunction: () {
        getCustomerProfileApi();
      },
    );
  }

  /// ********REDIRECT TO CUSTOMER PROFILE

  redirectToCustomerProfileScreen() async {
    bool check = await Get.toNamed(Routes.myProfileView);

    if (check) {
      getCustomerProfileApi();
    }
  }
}
