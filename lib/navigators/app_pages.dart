import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/auth/choose_baby_sitter/choose_baby_sitter_view.dart';
import 'package:northshore_nanny_flutter/app/modules/chat/chat_view.dart';
import 'package:northshore_nanny_flutter/app/modules/chat/recent_chat_view.dart';
import 'package:northshore_nanny_flutter/app/modules/filter_view/filter_view.dart';
import 'package:northshore_nanny_flutter/app/modules/common/forgot_password/forgot_password_view.dart';
import 'package:northshore_nanny_flutter/app/modules/common/forgot_password/widgets/email_verification_view.dart';
import 'package:northshore_nanny_flutter/app/modules/common/forgot_password/widgets/new_password_view.dart';
import 'package:northshore_nanny_flutter/app/modules/home/nanny/home_view.dart';
import 'package:northshore_nanny_flutter/app/modules/auth/nanny/logIn/log_in_view.dart';
import 'package:northshore_nanny_flutter/app/modules/nanny_profile/nanny_profile_view.dart';
import 'package:northshore_nanny_flutter/app/modules/nanny_views/create_profile/create_sitter_profile_view.dart';
import 'package:northshore_nanny_flutter/app/modules/auth/nanny/signUp/signup_view.dart';
import 'package:northshore_nanny_flutter/app/modules/splash/splash_view.dart';

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
      // binding: SplashBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<ChooseBabySitterView>(
      name: Routes.chooseBabySitter,
      transitionDuration: transitionDuration,
      page: ChooseBabySitterView.new,
      // binding: ChooseBabySitterBindings(),
      transition: Transition.leftToRight,
    ),
    GetPage<SignUpView>(
      name: Routes.signUp,
      transitionDuration: transitionDuration,
      page: SignUpView.new,
      // binding: SignUpViewBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<LogInView>(
      name: Routes.logIn,
      transitionDuration: transitionDuration,
      page: LogInView.new,
      // binding: LogInViewBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<ForgotPasswordView>(
      name: Routes.forgotPassword,
      transitionDuration: transitionDuration,
      page: ForgotPasswordView.new,
      // binding: ForgotPasswordBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<EmailVerificationView>(
      name: Routes.emailVerification,
      transitionDuration: transitionDuration,
      page: EmailVerificationView.new,
      // binding: ForgotPasswordBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<NewPasswordView>(
      name: Routes.newPasswordView,
      transitionDuration: transitionDuration,
      page: NewPasswordView.new,
      // binding: ForgotPasswordBinding(),
      transition: Transition.rightToLeft,
    ),

    GetPage<CreateSitterProfileView>(
      name: Routes.createSitterProfileView,
      transitionDuration: transitionDuration,
      page: CreateSitterProfileView.new,
      // binding: CreateSitterProfileBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<HomeView>(
      name: Routes.home,
      transitionDuration: transitionDuration,
      page: HomeView.new,
      // binding: HomeBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<FilterView>(
      name: Routes.filterView,
      transitionDuration: transitionDuration,
      page: FilterView.new,
      // binding: FilterBinding(),
      transition: Transition.rightToLeft,
    ),

    /**RECENT CHAT */
    GetPage<RecentChatView>(
      name: Routes.recentChat,
      transitionDuration: transitionDuration,
      page: RecentChatView.new,
      transition: Transition.rightToLeft,
    ),

    /** CHAT */
    GetPage<ChatView>(
      name: Routes.recentChat,
      transitionDuration: transitionDuration,
      page: ChatView.new,
      transition: Transition.rightToLeft,
    ),
    /** Nanny Profile view */
    GetPage<NannyProfileView>(
      name: Routes.nannyProfileView,
      transitionDuration: transitionDuration,
      page: NannyProfileView.new,
      transition: Transition.rightToLeft,
    ),
  ];
}
