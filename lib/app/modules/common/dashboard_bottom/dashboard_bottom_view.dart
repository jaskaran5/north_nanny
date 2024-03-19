import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/common/dashboard_bottom/dashboard_bottom_controller.dart';
import 'package:northshore_nanny_flutter/app/res/constants/extensions.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';

import '../../../res/constants/string_contants.dart';

class DashboardBottomView extends StatelessWidget {
  const DashboardBottomView({super.key});
  @override
  Widget build(BuildContext context) => GetBuilder<DashboardBottomController>(
        init: DashboardBottomController(),
        builder: (controller) => Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            showUnselectedLabels: true,
            onTap: (value) => controller.selectedBottomTab = value,
            currentIndex: controller.selectedTabIndex.value,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: true,
            selectedLabelStyle: AppStyles.ubNavyBlue12W600,
            unselectedLabelStyle: AppStyles.ubHintColor12W500,
            useLegacyColorScheme: false,
            selectedIconTheme: const IconThemeData(
              color: AppColors.navyBlue,
            ),
            items: List.generate(
              controller.bottomTabList.length,
              (index) => BottomNavigationBarItem(
                icon: Stack(
                  children: [
                    SvgPicture.asset(
                      controller.selectedTabIndex.value == index
                          ? controller.bottomTabList[index].selectedBottomSvg
                          : controller.bottomTabList[index].bottomSvg,
                    ),
                    if (controller.bottomTabList[index].bottomTabName
                            .toLowerCase() ==
                        '')
                      Positioned(
                        top: Dimens.two,
                        right: Dimens.zero,
                        child: Container(
                          height: Dimens.sixteen,
                          width: Dimens.sixteen,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            border: Border.all(
                              color: AppColors.primaryColor,
                              width: Dimens.one,
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  color: AppColors.greenColor.withOpacity(.5),
                                  blurRadius: Dimens.two)
                            ],
                          ),
                          child: AppText(
                            text: '2',
                            style: AppStyles.ubWhite10700,
                            maxLines: 1,
                          ),
                        ),
                      )
                  ],
                ),
                label: controller.bottomTabList[index].bottomTabName.tr,
                backgroundColor: AppColors.primaryColor,
              ),
            ),
            backgroundColor: AppColors.primaryColor,
          ),
          body: (controller.loginType == StringConstants.customer)
              ? controller.bottomBarScreenListCustomer
                  .elementAt(controller.selectedTabIndex.value)
              : controller.bottomBarScreenListNanny
                  .elementAt(controller.selectedTabIndex.value),
        ),
      );
}
