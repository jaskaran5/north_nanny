import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/common/favorite_view/favorite_controller.dart';

class FavoriteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavoriteController>(
      () => FavoriteController(),
    );
  }
}
