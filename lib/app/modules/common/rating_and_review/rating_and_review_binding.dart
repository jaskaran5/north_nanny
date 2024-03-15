import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/common/rating_and_review/rating_and_review_controller.dart';

class RatingAndReviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RatingAndReviewController>(
      () => RatingAndReviewController(),
    );
  }
}
