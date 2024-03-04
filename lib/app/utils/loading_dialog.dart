import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/utils/app_utils.dart';

typedef CloseDialog = void Function();

abstract class LoadingDialog {
  static CloseDialog? _loadingDialog;

  static CloseDialog _showLoadingDialog() {
    Get.printInfo(info: 'initialized loading');
    Utils.loadingDialog();
    return Utils.closeDialog;
  }

  static void showLoadingDialog() {
    _loadingDialog = _showLoadingDialog();
    Get.printInfo(info: 'start loading');
  }

  static void closeLoadingDialog() {
    Get.printInfo(info: 'close loading');
    _loadingDialog?.call();
  }
}
