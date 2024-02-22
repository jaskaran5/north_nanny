import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/common/rating_review/rating_review_controller.dart';

class RatingReviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RatingReviewController>(
      () => RatingReviewController(),
    );
  }
}
