import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/utils/utility.dart';

class LogInController extends GetxController {
  @override
  void onInit() {
    checkIsNanny();
    super.onInit();
  }

  /// check user Type.
  checkIsNanny() async {
    isNannyView = await Utility.isNannyInterFace();
    update();
  }

  bool? isNannyView;
  final emailTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();
  final confirmPasswordTextEditingController = TextEditingController();

  /// to check remember me enable or disable.
  bool? isRememberMe = false;
}
