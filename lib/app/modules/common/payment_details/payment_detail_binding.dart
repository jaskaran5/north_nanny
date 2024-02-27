import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/common/payment_details/payment_detail_controller.dart';

class PaymentDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentDetailController>(
      () => PaymentDetailController(),
    );
  }
}
