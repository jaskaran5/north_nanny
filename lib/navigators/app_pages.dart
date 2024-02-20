import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/auth/choose_baby_sitter/choose_baby_sitter_binding.dart';
import 'package:northshore_nanny_flutter/app/modules/auth/choose_baby_sitter/choose_baby_sitter_view.dart';
import 'package:northshore_nanny_flutter/app/modules/auth/nanny/logIn/log_in_binding.dart';
import 'package:northshore_nanny_flutter/app/modules/auth/nanny/signUp/signUp_binding.dart';
import 'package:northshore_nanny_flutter/app/modules/common/chatting/chat/chat_binding.dart';
import 'package:northshore_nanny_flutter/app/modules/common/chatting/chat/chat_view.dart';
import 'package:northshore_nanny_flutter/app/modules/common/chatting/recent_chat/recent_chat_binding.dart';
import 'package:northshore_nanny_flutter/app/modules/common/chatting/recent_chat/recent_chat_view.dart';
import 'package:northshore_nanny_flutter/app/modules/common/dashboard_bottom/dashboard_bottom_binding.dart';
import 'package:northshore_nanny_flutter/app/modules/common/dashboard_bottom/dashboard_bottom_view.dart';

import 'package:northshore_nanny_flutter/app/modules/filter_view/filter_binding.dart';
import 'package:northshore_nanny_flutter/app/modules/filter_view/filter_view.dart';

import 'package:northshore_nanny_flutter/app/modules/auth/nanny/logIn/log_in_view.dart';
import 'package:northshore_nanny_flutter/app/modules/auth/nanny/signUp/signup_view.dart';
import 'package:northshore_nanny_flutter/app/modules/splash/splash_view.dart';
import 'package:northshore_nanny_flutter/app/modules/splash/splash_view_binding.dart';

import 'app_routes.dart';

class AppPages {
  static var transitionDuration = const Duration(
    milliseconds: 350,
  );

  static const initial = Routes.nannyProfileView;

  static final pages = [
    GetPage<SplashView>(
      name: Routes.splash,
      transitionDuration: transitionDuration,
      page: SplashView.new,
      binding: SplashBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<ChooseBabySitterView>(
      name: Routes.chooseBabySitter,
      transitionDuration: transitionDuration,
      page: ChooseBabySitterView.new,
      binding: ChooseBabySitterBinding(),
      transition: Transition.leftToRight,
    ),
    GetPage<SignUpView>(
      name: Routes.signUp,
      transitionDuration: transitionDuration,
      page: SignUpView.new,
      binding: SignupBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<LogInView>(
      name: Routes.logIn,
      transitionDuration: transitionDuration,
      page: LogInView.new,
      binding: LoginBinding(),
      transition: Transition.rightToLeft,
    ),
    // GetPage<ForgotPasswordView>(
    //   name: Routes.forgotPassword,
    //   transitionDuration: transitionDuration,
    //   page: ForgotPasswordView.new,
    //   binding: ForgotPasswordBinding(),
    //   transition: Transition.rightToLeft,
    // ),
    // GetPage<EmailVerificationView>(
    //   name: Routes.emailVerification,
    //   transitionDuration: transitionDuration,
    //   page: EmailVerificationView.new,
    //   binding: ForgotPasswordBinding(),
    //   transition: Transition.rightToLeft,
    // ),
    // GetPage<NewPasswordView>(
    //   name: Routes.newPasswordView,
    //   transitionDuration: transitionDuration,
    //   page: NewPasswordView.new,
    //   binding: ForgotPasswordBinding(),
    //   transition: Transition.rightToLeft,
    // ),
    // GetPage<PasswordSuccessView>(
    //   name: Routes.passwordSuccessView,
    //   transitionDuration: transitionDuration,
    //   page: PasswordSuccessView.new,
    //   // binding: ForgotPasswordBinding(),
    //   transition: Transition.rightToLeft,
    // ),
    // GetPage<CreateSitterProfileView>(
    //   name: Routes.createSitterProfileView,
    //   transitionDuration: transitionDuration,
    //   page: CreateSitterProfileView.new,
    //   binding: CreateSitterBinding(),
    //   transition: Transition.rightToLeft,
    // ),
    // GetPage<HomeView>(
    //   name: Routes.home,
    //   transitionDuration: transitionDuration,
    //   page: HomeView.new,
    //   binding: HomeBinding(),
    //   transition: Transition.rightToLeft,
    // ),
    GetPage<FilterView>(
      name: Routes.filterView,
      transitionDuration: transitionDuration,
      page: FilterView.new,
      binding: FilterBinding(),
      transition: Transition.rightToLeft,
    ),

    /**RECENT CHAT */
    GetPage<RecentChatView>(
      name: Routes.recentChat,
      transitionDuration: transitionDuration,
      page: RecentChatView.new,
      binding: RecentChatBinding(),
      transition: Transition.rightToLeft,
    ),

    /** CHAT */
    GetPage<ChatView>(
      name: Routes.recentChat,
      transitionDuration: transitionDuration,
      page: ChatView.new,
      binding: ChatBinding(),
      transition: Transition.rightToLeft,
    ),

    /** DASHBOARD */

    GetPage<DashboardBottomView>(
      name: Routes.dashboard,
      transitionDuration: transitionDuration,
      page: DashboardBottomView.new,
      binding: DashboardBottomBinding(),
      transition: Transition.rightToLeft,
    ),
  ];
}
