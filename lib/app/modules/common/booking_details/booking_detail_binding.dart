import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/common/booking_details/booking_detail_controller.dart';

class BookingDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookingDetailController>(() => BookingDetailController());
  }
}
