import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/controllers/choose_baby_sitter/choos_baby_sitter_controller.dart';

class ChooseBabySitterBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChooseBabySitterController>(() => ChooseBabySitterController());
  }
}
