class ApiUrls {
  const ApiUrls._();

  static const String baseUrl = "http://api.northshore.harishparas.com/";
  static const String customerLogin = "${baseUrl}api/User/LogIn";
  static const String customerSignup = "${baseUrl}api/User/SignUp";
  static const String customerVerifyOtp = "${baseUrl}api/User/VerifyOtp";
  static const String customerForgotPassword =
      "${baseUrl}api/User/ForgotPassword";

  static const String customerResetPassword =
      "${baseUrl}api/User/ResetPassword";

  static const String customerCreateProfile =
      "${baseUrl}api/User/CreateProfile";

  static const String customerLogOut = "${baseUrl}api/User/LogOut";
}
