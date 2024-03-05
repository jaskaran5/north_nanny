class ApiUrls {
  const ApiUrls._();

  static const String baseUrl = "https://api.northshore.harishparas.com/";
  static const String customerLogin = "api/User/LogIn";
  static const String customerSignup = "api/User/SignUp";
  static const String customerVerifyOtp = "api/User/VerifyOtp";
  static const String customerForgotPassword = "api/User/ForgotPassword";

  static const String customerResetPassword = "api/User/ResetPassword";

  static const String customerCreateProfile = "api/User/CreateProfile";

  static const String customerLogOut = "api/User/LogOut";

  /// ----------------------- Nanny Interface Apis Url----------------------------------//

  static const String addOrEditServices = 'api/NannyDashBoard/AddOrEditServices';
  static const String addOrEditBankDetails = 'api/NannyDashBoard/AddOrEditBankDetail';
}
