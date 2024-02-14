import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/controllers/controllers.dart';
import 'package:northshore_nanny_flutter/res/res.dart';
import 'package:northshore_nanny_flutter/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/widgets/app_text.dart';
import 'package:northshore_nanny_flutter/widgets/custom_app_bar.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final selectedInterface = Get.arguments;
  @override
  Widget build(BuildContext context) => GetBuilder<HomeController>(
        initState: (_) {
          Get.find<HomeController>().whichProfile = selectedInterface;
        },
        builder: (controller) => Scaffold(
          appBar: CustomAppbarWidget(
            addBackButton: false,
            titleWidget: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: Dimens.forty,
                  width: Dimens.twoHundredEightyOne,
                  color: AppColors.searchColor,
                  padding: Dimens.edgeInsets10,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(Assets.iconsSearch),
                      AppText(
                        text: TranslationKeys.search.tr,
                        style: AppStyles.ubHintColor12W500,
                      ),
                    ],
                  ),
                ),
                Dimens.boxWidth10,
                SvgPicture.asset(
                  Assets.iconsFilter,
                ),
              ],
            ),
          ),
          floatingActionButton: Container(
            height: Dimens.thirtyFive,
            width: Dimens.hundredTen,
            padding: Dimens.edgeInsets10,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(
                Dimens.twenty,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.hintColor.withOpacity(.2),
                  blurRadius: Dimens.one,
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  Assets.iconsListView,
                ),
                Dimens.boxWidth2,
                AppText(
                  text: TranslationKeys.listView.tr,
                  style: AppStyles.ubNavyBlue12W600,
                  maxLines: 1,
                )
              ],
            ),
          ),
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
        ),
      );
}
