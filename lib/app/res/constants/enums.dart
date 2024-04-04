enum RequestType {
  get,
  post,
  put,
  patch,
  delete,
  upload;
}

enum AppFlavor {
  dev,
  prod;
}

enum MessageType {
  error,
  success,
  information;
}

enum HourlyChildrenRateList {
  forPlusChildren,
  forChildren,
  threeChildren,
  twoChildren,
  oneChild,
}

enum BookingDetailStatus {
  booked,
  arrived,
  rejected,
  disputeRaised,
  givenReviewByCustomer,
  reviewByOtherUser,
}

enum NannyBookingDetailStatus {
  present,
  accepted,
  onMyWay,
  arrived,
  endJob,
  waitingForApproval,
  givenReviewByNanny,
  rejected,
  disputeRaised,
}

enum BottomTabs {
  home,
  messages,
  notifications,
  calender,
  settings,
}

enum Services {
  housekeeping,
  driving,
  petCare,
  homeWorkHelp,
  runningErrands,
  funActivityOutHouse,
}

enum GenderConstant {
  male,
  female,
}

enum BookingDetails {
  location,
  hours,
  date,
  time,
}
