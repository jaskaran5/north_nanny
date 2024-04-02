import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/nanny/nanny_views/bank_details/add_bank_detail_controller.dart';

class AddBankDetailBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddBankDetailController>(
      () => AddBankDetailController(),
    );
  }
}
