import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/res/constants/enums.dart';
import 'package:northshore_nanny_flutter/app/view_models/home_view_model.dart';

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
  }

  List<String> homeCustomList = [
    'Distance: 3 miles',
    'Age: 40',
    'Experience: 7+ yrs'
  ];
}
