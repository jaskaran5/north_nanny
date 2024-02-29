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
  present,
  past,
  review,
  complete,
  now,
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
}
