import 'dart:developer';

import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/data/api/api_helper.dart';
import 'package:northshore_nanny_flutter/app/models/booking_data_by_date_response_model.dart';
import 'package:northshore_nanny_flutter/app/res/constants/api_urls.dart';
import 'package:northshore_nanny_flutter/app/res/constants/app_constants.dart';
import 'package:northshore_nanny_flutter/app/res/constants/extensions.dart';
import 'package:northshore_nanny_flutter/app/utils/app_utils.dart';
import 'package:northshore_nanny_flutter/app/utils/custom_toast.dart';

import '../../../res/constants/assets.dart';
import '../../../res/constants/enums.dart';

class BookingDetailController extends GetxController {
  bool isExpandChildren = false;
  final ApiHelper _apiHelper = ApiHelper.to;

  RxString bookingId = ''.obs;

  BookingDataById? bookingDataById;

  List<int> receiptPriceList = [
    10,
    10,
    23,
    92,
  ];
  int totalPrice = 0;
  getTotalPrice() {
    var totalSum = 0;
    for (var i in receiptPriceList) {
      totalSum = i + totalSum;
    }
    totalPrice = totalSum;
    update();
  }

  @override
  void onInit() {
    getTotalPrice();

    // log("get argumer : ${Get.arguments}");

    // bookingId.value = Get.arguments;
    // super.onInit();
  }

  updateId({id}) {
    bookingId.value = id;
    update();
  }

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

  /// check status
  late BookingDetailStatus bookingDetailStatus = BookingDetailStatus.present;

  getBookingDataById() async {
    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }
      var body = {
        "dateTime": bookingId.value,
      };
      _apiHelper.postApi(ApiUrls.bookingDetailsById, body).futureValue((value) {
        printInfo(info: "get  cUSTOMER booking single date   $value");
        var response = BookingDataByIdResponseModel.fromJson(value);
        if (response.response == AppConstants.apiResponseSuccess) {
          bookingDataById = response.data;
          update();
        } else {
          toast(msg: response.message.toString(), isError: true);
        }
      }, retryFunction: () {});
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      printError(info: "CUSTOMER booking detail single Get  API ISSUE $s");
    }
  }

  @override
  void onReady() {
    getBookingDataById();
    super.onReady();
  }
}
