import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:northshore_nanny_flutter/app/data/api/api_response.dart';
import 'package:northshore_nanny_flutter/app/data/api/errors/api_error.dart';
import 'package:northshore_nanny_flutter/app/data/api/interface_controller/api_interface_controller.dart';
import 'package:northshore_nanny_flutter/app/data/storage/storage.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/utils/app_utils.dart';
import 'package:northshore_nanny_flutter/app/utils/loading_dialog.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_inkwell_widget.dart';

extension NullString on String? {
  bool get isNullOrEmpty => this == null || this!.trim().isEmpty;
}

extension FutureExt<T> on Future<Response<T>?> {
  void futureValue(
    Function(T value) response, {
    Function(String? error)? onError,
    required VoidCallback retryFunction,
    bool showLoading = true,
  }) {
    final interface = Get.find<ApiInterfaceController>();
    interface.error = null;

    if (showLoading) LoadingDialog.showLoadingDialog();

    timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        LoadingDialog.closeLoadingDialog();

        Utils.showSnackbar('Connection Timeout');

        _retry(interface, retryFunction);

        throw const ApiError(
          type: ErrorType.connectTimeout,
          error: "ConnectionTimeOut",
        );
      },
    ).then((value) {
      LoadingDialog.closeLoadingDialog();

      if (value?.body != null) {
        final result = ApiResponse.getResponse<T>(value!);
        if (result != null) {
          response(result);
        }
      }

      interface.update();
    }).catchError((e) {
      LoadingDialog.closeLoadingDialog();

      if (e == null) return;

      final String errorMessage = e is ApiError ? e.message : e.toString();

      if (e is ApiError) {
        if ((e.type == ErrorType.connectTimeout ||
            e.type == ErrorType.noConnection)) {
          interface.error = e;

          _retry(interface, retryFunction);
        } else {
          Utils.showDialog(
            errorMessage,
            onTap: errorMessage != "unauthorize"
                ? null
                : () {
                    // Storage.clearStorage();
                    // Get.offAllNamed(
                    //   "/home",
                    //   //change the ROUTE to the LOGIN or SPLASH screen so that the
                    //   //user can login again on UnauthorizeError error
                    // );
                  },
          );
        }
      }

      if (onError != null) {
        onError(errorMessage);
      }

      printError(info: 'catchError: error: $e\nerrorMessage: $errorMessage');
    });
  }

  void _retry(
    ApiInterfaceController interface,
    VoidCallback retryFunction,
  ) {
    interface.retry = retryFunction;
    interface.update();
  }

  static void showDialog(
    String? message, {
    String title = "error",
    bool success = false,
    VoidCallback? onTap,
  }) =>
      Get.defaultDialog(
        barrierDismissible: false,
        onWillPop: () async {
          Get.back();

          onTap?.call();

          return true;
        },
        title: success ? "success" : title,
        content: Text(
          message ?? "Something went wrong",
          textAlign: TextAlign.center,
          maxLines: 6,
          // style: AppTextStyle.semiBoldStyle.copyWith(
          //   color: AppColors.mineShaft,
          //   fontSize: Dimens.fontSize16,
          // ),
        ),
        confirm: Align(
          alignment: Alignment.centerRight,
          child: CustomInkwellWidget.text(
              onTap: () {
                Get.back();

                onTap?.call();
              },
              title: "oK",
              textStyle: AppStyles.fffUrban15w600

              // AppTextStyle.buttonTextStyle.copyWith(
              //   fontSize: Dimens.fontSize18,
              // ),
              ),
        ),
      );
}
