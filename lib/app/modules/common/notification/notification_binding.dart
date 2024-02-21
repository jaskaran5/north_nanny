import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/common/notification/notification_controller.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationController>(
      () => NotificationController(),
    );
  }
}
