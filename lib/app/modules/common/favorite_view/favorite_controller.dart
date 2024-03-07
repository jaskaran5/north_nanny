import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/data/api/api_helper.dart';
import 'package:northshore_nanny_flutter/app/res/constants/api_urls.dart';
import 'package:northshore_nanny_flutter/app/utils/app_utils.dart';
import 'package:northshore_nanny_flutter/app/utils/custom_toast.dart';
import 'package:northshore_nanny_flutter/app/utils/extensions.dart';

class FavoriteController extends GetxController {
  final ApiHelper _apiHelper = ApiHelper.to;

  getFavouriteNannyListApi() async {
    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }

      _apiHelper
          .getPosts(
        ApiUrls.favouriteNannyList,
      )
          .futureValue((value) {
        printInfo(info: "log out value $value");
        // var response = RegisterModelResponseJson.fromJson(value);
        // if (response.response == AppConstants.apiResponseSuccess) {
        //   RouteManagement.goToOffAllLogIn();
        //   toast(msg: response.message.toString(), isError: false);
        // } else {
        //   toast(msg: response.message.toString(), isError: true);
        // }
      }, retryFunction: () {});
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      printError(info: "log out  post API ISSUE $s");
    }
  }

  @override
  void onInit() {
    getFavouriteNannyListApi();
    super.onInit();
  }
}
