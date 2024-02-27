import 'package:get/get.dart';

class NannyHomeController extends GetxController {
  /// used to switch on or off
  bool isSwitchOn = true;

  /// home list
  var homeList = [
    {
      'userName': 'Michael Johnson',
      'totalPrice': 112,
      'totalRating': 4.5,
      'totalReview': '(21 reviews)',
      'date': 'January 2024, Friday',
      'totalTiming': '01:00 PM to 05:00 PM',
      'day': '03',
    },
    {
      'userName': 'Michael Johnson',
      'totalPrice': 112,
      'totalRating': 4.5,
      'totalReview': '(21 reviews)',
      'date': 'January 2024, Friday',
      'totalTiming': '01:00 PM to 05:00 PM',
      'day': '03',
    },
  ];

  var servicesList = [
    'Distance: 3 miles',
    'Number of kids: 2',
  ];
}
