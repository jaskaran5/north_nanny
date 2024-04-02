import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/common/payment_details/strip_web_view.dart';
import 'package:northshore_nanny_flutter/app/res/constants/extensions.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../data/api/api_helper.dart';
import '../../../models/add_payment_response_model.dart';
import '../../../models/get_card_list_model.dart';
import '../../../res/constants/api_urls.dart';
import '../../../res/constants/app_constants.dart';
import '../../../utils/app_utils.dart';
import '../../../utils/custom_toast.dart';
import '../../../utils/translations/translation_keys.dart';

class PaymentDetailController extends GetxController {
  final ApiHelper _apiHelper = ApiHelper.to;

  WebViewController webViewController = WebViewController();
  bool isLoading = true;

  Future<void> initPaymentView({required String url}) async {
    webViewController = WebViewController();
    webViewController.setBackgroundColor(Colors.white);
    webViewController.setJavaScriptMode(JavaScriptMode.unrestricted);
    webViewController.setNavigationDelegate(
      NavigationDelegate(
        onPageStarted: (String url) {
          log("on page started called ");
        },
        onProgress: (int progress) {
          log("progress is:-->> $progress");
          if (progress == 100) {
            isLoading = false;
            update();
          }
        },
        onPageFinished: (String url) {},
        onUrlChange: (change) async {
          debugPrint('Url change: ${change.url}');
          if (change.url?.contains(
                  'https://api.northshore.harishparas.com/paymentMethod/success') ==
              true) {
            var value = Uri.parse(change.url.toString());
            var sessionId = value.queryParameters['session_id'];
            debugPrint('session Id:$sessionId');
            Get.back<String>(result: sessionId.toString());
          }
        },
        onNavigationRequest: (NavigationRequest request) =>
            NavigationDecision.navigate,
      ),
    );
    webViewController.loadRequest(Uri.parse(url));
  }

  /// used to  add card  api for customer side .
  Future<void> postAddCard({required bool isComeFromBooking}) async {
    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }

      _apiHelper.postApi(ApiUrls.addCard, null).futureValue((value) async {
        printInfo(info: " Add card api  $value");
        var response = AddPaymentMethodModel.fromJson(value);
        if (response.response == AppConstants.apiResponseSuccess) {
          var sessionId = await Get.to(
            () => StripWebView(
                appBarTitle: TranslationKeys.addPaymentMethod.tr,
                url: response.data),
          );
          debugPrint('session Id from page  :$sessionId');
          if (sessionId != null) {
            postSaveCard(
                sessionId: sessionId, isComeFromBooking: isComeFromBooking);
          }
        } else {
          toast(msg: response.message.toString(), isError: true);
        }
      }, retryFunction: () {});
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      printError(info: "Add card  post API ISSUE $s");
    }
  }

  /// post api used to post the session api .
  Future<void> postSaveCard(
      {required String sessionId, required bool isComeFromBooking}) async {
    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }
      var body = {"stripeSessionId": sessionId};
      debugPrint('save card api Body :$body');

      _apiHelper.postApi(ApiUrls.saveCard, jsonEncode(body)).futureValue(
          (value) {
        printInfo(info: " Save card api  $value");
        var response = AddPaymentMethodModel.fromJson(value);
        if (response.response == AppConstants.apiResponseSuccess) {
          getCardList();
          toast(msg: response.message.toString(), isError: false);
          if (isComeFromBooking) {
            debugPrint('come from booking ');
            Get.back(result: true);
          }
        } else {
          toast(msg: response.message.toString(), isError: true);
        }
      }, retryFunction: () {});
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      printError(info: "Save card   post API ISSUE $s");
    }
  }

  /// used to store card data
  List<CardData>? cardList;

  /// used to get payment methods api .
  Future<void> getCardList() async {
    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }

      _apiHelper.postApi(ApiUrls.getCardList, null).futureValue((value) {
        printInfo(info: " get card list api  $value");
        var response = GetCardListModel.fromJson(value);
        if (response.response == AppConstants.apiResponseSuccess) {
          cardList = response.data;
          update(['card-list-view']);
        } else {
          toast(msg: response.message.toString(), isError: true);
        }
      }, retryFunction: () {});
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      printError(info: "Get card  List  API ISSUE $s");
    }
  }

  /// delete card api
  Future<void> deleteCard({required String cardId}) async {
    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }
      var body = {"cardId": cardId};
      _apiHelper.postApi(ApiUrls.deleteCard, jsonEncode(body)).futureValue(
          (value) {
        printInfo(info: "Delete card  $value");
        var response = GetCardListModel.fromJson(value);
        if (response.response == AppConstants.apiResponseSuccess) {
          getCardList();
        } else {
          toast(msg: response.message.toString(), isError: true);
        }
      }, retryFunction: () {});
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      printError(info: "Delete card   post API ISSUE $s");
    }
  }
}
