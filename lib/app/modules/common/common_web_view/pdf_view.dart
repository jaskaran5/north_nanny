import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_app_bar.dart';

import 'package:webview_flutter/webview_flutter.dart';

class PdfView extends StatefulWidget {
  final String url;
  const PdfView({super.key, required this.url});

  @override
  State<PdfView> createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView> {
  late final WebViewController controller;

  // var loadingPercentage = 0;
  // var error = false;

  @override
  void initState() {
    super.initState();
    controller = WebViewController();
    controller.setBackgroundColor(Colors.white);

    controller.setNavigationDelegate(
      NavigationDelegate(
        onPageStarted: (String url) {
          log("on page started called ");
        },
        onProgress: (int progress) {
          log("progress is:-->> $progress");
        },
        onPageFinished: (String url) {},
        // onWebResourceError: (WebResourceError error) =>
        // setState(() => = true

        // ),
        onNavigationRequest: (NavigationRequest request) =>
            NavigationDecision.navigate,
      ),
    );
    controller.loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    // if (Constants.privacyPolicy.isEmpty || error == true) {
    //   return const Center(child: Text("Error."));
    // }

    return Scaffold(
      appBar: CustomAppbarWidget(
        title: "PDF Viewer",
        centerTitle: true,
        isLeading: true,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: AppColors.blackColor,
            )),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: controller),
        ],
      ),
    );
  }
}
