import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/nanny/nanny_views/nanny_home/nanny_home_controller.dart';
import 'package:northshore_nanny_flutter/app/modules/nanny/nanny_views/nanny_home/widgets/custom_nanny_home_tile.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/utils/utility.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_app_bar.dart';
import 'package:northshore_nanny_flutter/app/widgets/review_custom_bottom_sheet.dart';
import 'package:northshore_nanny_flutter/navigators/routes_management.dart';

import '../../../../res/theme/styles.dart';
import '../../../../widgets/app_text.dart';
import '../../../common/booking_details/booking_detail_view.dart';

class NannyHomeView extends StatelessWidget {
  const NannyHomeView({super.key});

  @override
  Widget build(BuildContext context) => GetBuilder<NannyHomeController>(
        init: NannyHomeController(),
        builder: (controller) => Scaffold(
          appBar: CustomAppbarWidget(
            leadingWidth: Dimens.zero,
            titleWidget: Container(
              padding: Dimens.edgeInsets16,
              margin: Dimens.edgeInsetsT10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        text: 'Chicago, Naperville',
                        style: AppStyles.ubLocationColor14W400,
                        maxLines: 1,
                      ),
                      Dimens.boxHeight2,
                      AppText(
                        text: 'Good morning, Christina ',
                        style: AppStyles.pdBlack18W600,
                        maxLines: 1,
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Transform.scale(
                        scale: 0.8,
                        child: CupertinoSwitch(
                          value: controller.isSwitchOn,
                          onChanged: (value) {
                            controller.isSwitchOn = value;
                            controller.update();
                          },
                          activeColor: AppColors.navyBlue,
                          thumbColor: AppColors.primaryColor,
                          trackColor: AppColors.lightNavyBlue,
                        ),
                      ),
                      Dimens.boxHeight2,
                      AppText(
                        text: TranslationKeys.available.tr,
                        style: AppStyles.ubNavyBlue10W400,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          body: Padding(
            padding: Dimens.edgeInsets16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: Dimens.edgeInsets10,
                  height: Dimens.seventyEight,
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: AppColors.navyBlue,
                    borderRadius: BorderRadius.circular(Dimens.fourteen),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.lightNavyBlue.withOpacity(.5),
                        blurRadius: Dimens.five,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: Dimens.sixty,
                        width: Dimens.sixty,
                        padding: Dimens.edgeInsets10,
                        decoration: BoxDecoration(
                          color: AppColors.trackerBackgroundColor,
                          borderRadius: BorderRadius.circular(Dimens.ten),
                        ),
                        child: SvgPicture.asset(Assets.iconsDollarCircle),
                      ),
                      Dimens.boxWidth12,
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            text: TranslationKeys.totalEarning.tr,
                            style: AppStyles.ubBBD7F4lightNavyBlue12W400,
                            maxLines: 1,
                          ),
                          Dimens.boxHeight4,
                          AppText(
                            text: '\$25,365',
                            style: AppStyles.ubColorFFF24W700,
                            maxLines: 1,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Dimens.boxHeight14,
                AppText(
                  text: TranslationKeys.bookingRequests.tr,
                  maxLines: 1,
                  textAlign: TextAlign.left,
                  style: AppStyles.ubBlack16W600,
                ),
                Dimens.boxHeight14,
                Expanded(
                  child: ListView(
                    children: List.generate(
                      controller.homeList.length,
                      (index) => GestureDetector(
                        onTap: () {
                          RouteManagement.goToNannyBookingView();
                        },
                        child: CustomNannyHomeTile(
                          day: controller.homeList[index]['day'].toString(),
                          dateFormatInMonthYearDayOfWeek:
                              controller.homeList[index]['date'].toString(),
                          timing: controller.homeList[index]['totalTiming']
                              .toString(),
                          totalPrice: controller.homeList[index]['totalPrice']
                              .toString(),
                          image: Assets.iconsImage,
                          name:
                              controller.homeList[index]['userName'].toString(),
                          rating: controller.homeList[index]['totalRating']
                              .toString(),
                          reviews: controller.homeList[index]['totalReview']
                              .toString(),
                          servicesList: controller.servicesList,
                          onTapRating: () {
                            Utility.openBottomSheet(
                              const CustomReviewBottomSheet(
                                totalReviews: '21',
                                totalReviewsRating: 4.5,
                                reviewsList: [
                                  'Michael Johnson',
                                  'Giorgio Chiellini',
                                  'Michael Johnson',
                                  'Alex Morgan',
                                  'Giorgio Chiellini'
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
