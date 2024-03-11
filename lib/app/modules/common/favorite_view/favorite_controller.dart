import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/data/api/api_helper.dart';
import 'package:northshore_nanny_flutter/app/models/favourite_nanny_list_reponse_model.dart';
import 'package:northshore_nanny_flutter/app/res/constants/api_urls.dart';
import 'package:northshore_nanny_flutter/app/res/constants/app_constants.dart';
import 'package:northshore_nanny_flutter/app/utils/app_utils.dart';
import 'package:northshore_nanny_flutter/app/utils/custom_toast.dart';
import 'package:northshore_nanny_flutter/app/utils/extensions.dart';

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
          toast(msg: response.message.toString(), isError: false);
        } else {
          toast(msg: response.message.toString(), isError: true);
        }
      }, retryFunction: () {});
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      printError(info: "Favourite list  post API ISSUE $s");
    }
  }

  @override
  void onInit() {
    getFavouriteNannyListApi();
    super.onInit();
  }
}
