import 'package:get/get.dart';

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
}
