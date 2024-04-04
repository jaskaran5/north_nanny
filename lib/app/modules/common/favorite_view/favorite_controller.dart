import 'dart:developer';

import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/data/api/api_helper.dart';
import 'package:northshore_nanny_flutter/app/models/favourite_nanny_list_reponse_model.dart';
import 'package:northshore_nanny_flutter/app/models/nanny_favourite_response_model.dart';
import 'package:northshore_nanny_flutter/app/res/constants/api_urls.dart';
import 'package:northshore_nanny_flutter/app/res/constants/app_constants.dart';
import 'package:northshore_nanny_flutter/app/res/constants/extensions.dart';
import 'package:northshore_nanny_flutter/app/utils/custom_toast.dart';

class FavoriteController extends GetxController {
  final ApiHelper _apiHelper = ApiHelper.to;

  RxList<FavouriteNanny> favouriteListNanny = <FavouriteNanny>[].obs;

  getFavouriteNannyListApi() async {
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
        var response = FavouriteListResponseModel.fromJson(value);
        if (response.response == AppConstants.apiResponseSuccess) {
          favouriteListNanny.value = response.data ?? [];
          // toast(msg: response.message.toString(), isError: false);
        } else {
          toast(msg: response.message.toString(), isError: true);
        }
        update();
      }, retryFunction: () {});
    } catch (e, s) {
      // toast(msg: e.toString(), isError: true);
      printError(info: "Favourite list  post API ISSUE $s");
    }
  }

  // @override
  // void onInit() {
  //   getFavouriteNannyListApi();
  //   super.onInit();
  // }

  @override
  void onReady() {
    getFavouriteNannyListApi();

    super.onReady();
  }

  toggleFavouriteAndUnFavouriteApi(
      {required int userId, required bool isFavourite}) {
    try {
      var body = {
        "toUserId": userId,
        "isFavorite": isFavourite,
      };

      _apiHelper.postApi(ApiUrls.addOrRemoveFavoriteNanny, body).futureValue(
          (value) {
        var res = NannyFavouriteResponseModel.fromJson(value);

        if (res.response.toString() ==
            AppConstants.apiResponseSuccess.toString()) {
          log("response success");

          getFavouriteNannyListApi();

          update();
        }
      }, retryFunction: () {});
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      printError(info: "Get dashboard data post  API ISSUE $s");
    }
  }
}
