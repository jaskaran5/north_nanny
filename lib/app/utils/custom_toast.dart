import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';

void toast({required String msg, bool isError = false}) {
  BotToast.cleanAll();
  BotToast.showCustomText(
    duration: const Duration(seconds: 2),
    toastBuilder: (cancelFunc) => Align(
      alignment: Alignment(Dimens.zero, 0.8),
      child: Container(
        padding: Dimens.edgeInsets8,
        margin: EdgeInsets.symmetric(horizontal: Dimens.fifteen),
        decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(Dimens.ten),
            boxShadow: [
              BoxShadow(
                color: AppColors.hintColor.withOpacity(0.3),
                blurRadius: Dimens.four,
                spreadRadius: Dimens.zero,
                offset: Offset(
                  Dimens.zero,
                  Dimens.two,
                ),
              )
            ]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: Dimens.edgeInsets8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimens.ten),
                    color: isError
                        ? AppColors.fC3030RedColor.withOpacity(0.2)
                        : AppColors.greenColor05B016.withOpacity(0.2),
                  ),
                  child: Icon(
                    isError ? Icons.error : Icons.done_all,
                    color: isError ? AppColors.fC3030RedColor : AppColors.greenColor05B016,
                  ),
                ),
                Dimens.boxWidth10,
                Flexible(
                  child: Text(
                    msg,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: Dimens.fifteen,
                      fontWeight: FontWeight.w600,
                      color: isError
                          ? AppColors.fC3030RedColor
                          : AppColors.greenColor05B016,
                    ),
                  ),
                ),
                Dimens.boxWidth10,
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
