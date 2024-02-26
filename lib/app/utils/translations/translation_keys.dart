/// `TranslationKeys` is a singleton class that will contain all the translation keys
///
/// If need to add another key add it inside this class.
/// For simplicity keep the key (variable) name same as its value
///
/// For example
/// ```dart
/// static const String foo = 'foo';
/// ```
///
/// To add the translated strings check [TranslationsFile]
class TranslationKeys {
  const TranslationKeys._();

  static const String appName = 'appName';
  static const String findTheBestBabySitter = "findTheBestBabySitter";
  static const String needASitter = 'needASitter';
  static const String iAmSitter = 'iAmSitter';
  static const String helloRegistration = 'helloRegistration';
  static const String creatingAnAccount = 'creatingAnAccount';
  static const String enterEmail = 'enterEmail';

  static const String enterPassword = 'enterPassword';
  static const String confirmPassword = 'confirmPassword';
  static const String bySignUp = 'bySignUp';
  static const String termAndConditions = 'termAndConditions';
  static const String and = 'and';
  static const String privacyPolicy = 'privacyPolicy';
  static const String register = 'register';
  static const String alreadyHaveAccount = 'alreadyHaveAccount';
  static const String signIn = 'signIn';
  static const String welComeBackGlad = 'welComeBackGlad';
  static const String enterLogInInfo = 'enterLogInInfo';
  static const String rememberMe = 'rememberMe';
  static const String forgotPassword = 'forgotPassword';
  static const String orLoginWith = 'orLoginWith';
  static const String doNotHaveAnAccount = 'doNotHaveAnAccount';
  static const String registerNow = 'registerNow';
  static const String doNotWorryEnterEmail = 'doNotWorryEnterEmail';
  static const String sendCode = 'sendCode';
  static const String emailOtpVerification = 'emailOtpVerification';
  static const String enterTheCode = 'enterTheCode';
  static const String toResetPassword = 'toResetPassword';
  static const String submit = 'submit';
  static const String didNotReceiveOtp = 'didNotReceiveOtp';
  static const String reSendOtp = 'reSendOtp';
  static const String createNewPassword = 'createNewPassword';
  static const String changepassword = 'Change password';
  static const String enterNewPassword = 'enterNewPassword';
  static const String enterOldPassword = 'Enter Old Pasword';
  static const String newPassword = 'New Password';
  static const String confirmNewPassword = 'confirmNewPassword';
  static const String newPasswordMustBeUnique = 'newPasswordMustBeUnique';
  static const String changePassword = 'changePassword';
  static const String passwordChanged = 'passwordChanged';
  static const String passwordChangeSuccess = 'passwordChangeSuccess';
  static const String backToLogIn = 'backToLogIn';
  static const String backTosetting = 'Back To Setting';
  static const String email = 'email';
  static const String createProfile = 'createProfile';
  static const String firstName = 'firstName';
  static const String lastName = 'lastName';
  static const String selectLocation = 'selectLocation';
  static const String age = 'age';
  static const String gender = 'gender';
  static const String male = 'male';
  static const String female = 'female';
  static const String profilePicture = 'profilePicture';
  static const String optional = 'optional';
  static const String continueWord = 'continueWord';
  static const String childProfile = 'childProfile';
  static const String noOfChildren = 'noOfChildren';
  static const String skipForNow = 'skipForNow';
  static const String skip = 'skip';
  static const String createChildProfile = 'createChildProfile';
  static const String addChildProfile = 'Add Child Profile';

  static const String nameOfChild = 'nameOfChild';
  static const String ageOfChild = 'ageOfChild';
  static const String anythingElse = 'anythingElse';
  static const String medicalCondition = 'medicalCondition';
  static const String allergiesDietaryRestriction =
      'allergiesDietaryRestriction';
  static const String experience = 'experience';
  static const String nameOfSchool = 'nameOfSchool';
  static const String nameOfCollege = 'nameOfCollege';
  static const String driverLicense = 'driverLicense';
  static const String tellUsAboutYourSelf = 'tellUsAboutYourSelf';
  static const String selectServices = 'selectServices';
  static const String houseKeeping = 'houseKeeping';
  static const String driving = 'driving';
  static const String petCare = 'petCare';
  static const String homeWorkHelp = 'homeWorkHelp';
  static const String runningErrands = 'runningErrands';
  static const String funActivityOutHouse = 'funActivityOutHouse';
  static const String pricing = 'pricing';
  static const String aFixedHourlyRate = 'aFixedHourlyRate';
  static const String hourlyRate = 'hourlyRate';
  static const String children = 'children';
  static const String year = 'year';
  static const String bankDetails = 'bankDetails';
  static const String bankName = 'bankName';
  static const String accountHolderName = 'accountHolderName';
  static const String accountNumber = 'accountNumber';
  static const String routingNumber = 'routingNumber';
  static const String addBank = 'addBank';
  static const String waitingForApproval = 'waitingForApproval';
  static const String submissionPendingForApproval =
      'submissionPendingForApproval';
  static const String administrationReviewOrApproveIt =
      'administrationReviewOrApproveIt';
  static const String yes = 'yes';
  static const String no = 'no';
  static const String child = 'child';
  static const String search = 'search';
  static const String home = 'home';
  static const String messages = 'messages';
  static const String calender = 'calender';
  static const String settings = 'settings';
  static const String listView = 'listView';
  static const String mapView = 'mapView';
  static const String noResultFound = 'noResultFound';
  static const String filters = 'filters';
  static const String distance = 'distance';
  static const String dateAndTime = 'dateAndTime';
  static const String miles = 'miles';
  static const String reset = 'reset';
  static const String apply = 'apply';
  static const String selectDate = 'selectDate';
  static const String selectTime = 'selectTime';
  static const String reviews = 'reviews';
  static const String nannyProfile = 'nannyProfile';
  static const String about = 'about';
  static const String services = 'services';
  static const String availability = 'availability';
  static const String bookSitter = 'bookSitter';
  static const String scheduleNanny = 'scheduleNanny';
  static const String confirmBooking = 'confirmBooking';
  static const String addPaymentMethod = 'addPaymentMethod';
  static const String cardHolderName = 'cardHolderName';
  static const String creditDebit = 'creditDebit';
  static const String expirationDate = 'expirationDate';
  static const String cVV = 'cVV';
  static const String backToHome = 'backToHome';
  static const String nannyRequested = 'nannyRequested';
  static const String notificationNannyAccept = 'notificationNannyAccept';
  static const String cardWillCharged = 'cardWillCharged';
  static const String typeOfServices = 'typeOfServices';
  static const String selectChildren = 'selectChildren';
  static const String notifications = 'notifications';
  static const String subject = 'Subject';
  static const String message = 'Message';
  static const String emailE = 'Email';
  static const String noBookings = 'noBookings';
  static const String bookingDetails = 'bookingDetails';
  static const String trackLocation = 'trackLocation';
  static const String totalTimeLeft = 'totalTimeLeft';
  static const String favorites = 'favorites';
}
