import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

class PDFScreen extends StatefulWidget {
  final String path;
  const PDFScreen({super.key, required this.path});

  @override
  State<PDFScreen> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PDFScreen> {
  late final WebViewController controller;

  bool loading = true;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(
        Uri.parse(
            "https://docs.google.com/gview?embedded=true&url=${widget.path}"),
      );
    disableLoading();
    print(
        "Url:{https://docs.google.com/gview?embedded=true&url=${widget.path}");
  }

  /// used to disable loading
  disableLoading() async {
    controller.setNavigationDelegate(
      NavigationDelegate(
        onProgress: (progress) {
          if (progress == 100) {
            loading = false;
            setState(() {});
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: CustomAppBarWidget(
      //   title: "Review Lease Document",
      //   centerTitle: true,
      //   fontWeight: AppTextSize.largeextraTextSize,
      // ),
      body: SafeArea(
        child: loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : WebViewWidget(
                // gestureRecognizers:on ,
                layoutDirection: TextDirection.rtl,
                controller: controller,
              ),
      ),
    );
  }
}
