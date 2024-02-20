import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/common/chatting/recent_chat/recent_chat_view.dart';
import 'package:northshore_nanny_flutter/app/modules/common/settings/setting_view.dart';
import 'package:northshore_nanny_flutter/app/modules/parents/home/home_view.dart';
import 'package:northshore_nanny_flutter/app/res/constants/enums.dart';
import 'package:northshore_nanny_flutter/app/view_models/home_view_model.dart';

class DashboardBottomController extends GetxController {
  DashboardBottomController(this._viewModel);

  final HomeViewModel _viewModel;

  var bottomTabList = BottomTabs.values;

  String? selectedProfile = '';

  int selectedTabIndex = 0;

  set selectedBottomTab(int value) {
    selectedTabIndex = value;
    update();
  }

  set whichProfile(ChooseInterface value) {
    selectedProfile = value.name;
    update();
  }

  List bottomBarScreenList = [
    const HomeView(),
    const RecentChatView(),
    const HomeView(),
    const HomeView(),
    const SettingView(),
  ];
}
