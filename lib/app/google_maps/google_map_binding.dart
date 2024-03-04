import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/google_maps/google_map_controller.dart';

class GoogleMapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GoogleMapViewController>(
      () => GoogleMapViewController(),
    );
  }
}
