import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/res/constants/app_constants.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_app_bar.dart';

import 'package:webview_flutter/webview_flutter.dart';

class CommonWebView extends StatefulWidget {
  const CommonWebView({super.key, required this.appBarTitle});
  final String appBarTitle;
  @override
  State<CommonWebView> createState() => _CommonWebViewState();
}

class _CommonWebViewState extends State<CommonWebView> {
  late final WebViewController controller;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    controller = WebViewController();
    controller.setBackgroundColor(Colors.white);
    controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    controller.setNavigationDelegate(
      NavigationDelegate(
        onPageStarted: (String url) {
          log("on page started called ");
        },
        onProgress: (int progress) {
          log("progress is:-->> $progress");
          if (progress == 100) {
            isLoading = false;
            setState(() {});
          }
        },
        onPageFinished: (String url) {},
        onNavigationRequest: (NavigationRequest request) =>
            NavigationDecision.navigate,
      ),
    );
    controller.loadRequest(Uri.parse(
        widget.appBarTitle == TranslationKeys.aboutUs.tr
            ? AppConstants.aboutUsWebViewUrl
            : 'https://www.codemicros.com'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarWidget(
        title: widget.appBarTitle,
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
        alignment: Alignment.center,
        children: [
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : WebViewWidget(controller: controller),
        ],
      ),
    );
  }
}
