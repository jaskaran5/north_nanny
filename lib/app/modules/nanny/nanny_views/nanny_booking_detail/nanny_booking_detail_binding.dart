import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/nanny/nanny_views/nanny_booking_detail/nanny_booking_detail_controller.dart';

class NannyBookingDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NannyBookingDetailController>(
      () => NannyBookingDetailController(),
    );
  }
}
