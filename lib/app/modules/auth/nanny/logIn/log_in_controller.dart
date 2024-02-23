import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/data/storage/storage.dart';
import 'package:northshore_nanny_flutter/app/res/constants/string_contants.dart';

class LogInController extends GetxController {
  String loginType = '';
  @override
  void onInit() {
    checkLoginType();

    // checkIsNanny();
    super.onInit();
  }

  checkLoginType() {
    loginType = Storage.getValue(StringConstants.loginType);
    update();
  }

  /// check user Type.
  // checkIsNanny() async {
  //   isNannyView = Utility.isNannyInterFace();
  //   debugPrint('bool:$isNannyView ${  Utility.isNannyInterFace()}');
  //   update();
  // }

  // bool? isNannyView;
  final emailTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();
  final confirmPasswordTextEditingController = TextEditingController();

  /// to check remember me enable or disable.
  bool? isRememberMe = false;
}
