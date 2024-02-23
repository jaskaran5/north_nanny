import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/data/api/api_helper.dart';
import 'package:northshore_nanny_flutter/app/data/api/api_helper_impl.dart';
import 'package:northshore_nanny_flutter/app/data/api/interface_controller/api_interface_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiHelper>(() => ApiHelperImpl(), fenix: true);

    Get.lazyPut<ApiInterfaceController>(() => ApiInterfaceController(),
        fenix: true);
  }}