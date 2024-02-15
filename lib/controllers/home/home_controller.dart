import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/res/constants/constants.dart';

import '../../view_models/view_models.dart';

class HomeController extends GetxController {
  HomeController(this._viewModel);

  final HomeViewModel _viewModel;

  var bottomTabList = BottomTabs.values;

  String? selectedProfile = '';

  int selectedTabIndex = 0;

  bool showListView = false;

  set selectedBottomTab(int value) {
    selectedTabIndex = value;
    update();
  }

  set whichProfile(ChooseInterface value) {
    selectedProfile = value.name;
    update();
  }

  List<String> homeCustomList = [
    'Distance: 3 miles',
    'Age: 40',
    'Experience: 7+ yrs'
  ];
}
