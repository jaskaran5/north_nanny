import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/auth/choose_baby_sitter/choose_baby_sitter_controller.dart';

class ChooseBabySitterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChooseBabySitterController>(() => ChooseBabySitterController());
    //
  }
}
