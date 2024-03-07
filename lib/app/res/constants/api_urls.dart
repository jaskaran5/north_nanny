class ApiUrls {
  const ApiUrls._();

  static const String baseUrl = "https://api.northshore.harishparas.com/";
  static const String customerLogin = "api/User/LogIn";
  static const String customerSignup = "api/User/SignUp";
  static const String addChild = "api/UserDashBoard/AddChild";

  static const String customerVerifyOtp = "api/User/VerifyOtp";
  static const String customerForgotPassword = "api/User/ForgotPassword";

  static const String customerResetPassword = "api/User/ResetPassword";

  static const String customerCreateProfile = "api/User/CreateProfile";
  static const String contactUs = "api/UserDashBoard/ContactUs";
  static const String verifyOtp = "api/User/VerifyOtp";
  static const String resetPassWord = "api/User/ResetPassword";
  static const String forgotPassword = "api/User/ForgotPassword";
  static const String customerLogOut = "api/User/LogOut";
  static const String customerGetProfile = "api/UserDashBoard/MyProfile";
  static const String childList = "api/UserDashBoard/ChildList";

  /// ----------------------- Nanny Interface Apis Url----------------------------------//

  static const String addOrEditServices =
      'api/NannyDashBoard/AddOrEditServices';
  static const String addOrEditBankDetails =
      'api/NannyDashBoard/AddOrEditBankDetail';
  static const String getNannyProfile = 'api/NannyDashBoard/MyProfile';
}
