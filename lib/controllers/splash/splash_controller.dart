import 'package:get/get.dart';
import '../../utils/navigators/routes_management.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    startOnInit();
  }

  // var isLoggedIn = false;

  void startOnInit() async {
    await Future.delayed(
      const Duration(seconds: 3),
    );
    RouteManagement.goChooseBabySitter();
    // RouteManagement.goToOffAllHome(ChooseInterface.customer);
    // if (isLoggedIn) {

    // } else {
    //   RouteManagement.goToSignIn();
    // }
  }
}
