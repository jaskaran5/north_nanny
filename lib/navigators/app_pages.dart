import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/auth/choose_baby_sitter/choose_baby_sitter_binding.dart';
import 'package:northshore_nanny_flutter/app/modules/auth/choose_baby_sitter/choose_baby_sitter_view.dart';
import 'package:northshore_nanny_flutter/app/modules/auth/nanny/logIn/log_in_binding.dart';
import 'package:northshore_nanny_flutter/app/modules/common/booking_details/booking_detail_binding.dart';
import 'package:northshore_nanny_flutter/app/modules/common/booking_details/booking_detail_controller.dart';
import 'package:northshore_nanny_flutter/app/modules/common/booking_details/booking_detail_view.dart';
import 'package:northshore_nanny_flutter/app/modules/common/chatting/chat/chat_binding.dart';
import 'package:northshore_nanny_flutter/app/modules/common/chatting/chat/chat_view.dart';
import 'package:northshore_nanny_flutter/app/modules/common/chatting/recent_chat/recent_chat_binding.dart';
import 'package:northshore_nanny_flutter/app/modules/common/chatting/recent_chat/recent_chat_view.dart';
import 'package:northshore_nanny_flutter/app/modules/common/dashboard_bottom/dashboard_bottom_binding.dart';
import 'package:northshore_nanny_flutter/app/modules/common/dashboard_bottom/dashboard_bottom_view.dart';
import 'package:northshore_nanny_flutter/app/modules/common/favorite_view/favorite_binding.dart';
import 'package:northshore_nanny_flutter/app/modules/common/favorite_view/favorite_view.dart';
import 'package:northshore_nanny_flutter/app/modules/common/rating_review/rating_review_binding.dart';
import 'package:northshore_nanny_flutter/app/modules/common/rating_review/rating_review_view.dart';
import 'package:northshore_nanny_flutter/app/modules/common/settings/components/change_password_view.dart/change_password.dart';
import 'package:northshore_nanny_flutter/app/modules/common/settings/components/change_password_view.dart/password_changed.dart';
import 'package:northshore_nanny_flutter/app/modules/common/settings/components/contact_us.dart';
import 'package:northshore_nanny_flutter/app/modules/common/settings/components/faq.dart';
import 'package:northshore_nanny_flutter/app/modules/common/settings/components/invite_a_friend.dart';
import 'package:northshore_nanny_flutter/app/modules/common/settings/components/manage_child_profile/components/add_child_profile_view.dart';
import 'package:northshore_nanny_flutter/app/modules/common/settings/components/manage_child_profile/components/edit_child_profile_view.dart';
import 'package:northshore_nanny_flutter/app/modules/common/settings/components/manage_child_profile/manage_child_profile_binding.dart';
import 'package:northshore_nanny_flutter/app/modules/common/settings/components/manage_child_profile/manage_child_profile_view.dart';
import 'package:northshore_nanny_flutter/app/modules/common/settings/setting_binding.dart';
import 'package:northshore_nanny_flutter/app/modules/common/settings/setting_view.dart';
import 'package:northshore_nanny_flutter/app/modules/customer/my_profile/my_profile_binding.dart';

import 'package:northshore_nanny_flutter/app/modules/filter_view/filter_binding.dart';
import 'package:northshore_nanny_flutter/app/modules/filter_view/filter_view.dart';

import 'package:northshore_nanny_flutter/app/modules/auth/nanny/logIn/log_in_view.dart';
import 'package:northshore_nanny_flutter/app/modules/auth/nanny/signUp/signup_view.dart';
import 'package:northshore_nanny_flutter/app/modules/nanny/nanny_views/create_profile/create_sitter_profile_binding.dart';
import 'package:northshore_nanny_flutter/app/modules/splash/splash_view.dart';
import 'package:northshore_nanny_flutter/app/modules/splash/splash_view_binding.dart';

import '../app/modules/auth/customer/customer_views/create_profile/create_customer_profile_view.dart';
import '../app/modules/auth/nanny/signUp/sign_up_binding.dart';
import '../app/modules/customer/my_profile/my_profile.dart';
import '../app/modules/customer/my_profile/widgets/edit_profile.dart';
import '../app/modules/forgot_password/email_verification_view.dart';
import '../app/modules/forgot_password/forgot_password_binding.dart';
import '../app/modules/forgot_password/forgot_password_view.dart';
import '../app/modules/forgot_password/new_password_view.dart';
import '../app/modules/nanny/nanny_views/create_profile/create_sitter_profile_view.dart';
import 'app_routes.dart';

class AppPages {
  static var transitionDuration = const Duration(
    milliseconds: 350,
  );

  static const initial = Routes.splash;

  static final pages = [
    /** SPLASH VIEW */
    GetPage<SplashView>(
      name: Routes.splash,
      transitionDuration: transitionDuration,
      page: SplashView.new,
      binding: SplashBinding(),
      transition: Transition.rightToLeft,
    ),

    /** CHOOSE BABY SITTER VIEW */

    GetPage<ChooseBabySitterView>(
      name: Routes.chooseBabySitter,
      transitionDuration: transitionDuration,
      page: ChooseBabySitterView.new,
      binding: ChooseBabySitterBinding(),
      transition: Transition.leftToRight,
    ),

    /** SIGN UP VIEW */

    GetPage<SignUpView>(
      name: Routes.signUp,
      transitionDuration: transitionDuration,
      page: SignUpView.new,
      binding: SignUpBinding(),
      transition: Transition.rightToLeft,
    ),

    /** LOGIN VIEW */

    GetPage<LogInView>(
      name: Routes.logIn,
      transitionDuration: transitionDuration,
      page: LogInView.new,
      binding: LoginBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<ForgotPasswordView>(
      name: Routes.forgotPassword,
      transitionDuration: transitionDuration,
      page: ForgotPasswordView.new,
      binding: ForgotPasswordBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<EmailVerificationView>(
      name: Routes.emailVerification,
      transitionDuration: transitionDuration,
      page: EmailVerificationView.new,
      binding: ForgotPasswordBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<NewPasswordView>(
      name: Routes.newPasswordView,
      transitionDuration: transitionDuration,
      page: NewPasswordView.new,
      binding: ForgotPasswordBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<ChnagePasswordView>(
      name: Routes.changePasswordView,
      transitionDuration: transitionDuration,
      page: ChnagePasswordView.new,
      binding: ForgotPasswordBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<CreateNannyProfileView>(
      name: Routes.createNannyProfile,
      transitionDuration: transitionDuration,
      page: CreateNannyProfileView.new,
      binding: CreateNannyProfileBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<PasswordChangesView>(
      name: Routes.passwordChnagedView,
      transitionDuration: transitionDuration,
      page: PasswordChangesView.new,
      binding: SettingBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<SettingView>(
      name: Routes.settingView,
      transitionDuration: transitionDuration,
      page: SettingView.new,
      binding: SettingBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<FilterView>(
      name: Routes.filterView,
      transitionDuration: transitionDuration,
      page: FilterView.new,
      binding: FilterBinding(),
      transition: Transition.rightToLeft,
    ),
/// BOOKING DETAILS VIEW

    GetPage<BookingDetailView>(
      name: Routes.bookingDetailsView,
      transitionDuration: transitionDuration,
      page: BookingDetailView.new,
      binding: BookingDetailBinding(),
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

    /** CONTACT US */

    GetPage<ContactUsView>(
      name: Routes.contactUs,
      transitionDuration: transitionDuration,
      page: ContactUsView.new,
      binding: SettingBinding(),
      transition: Transition.leftToRight,
    ),

    /** FAQ */

    GetPage<FAQView>(
      name: Routes.faq,
      transitionDuration: transitionDuration,
      page: FAQView.new,
      binding: SettingBinding(),
      transition: Transition.leftToRight,
    ),

    /** RATING AND REVIEW */

    GetPage<RatingReviewView>(
      name: Routes.ratingReview,
      transitionDuration: transitionDuration,
      page: RatingReviewView.new,
      binding: RatingReviewBinding(),
      transition: Transition.rightToLeft,
    ),
    /** FavoriteView */

    GetPage<FavoriteView>(
      name: Routes.favoriteView,
      transitionDuration: transitionDuration,
      page: FavoriteView.new,
      binding: FavoriteBinding(),
      transition: Transition.rightToLeft,
    ),

    /** Manage Child Profile */

    GetPage<ManageChildProfileView>(
      name: Routes.manageChildProfile,
      transitionDuration: transitionDuration,
      page: ManageChildProfileView.new,
      binding: ManageChildProfileBinding(),
      transition: Transition.rightToLeft,
    ),

    /** add Child Profile */

    GetPage<AddChildProfileView>(
      name: Routes.addChildProfile,
      transitionDuration: transitionDuration,
      page: AddChildProfileView.new,
      binding: ManageChildProfileBinding(),
      transition: Transition.rightToLeft,
    ),

    /** edit Child Profile */

    GetPage<EditChildProfileView>(
      name: Routes.editChildProfile,
      transitionDuration: transitionDuration,
      page: EditChildProfileView.new,
      binding: ManageChildProfileBinding(),
    ),

    // /** CreateProfileView */
    // GetPage<CreateProfileView>(
    //   name: Routes.createProfileView,
    //   transitionDuration: transitionDuration,
    //   page: CreateProfileView.new,
    //   binding: SignUpBinding(),
    //   transition: Transition.rightToLeft,
    // ),
    /** My-Profile-View */
    GetPage<MyProfileView>(
      name: Routes.myProfileView,
      transitionDuration: transitionDuration,
      page: MyProfileView.new,
      binding: MyProfileBinding(),
      transition: Transition.rightToLeft,
    ),
    /** My-Profile-View */
    GetPage<EditProfileView>(
      name: Routes.ediProfileView,
      transitionDuration: transitionDuration,
      page: EditProfileView.new,
      binding: MyProfileBinding(),
      transition: Transition.rightToLeft,
    ),
    /** InviteAFriend-View */
    GetPage<InviteAFriendView>(
      name: Routes.inviteAFriendView,
      transitionDuration: transitionDuration,
      page: InviteAFriendView.new,
      binding: SettingBinding(),
      transition: Transition.rightToLeft,
    ),

    /** CRETAE CUSTOMER PROFILE-VIEW */
    GetPage<CreateCustomerProfileView>(
      name: Routes.createCustomerProfileView,
      transitionDuration: transitionDuration,
      page: CreateCustomerProfileView.new,
      binding: SettingBinding(),
      transition: Transition.leftToRight,
    ),
  ];
}
