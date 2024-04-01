import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/common/payment_details/payment_detail_controller.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class StripWebView extends StatelessWidget {
  const StripWebView({super.key, required this.appBarTitle, required this.url});
  final String appBarTitle;
  final String url;

  @override
  Widget build(BuildContext context) => GetBuilder<PaymentDetailController>(
        init: PaymentDetailController(),
        initState: (state) {
          Get.lazyPut<PaymentDetailController>(
                () => PaymentDetailController(),
          );
          Get.find<PaymentDetailController>().initPaymentView(url: url);
        },
        builder: (paymentController) => Scaffold(
          appBar: CustomAppbarWidget(
            title: appBarTitle,
          ),
          body: paymentController.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : WebViewWidget(controller: paymentController.webViewController),
        ),
      );
}
