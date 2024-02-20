import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/common/dashboard_bottom/dashboard_bottom_controller.dart';
import 'package:northshore_nanny_flutter/app/repositories/home_repository.dart';
import 'package:northshore_nanny_flutter/app/view_models/home_view_model.dart';

class DashboardBottomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardBottomController>(
      () => DashboardBottomController(
        HomeViewModel(
          HomeRepository(),
        ),
      ),
    );
  }
}
