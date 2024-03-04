import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/nanny/nanny_views/create_profile/create_nanny_profile_controller.dart';

class CreateNannyProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateSitterProfileController>(
        () => CreateSitterProfileController());
  }
}
