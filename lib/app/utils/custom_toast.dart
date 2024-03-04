import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';

void toast({required String msg, bool isError = false}) {
  BotToast.cleanAll();
  BotToast.showCustomText(
      duration: const Duration(seconds: 2),
      toastBuilder: (cancelFunc) => Align(
            alignment: const Alignment(0, 0.8),
            child: Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 4.0,
                      spreadRadius: 0.0,
                      offset: const Offset(
                        0.0,
                        2.0,
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
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: isError
                              ? Colors.red.withOpacity(0.2)
                              : Colors.green.withOpacity(0.2),
                        ),
                        child: Icon(
                          isError ? Icons.error : Icons.done_all,
                          color: isError ? Colors.red : Colors.green,
                        ),
                      ),
                      Dimens.boxWidth10,
                      Flexible(
                        child: Text(
                          msg,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: isError ? Colors.red : Colors.green,
                          ),
                        ),
                      ),
                      Dimens.boxWidth10,
                    ],
                  ),
                ],
              ),
            ),
          ));
}
