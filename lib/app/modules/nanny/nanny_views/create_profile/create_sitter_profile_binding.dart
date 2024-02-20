import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/auth/choose_baby_sitter/choose_baby_sitter_controller.dart';
import 'package:northshore_nanny_flutter/app/modules/nanny/nanny_views/create_profile/create_sitter_profile_controller.dart';

class CreateSitterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateSitterProfileController>(
        () => CreateSitterProfileController());
  }
}
