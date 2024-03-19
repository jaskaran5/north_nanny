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
  complete,
  giveReview,
  reviewComplete,
  rejected,
}

enum NannyBookingDetailStatus {
  present,
  accepted,
  onMyWay,
  arrived,
  endJob,
  waitingForApproval,
  reviewComplete,
  past,
  rejected,
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
