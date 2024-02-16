import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/res/constants/constants.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class FilterController extends GetxController {
  String? selectedGender = '';

  SfRangeValues distanceSliderValues = const SfRangeValues(0.0, 20.0);

  List<String> genderList = GenderConstant.values
      .map((e) => e.genderName.capitalizeFirst.toString())
      .toList();
}
