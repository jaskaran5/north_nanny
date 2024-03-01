import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/common/settings/setting_controller.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';
import 'package:northshore_nanny_flutter/app/res/constants/string_contants.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_app_bar.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_button.dart';

class InviteAFriendView extends StatelessWidget {
  const InviteAFriendView({super.key});

  @override
  Widget build(BuildContext context) =>
      GetBuilder<SettingController>(
        init: SettingController(),

      //     initState: (_) {
      //   Get.find<SettingController>().getAndUpdateLoginType();
      // },

          builder: (controller) {
        return Scaffold(
          appBar: const CustomAppbarWidget(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Container(
            padding: Dimens.edgeInsetsL16R16,
            height: Dimens.oneHundredFifty,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: Dimens.edgeInsets6,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimens.twelve),
                    border: Border.all(
                      color: AppColors.navyBlue,
                      width: Dimens.one,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: Dimens.edgeInsetsL6,
                        child: AppText(
                          text: 'https://northshore-nanny-app.com',
                          style: AppStyles.ubNavyBlue15W600,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        height: Dimens.thirtyEight,
                        width: Dimens.thirtyEight,
                        padding: Dimens.edgeInsets8,
                        decoration: BoxDecoration(
                          color: AppColors.lightNavyBlue,
                          borderRadius: BorderRadius.circular(Dimens.seven),
                        ),
                        child: SvgPicture.asset(Assets.iconsCopy),
                      ),
                    ],
                  ),
                ),
                Dimens.boxHeight32,
                CustomButton(
                  title: TranslationKeys.sendReferralLink.tr,
                  backGroundColor: AppColors.navyBlue,
                  onTap: () {
                    // Share.share('Hello Welcome to Nanny', subject: 'https://northshore-nanny-app.com');
                  },
                ),
                Dimens.boxHeight10,
              ],
            ),
          ),
          body: Padding(
            padding: Dimens.edgeInsets16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Dimens.boxHeight10,
                AppText(
                  text: TranslationKeys.inviteAFriend.tr,
                  style: AppStyles.pdSemiBoldBlack24,
                  maxLines: 1,
                  textAlign: TextAlign.start,
                ),
                Dimens.boxHeight16,

                AppText(
                  text:(controller.loginType.value == StringConstants.customer)? TranslationKeys.sendUniqueReferralLinkCustomer.tr:'Send this unique referral link out to your friends! For each friend that joins the app, you will get a \$5 reward.',
                  style: AppStyles.ubGrey16W400,
                  textAlign: TextAlign.start,
                ),
                Dimens.boxHeight24,
                AppText(
                  text:

                  TranslationKeys.whatInviteFriendNeedToDo.tr,
                  style: AppStyles.ubNavyBlue18W600,
                  maxLines: 1,
                  textAlign: TextAlign.start,
                ),
                Dimens.boxHeight16,
                ...List.generate(
                  controller.inviteList.length,
                  (index) => Padding(
                    padding: Dimens.edgeInsetsB16,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: Dimens.twentyEight,
                          width: Dimens.twentyEight,
                          padding: Dimens.edgeInsets4,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.navyBlue,
                              width: Dimens.one,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: AppText(
                            text: (index + 1).toString(),
                            style: AppStyles.ubNavyBlue16W600,
                            maxLines: 1,
                          ),
                        ),
                        Dimens.boxWidth16,
                        SizedBox(
                          width: Dimens.twoHundredSeventy,
                          child: AppText(
                            text: controller.inviteList[index].toString(),
                            style: AppStyles.ubGrey16W400,
                            maxLines: 2,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}
