import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/controllers/sitter_controllers/create_profile/create_sitter_profile.dart';

class CreateSitterProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateSitterProfileController>(
      () => CreateSitterProfileController(),
    );
  }
}
