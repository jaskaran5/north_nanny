import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:northshore_nanny_flutter/app/modules/common/payment_details/payment_detail_controller.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_app_bar.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_button.dart';

import '../../../../navigators/routes_management.dart';
import '../../../utils/translations/translation_keys.dart';

class CustomPaymentDetails extends StatelessWidget {
  const CustomPaymentDetails({
    super.key,
    required this.isComeFromSendTip,
    required this.isComeFromConfirmBooking,
  });
  final bool isComeFromSendTip;
  final bool isComeFromConfirmBooking;

  @override
  Widget build(BuildContext context) => GetBuilder<PaymentDetailController>(
        id: 'card-list-view',
        init: PaymentDetailController(),
        initState: (_) {
          Get.lazyPut<PaymentDetailController>(() => PaymentDetailController());
          Get.find<PaymentDetailController>().getCardList();
          if (isComeFromConfirmBooking || isComeFromSendTip) {
            Get.find<PaymentDetailController>().postAddCard(
                isComeFromBooking:
                    isComeFromConfirmBooking || isComeFromSendTip);
          }
        },
        builder: (controller) => Scaffold(
          appBar: CustomAppbarWidget(
            title: isComeFromSendTip
                ? TranslationKeys.paymentDetails.tr
                : TranslationKeys.paymentMethod.tr,
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Container(
            height: !isComeFromSendTip && !isComeFromConfirmBooking
                ? Dimens.eightySix
                : Dimens.oneHundredSeventy,
            padding: Dimens.edgeInsets16,
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomButton(
                  title: isComeFromSendTip
                      ? 'Add New Card'
                      : TranslationKeys.addCard.tr,
                  backGroundColor: isComeFromSendTip
                      ? AppColors.lightNavyBlue
                      : AppColors.navyBlue,
                  onTap: () {
                    controller.postAddCard(
                        isComeFromBooking:
                            isComeFromConfirmBooking || isComeFromSendTip);
                    // RouteManagement.goToAddPaymentMethodScreen(
                    //   isComeFromNannyProfile: true,
                    //   buttonText: TranslationKeys.add.tr,
                    //   onTapButton: () {
                    //     Get.back();
                    //   },
                    // );
                  },
                  titleStyle:
                      isComeFromSendTip ? AppStyles.ubNavyBlue15W600 : null,
                ),
                if (isComeFromSendTip) ...[
                  Dimens.boxHeight16,
                  CustomButton(
                    title: TranslationKeys.submit.tr,
                    backGroundColor: AppColors.navyBlue,
                    onTap: () {
                      /// here to write the code send tip .

                      /// used to show tip received by nanny.
                      RouteManagement.goToSuccessView(
                        buttonText: TranslationKeys.backToHome.tr,
                        successSvg: '',
                        header: TranslationKeys.thankYou.tr,
                        subHeader: TranslationKeys.yourNannyTipReceived.tr,
                        onTapButton: () {
                          RouteManagement.goToOffAllDashboard(
                              isFromSetting: false);
                        },
                        subTitleStyle: AppStyles.ubGrey16W500,
                        subHeaderMaxLines: 2,
                        headerMaxLines: 2,
                        successImage: Assets.imagesPinkHeart,
                        sendTipText: true,
                      );
                    },
                    // titleStyle: submitButtonStyle,
                  ),
                ],
              ],
            ),
          ),
          body: Padding(
            padding: Dimens.edgeInsets16,
            child: controller.cardList?.isNotEmpty == true &&
                    controller.cardList != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      controller.cardList?.length ?? 0,
                      (index) => Container(
                        padding: Dimens.edgeInsets10,
                        margin: Dimens.edgeInsetsB16,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          border: Border.all(
                            color: controller.cardList![index].isDefaultCard
                                ? AppColors.navyBlue
                                : AppColors.primaryColor,
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.lightNavyBlue.withOpacity(.8),
                              blurRadius: Dimens.eight,
                            )
                          ],
                          borderRadius: BorderRadius.circular(Dimens.twenty),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: Dimens.fiftyFive + Dimens.three,
                                  width: Dimens.fiftyFive + Dimens.three,
                                  padding: Dimens.edgeInsets6,
                                  decoration: BoxDecoration(
                                    color: AppColors.colorEEF5FCLightNavyBlue,
                                    borderRadius:
                                        BorderRadius.circular(Dimens.ten),
                                  ),
                                  child: SvgPicture.asset(
                                    controller.cardList?[index].cardImage ==
                                            'visa'
                                        ? Assets.iconsVisa
                                        : Assets.iconsMasterCard,
                                  ),
                                ),
                                Dimens.boxWidth10,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: 'XXXX XXXX ',
                                        style: AppStyles.ubBlack16W600,
                                        children: [
                                          TextSpan(
                                            text: controller
                                                .cardList?[index].cardNumber
                                                .toString(),
                                            style: AppStyles.ubBlack16W600,
                                          ),
                                        ],
                                      ),
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                    ),
                                    Dimens.boxHeight4,
                                    AppText(
                                      text:
                                          controller.cardList?[index].cardImage,
                                      maxLines: 1,
                                      style: AppStyles.ubGrey12W500,
                                    )
                                  ],
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                /// used to delete the card .
                                controller.deleteCard(
                                    cardId:
                                        controller.cardList?[index].cardId ??
                                            '');
                              },
                              child: SvgPicture.asset(
                                Assets.iconsDelete,
                                height: Dimens.thirty,
                                width: Dimens.thirty,
                              ),
                            ),
                            SvgPicture.asset(
                              controller.cardList![index].isDefaultCard
                                  ? Assets.iconsCircleTick
                                  : Assets.iconsUncheckCircle,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: AppText(
                      text: TranslationKeys.noResultFound.tr,
                      style: AppStyles.ubNavyBlue30W600,
                      maxLines: 1,
                    ),
                  ),
          ),
        ),
      );
}
