import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/data/local/db_wrapper.dart';
import 'package:northshore_nanny_flutter/app/res/constants/app_constants.dart';

class LogInController extends GetxController {
  @override
  void onInit() {
    checkIsNanny();
    super.onInit();
  }

  /// check user Type.
  checkIsNanny() async {
    var isNanny = await DBWrapper().getSecuredValue(AppConstants.isNanny);
    debugPrint('---nanny $isNanny');
    if (isNanny.isNotEmpty && isNanny == 'true') {
      isNannyView = true;
      debugPrint('---nanny Profile true');
    } else if (isNanny.isNotEmpty && isNanny == 'false') {
      isNannyView = false;
      debugPrint('---nanny Profile false');
    }
    update();
  }

  bool? isNannyView;
  final emailTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();
  final confirmPasswordTextEditingController = TextEditingController();

  /// to check remember me enable or disable.
  bool? isRememberMe = false;
}
