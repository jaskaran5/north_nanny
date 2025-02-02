class ApiUrls {
  const ApiUrls._();

  ///---------------------------------SOCKET URL
  ///
  static const String socketUrl = "https://api.northshore.harishparas.com/chat";

  ///-------------- *******  COMMON API ----------------------------------------------------------------
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
  static const String changePassword = "api/User/ChangePassword";
  static const String reviewList = "api/User/ReviewList";
  static const String postRatingAndReview = "api/UserDashBoard/RatingAndReview";
  static const String readNotification = "api/User/ReadNotification";
  static const String notificationList = "api/User/NotificationList";
  static const String faqList = "api/User/FaqList";
  static const String deleteAccount = "api/User/DeleteAccount";

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

  static const String addOrRemoveFavoriteNanny =
      "api/UserDashBoard/AddOrRemoveFavoriteNanny";
  static const String nannyDetails = "api/UserDashBoard/NannyDetail";
  static const String bookingDetailsById = "api/UserDashBoard/BookingDetail";
  static const String sendTip = "api/UserDashBoard/SendTip";
  static const String getNotificationCount = "api/User/NotificationCount";
  static const String socialLogIn = "api/User/SocialLogin";
  static const String myFavoriteNannyList =
      "api/UserDashBoard/MyFavoriteNannyList";
  static const String getAllNannyBookingDates =
      "api/UserDashBoard/GetAllNannyBookingDates";

  // static const String userBookingDeatil = "api/UserDashBoard/UserBookingDeatil";
  static const String bookAppointment = "api/UserDashBoard/BookAppointment";
  static const String addCard = "api/UserDashBoard/AddCard";

  static const String saveCard = "api/UserDashBoard/SaveCard";
  static const String getCardList = "api/UserDashBoard/StripeSavedCardList";
  static const String deleteCard = "api/UserDashBoard/StripeDeleteCard";
  static const String setDefaultCard = "api/UserDashBoard/SetDefaultCard";
  static const String nannyBookingDataByDate =
      "api/UserDashBoard/NannyBookingDetailByDate";
  static const String userBookingDataByDate =
      "api/UserDashBoard/UserBookingDeatilByDate";
  static const String updateCustomerBookingStatus =
      "api/UserDashBoard/UpdateBookingStatus";
  static const String searchChatUser = "api/User/SearchChatUser";
  static const String validateAppointment = "api/UserDashBoard/ValidateAppointment";

  /// ----------------------- Nanny Interface Apis Url----------------------------------//
  ///
  ///

  static const String addOrEditServices =
      'api/NannyDashBoard/AddOrEditServices';
  static const String addOrEditBankDetails =
      'api/NannyDashBoard/AddOrEditBankDetail';
  static const String deleteBankDetails =
      'api/NannyDashBoard/DeleteBankAccount';
  static const String getBankDetail = 'api/NannyDashBoard/GetBankDetail';
  static const String getNannyProfile = 'api/NannyDashBoard/MyProfile';
  static const String getCustomerProfileById =
      'api/NannyDashBoard/CustomerDetail';

  static const String addAvailability = 'api/NannyDashBoard/AddAvailability';
  static const String nannyDashboard = 'api/NannyDashBoard/HomeDashBoard';
  static const String setAvailability =
      'api/NannyDashBoard/SetAvailabilityStatus';

  /// ------------------ Nanny availability api urls -------------------------------

  static const String nannyBookingList =
      'api/NannyDashBoard/NannyAvailabilityList';
  static const String getNannyAvailabilityByDate =
      'api/NannyDashBoard/NannyAvailabilityByDate';
  static const String editNannyAvailability =
      'api/NannyDashBoard/EditAvailability';
  static const String deleteNannyAvailability =
      'api/NannyDashBoard/DeleteAvailability';

  /// ----------------------- Nanny calender api urls ---------------------

  static const String getNannyAllBookingDates =
      'api/NannyDashBoard/AllNannyBookingDates';

  static const String postNannyBookingDetails =
      'api/NannyDashBoard/NannyBookingDeatil';
  static const String acceptOrRejectBooking =
      'api/NannyDashBoard/AcceptOrRejectBooking';
  static const String updateBookingStatus =
      'api/NannyDashBoard/UpdateBookingStatus';
  static const String customerBookedNannyDetail =
      'api/NannyDashBoard/BookingDetail';
}
