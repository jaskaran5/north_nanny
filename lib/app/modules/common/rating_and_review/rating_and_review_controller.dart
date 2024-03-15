import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/data/api/api_helper.dart';
import 'package:northshore_nanny_flutter/app/models/rating_review_reponse_model.dart';
import 'package:northshore_nanny_flutter/app/res/constants/api_urls.dart';
import 'package:northshore_nanny_flutter/app/res/constants/app_constants.dart';
import 'package:northshore_nanny_flutter/app/res/constants/extensions.dart';
import 'package:northshore_nanny_flutter/app/utils/custom_toast.dart';

class RatingAndReviewController extends GetxController {
  final ApiHelper _apiHelper = ApiHelper.to;

  RxString totalReviews = "0".obs;
  RxList reviewList = [].obs;
  RxDouble totalReviewsRating = 0.0.obs;

  RxInt userId = 0.obs;

  getRatingAndReviewApi() async {
    try {
      //   if (!(await Utils.hasNetwork())) {
      //     return;
      //   }

      _apiHelper
          .getPosts(
        ApiUrls.myFavoriteNannyList,
      )
          .futureValue((value) {
        printInfo(info: "log out value $value");
        var response = RatingReviewResponseModel.fromJson(value);
        if (response.response == AppConstants.apiResponseSuccess) {
          reviewList.value = response.data?.ratingList ?? [];
        } else {
          // toast(msg: response.message.toString(), isError: true);
        }
      }, retryFunction: () {});
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      printError(info: "Favourite list  post API ISSUE $s");
    }
  }

  @override
  void onInit() {
    userId.value = Get.arguments;
    update();
    super.onInit();
  }
}
