class ApiUrls {
  const ApiUrls._();

  ///-------------- *******  COMMON API ----------------------------------------------------------------
  ///
  ///
  ///
  static const String baseUrl = "https://api.northshore.harishparas.com/";
  static const String customerLogin = "api/User/LogIn";
  static const String customerSignup = "api/User/SignUp";
  static const String customerVerifyOtp = "api/User/VerifyOtp";
  static const String customerForgotPassword = "api/User/ForgotPassword";
  static const String customerResetPassword = "api/User/ResetPassword";
  static const String customerCreateProfile = "api/User/CreateProfile";
  static const String verifyOtp = "api/User/VerifyOtp";
  static const String resetPassWord = "api/User/ResetPassword";
  static const String forgotPassword = "api/User/ForgotPassword";
  static const String customerLogOut = "api/User/LogOut";

  ///
  ///
  /// ----------------------- ****** CUSTOMER  ******* Interface Apis Url----------------------------------//
  ///
  ///
  static const String addChild = "api/UserDashBoard/AddChild";
  static const String contactUs = "api/UserDashBoard/ContactUs";
  static const String customerGetProfile = "api/UserDashBoard/MyProfile";
  static const String childList = "api/UserDashBoard/ChildList";
  static const String deleteChild = "api/UserDashBoard/DeleteChild";
  static const String editChild = "api/UserDashBoard/EditChild";
  static const String userDashBoard = "api/UserDashBoard/UserDashBoard";
  static const String favouriteNannyList =
      "api/UserDashBoard/MyFavoriteNannyList";
  static const String ratingAndReview = "api/UserDashBoard/RatingAndReview";
  static const String addOrRemoveFavoriteNanny =
      "api/UserDashBoard/AddOrRemoveFavoriteNanny";
  static const String nannyDetails = "api/UserDashBoard/NannyDetail";
  static const String bookingDetails = "api/UserDashBoard/BookingDetail";
  static const String myFavoriteNannyList =
      "api/UserDashBoard/MyFavoriteNannyList";
  static const String getAllNannyBookingDates =
      "api/UserDashBoard/GetAllNannyBookingDates";

  static const String userBookingDeatil = "api/UserDashBoard/UserBookingDeatil";
  static const String bookAppointment = "api/UserDashBoard/BookAppointment";
  static const String addCard = "api/UserDashBoard/AddCard";

  static const String saveCard = "api/UserDashBoard/SaveCard";

  /// ----------------------- Nanny Interface Apis Url----------------------------------//
  ///
  ///

  static const String addOrEditServices =
      'api/NannyDashBoard/AddOrEditServices';
  static const String addOrEditBankDetails =
      'api/NannyDashBoard/AddOrEditBankDetail';
  static const String getNannyProfile = 'api/NannyDashBoard/MyProfile';
}
