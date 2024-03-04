import 'dart:developer';

import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/utils/utility.dart';

class CreateCustomerProfileController extends GetxController {
  /// Show CAMERA and Gallery option
  onClickOnProfilePic() {
    Utility.showImagePicker(
      onGetImage: (image) {
        log("picker image is :-->> ${image.path}");
      },
    );
  }
}
