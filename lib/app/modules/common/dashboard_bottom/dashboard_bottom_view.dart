import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/common/dashboard_bottom/dashboard_bottom_controller.dart';
import 'package:northshore_nanny_flutter/app/modules/parents/home/widgets/custom_home_list.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';
import 'package:northshore_nanny_flutter/app/res/constants/extensions.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';

class DashboardBottomView extends StatelessWidget {
  DashboardBottomView({super.key});
  final selectedInterface = Get.arguments;
  @override
  Widget build(BuildContext context) => GetBuilder<DashboardBottomController>(
        initState: (_) {
          Get.find<DashboardBottomController>().whichProfile =
              selectedInterface;
        },
        builder: (controller) => Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              showUnselectedLabels: true,
              onTap: (value) => controller.selectedBottomTab = value,
              currentIndex: controller.selectedTabIndex,
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
                  icon: SvgPicture.asset(
                    controller.selectedTabIndex == index
                        ? controller.bottomTabList[index].selectedBottomSvg
                        : controller.bottomTabList[index].bottomSvg,
                  ),
                  label: controller.bottomTabList[index].bottomTabName.tr,
                  backgroundColor: AppColors.primaryColor,
                ),
              ),
              backgroundColor: AppColors.primaryColor,
            ),
            body: controller.bottomBarScreenList
                .elementAt(controller.selectedTabIndex)

            //  Padding(
            //   padding: Dimens.edgeInsets16,
            //   child: HomeCustomListView(
            //     description:
            //         'Dedicated nanny providing loving Care and guidance to littleness. Experienced in nurturing children',
            //     image: Assets.iconsImage,
            //     name: 'Christina Wang',
            //     rating: '4.5',
            //     reviews: '(21 reviews)',
            //     servicesList: controller.homeCustomList,
            //     isHeartTapped: false,
            //     heartSvg: Assets.iconsHeartOutline,
            //   ),
            // ),
            ),
      );
}
