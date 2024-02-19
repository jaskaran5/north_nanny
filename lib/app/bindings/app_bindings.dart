import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/controllers/chat/chat_controller.dart';
import 'package:northshore_nanny_flutter/app/controllers/chat/recent_chat_controller.dart';
import 'package:northshore_nanny_flutter/app/controllers/choose_baby_sitter/choos_baby_sitter_controller.dart';
import 'package:northshore_nanny_flutter/app/controllers/filter/filter_controller.dart';
import 'package:northshore_nanny_flutter/app/controllers/forgot_password/forgot_password_controller.dart';
import 'package:northshore_nanny_flutter/app/controllers/home/home_controller.dart';
import 'package:northshore_nanny_flutter/app/controllers/logIn/log_in_controller.dart';
import 'package:northshore_nanny_flutter/app/controllers/signUp/signup_controller.dart';
import 'package:northshore_nanny_flutter/app/controllers/sitter_controllers/create_profile/create_sitter_profile_controller.dart';
import 'package:northshore_nanny_flutter/app/controllers/splash/splash_controller.dart';
import 'package:northshore_nanny_flutter/app/repositories/forgot_password_repository.dart';
import 'package:northshore_nanny_flutter/app/repositories/home_repository.dart';
import 'package:northshore_nanny_flutter/app/repositories/log_in_repository.dart';
import 'package:northshore_nanny_flutter/app/repositories/sign_up_repository.dart';
import 'package:northshore_nanny_flutter/app/view_models/forgot_password_view_model.dart';
import 'package:northshore_nanny_flutter/app/view_models/home_view_model.dart';
import 'package:northshore_nanny_flutter/app/view_models/log_in_view_model.dart';
import 'package:northshore_nanny_flutter/app/view_models/sign_up_view_model.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    /** CREATE SITTER PROFILE CONTROLLER */

    Get.lazyPut<CreateSitterProfileController>(
      () => CreateSitterProfileController(),
    );

    /** FILTER CONTROLLER */

    Get.lazyPut<FilterController>(() => FilterController());

    /** HOME CONTROLLER */

    Get.lazyPut<HomeController>(
      () => HomeController(
        HomeViewModel(
          HomeRepository(),
        ),
      ),
    );

    /** CHOOSE BABY SITTER CONTROLLER */

    Get.lazyPut<ChooseBabySitterController>(() => ChooseBabySitterController());

    /** FORGOT PASSWORD CONTROLLER */
    Get.lazyPut<ForgotPasswordController>(
      () => ForgotPasswordController(
        ForgotPasswordViewModel(
          ForgotPasswordRepository(),
        ),
      ),
    );

    /** SIGN UP CONTROLLER */
    Get.lazyPut<SignupViewController>(
      () => SignupViewController(
        SignUpViewModel(
          SignUpRepository(),
        ),
      ),
    );

    /** SPLASH CONTROLLER */
    Get.lazyPut<SplashController>(SplashController.new);

    /** LOGIN CONTROLLER */

    Get.lazyPut<LogInController>(
      () => LogInController(
        LogInViewModel(
          LogInRepository(),
        ),
      ),
    );

    /** RECENT CHAT CONTROLLER */

    Get.lazyPut<RecentChatController>(
      () => RecentChatController(),
    );

    /**  CHAT CONTROLLER */

    Get.lazyPut<ChatController>(
      () => ChatController(),
    );
  }
}
