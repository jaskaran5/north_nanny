import 'package:get/get.dart';

import '../../../res/constants/assets.dart';
import '../../../res/constants/enums.dart';

class BookingDetailController extends GetxController {
  bool isExpandChildren = false;

  List<int> receiptPriceList = [
    10,
    10,
    23,
    92,
  ];
  int totalPrice = 0;
  getTotalPrice() {
    var totalSum = 0;
    for (var i in receiptPriceList) {
      totalSum = i + totalSum;
    }
    totalPrice = totalSum;
    update();
  }

  @override
  void onInit() {
    getTotalPrice();
    super.onInit();
  }

  List cardList = [
    {
      'asset': Assets.iconsMasterCard,
      'accountNumber': "9587 5498 8569 7569",
      'cardType': 'Master Card',
      'isSelected': true,
    },
    {
      'asset': Assets.iconsVisa,
      'accountNumber': "9587 5498 8569 7569",
      'cardType': 'Visa',
      'isSelected': false,
    }
  ];

  /// check status
  late BookingDetailStatus bookingDetailStatus = BookingDetailStatus.present;
}
