import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/res/constants/enums.dart';
import 'package:northshore_nanny_flutter/app/res/constants/extensions.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';

import 'package:syncfusion_flutter_sliders/sliders.dart';

class FilterController extends GetxController {
  String? selectedGender = '';

  SfRangeValues distanceSliderValues = SfRangeValues(Dimens.zero, Dimens.ten);
  SfRangeValues ageSliderValues = SfRangeValues(
    Dimens.thirteen,
    Dimens.fifty,
  );

  List<String> genderList = GenderConstant.values
      .map((e) => e.genderName.capitalizeFirst.toString())
      .toList();
}
