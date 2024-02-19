import 'dart:core';

import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/res/res.dart';

class FilterController extends GetxController {
  String? selectedGender = '';
  //===============//

  double distanceLowerValue = Dimens.zero;
  double distanceHigherValue = Dimens.ten;
  double ageLowerValue = Dimens.thirteen;
  double ageHigherValue = Dimens.fifty;

  /// use to select Date
  DateTime selectedDate = DateTime.now();

  /// use to select Time
  DateTime selectedTime = DateTime.now();

  List<String> genderList = GenderConstant.values
      .map((e) => e.genderName.capitalizeFirst.toString())
      .toList();
}
