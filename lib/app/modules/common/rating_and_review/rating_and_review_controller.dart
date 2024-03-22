import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/data/api/api_helper.dart';
import 'package:northshore_nanny_flutter/app/modules/common/booking_details/booking_detail_controller.dart';
import 'package:northshore_nanny_flutter/app/modules/nanny/nanny_views/nanny_booking_detail/nanny_booking_detail_binding.dart';
import 'package:northshore_nanny_flutter/app/modules/nanny/nanny_views/nanny_booking_detail/nanny_booking_detail_controller.dart';
import 'package:northshore_nanny_flutter/app/res/constants/extensions.dart';
import 'package:northshore_nanny_flutter/app/res/constants/string_contants.dart';
import 'package:northshore_nanny_flutter/app/utils/custom_toast.dart';
import 'package:northshore_nanny_flutter/app/utils/validators.dart';

import '../../../data/storage/storage.dart';
import '../../../models/rating_review_reponse_model.dart';
import '../../../res/constants/api_urls.dart';
import '../../../res/constants/app_constants.dart';
import '../../../utils/app_utils.dart';
import '../booking_details/booking_detail_binding.dart';

class RatingAndReviewController extends GetxController {
  final ApiHelper _apiHelper = ApiHelper.to;

  String? userName;
  String? userImage;
  double? totalRating;
  int? totalReview;
  int? userId;
  int? bookingId;

  /// used to store log in type.
  String? logInType;

  /// used to store the user type.
  Future<void> getLoginType() async {
    logInType = Storage.getValue(StringConstants.loginType);
    update();
  }

  /// used to store text .
  final TextEditingController writeAReviewController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getLoginType();
  }

  /// used to store the giving rating.
  double givingRating = 0.0;

  /// method used to store the rating to giveRatingVariable.
  onRatingUpdate(double rating) {
    givingRating = rating;
    update();
  }

  /// rating and review validator.
  ///
  ratingReviewValidator(
      {required double rating, required String message}) async {
    var valid = Validator.instance
        .ratingAndReviewValidator(rating: rating, message: message);
    if (valid) {
      postRatingAndReviewApi();
    } else {
      toast(msg: Validator.instance.error, isError: true);
    }
  }

  /// method used to store the user type and user data
  storeUserData({
    required String name,
    required String image,
    required int userReviews,
    required int toUserId,
    required int bookedId,
    required double userRating,
  }) {
    userName = name;
    userImage = image;
    totalRating = userRating;
    totalReview = userReviews;
    userId = toUserId;
    bookingId = bookingId;
    update();
  }

  /// used to post the rating and reviews.
  postRatingAndReviewApi() async {
    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }
      var body = {
        "reviewTo": userId,
        "rating": givingRating,
        "review1": writeAReviewController.text.trim(),
      };
      log('post rating body ->>>>>>>>>>>> $body');

      _apiHelper
          .postApi(
        ApiUrls.postRatingAndReview,
        jsonEncode(body),
      )
          .futureValue((value) {
        var response = RatingReviewResponseModel.fromJson(value);
        if (response.response == AppConstants.apiResponseSuccess) {
          if (logInType == StringConstants.customer) {
            if (!Get.isRegistered<BookingDetailController>()) {
              BookingDetailBinding().dependencies();
            }
            Get.find<BookingDetailController>()
                .getBookingDataById(bookingId: bookingId ?? 0);
          } else {
            if (!Get.isRegistered<NannyBookingDetailController>()) {
              NannyBookingDetailBinding().dependencies();
            }
            Get.find<NannyBookingDetailController>()
                .getBookingDetailOfCustomer(bookingId: bookingId ?? 0);
          }
          Get.back();
        } else {
          toast(msg: response.message.toString(), isError: true);
        }
      }, retryFunction: () {});
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      printError(info: "post review rating   post API ISSUE $s");
    }
  }
}
