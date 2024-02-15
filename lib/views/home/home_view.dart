import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/controllers/controllers.dart';
import 'package:northshore_nanny_flutter/res/res.dart';
import 'package:northshore_nanny_flutter/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/views/filter_view/filter.dart';
import 'package:northshore_nanny_flutter/views/home/widgets/custom_home_list.dart';
import 'package:northshore_nanny_flutter/views/search_view/search.dart';
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
            titleWidget: controller.showListView
                ? Padding(
                    padding: Dimens.edgeInsets0.copyWith(
                      left: 15,
                      top: 15,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            AppText(
                              text: 'Chicago, Naperville',
                              style: AppStyles.ubLocationColor14W400,
                              maxLines: 1,
                            ),
                            Dimens.boxHeight2,
                            AppText(
                              text: '${TranslationKeys.needASitter.tr}?',
                              style: AppStyles.pdBlack18W600,
                              maxLines: 1,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: () {
                                Get.to(FilterView());
                              },
                              child: Container(
                                height: Dimens.thirtyFive,
                                width: Dimens.thirtyFive,
                                padding: Dimens.edgeInsets10,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          AppColors.hintColor.withOpacity(.2),
                                      blurRadius: Dimens.five,
                                    )
                                  ],
                                ),
                                child: SvgPicture.asset(
                                  Assets.iconsFillterIcon,
                                ),
                              ),
                            ),
                            Dimens.boxWidth10,
                            InkWell(
                              onTap: () {
                                Get.to(SearchView());
                              },
                              child: Container(
                                height: Dimens.thirtyFive,
                                width: Dimens.thirtyFive,
                                padding: Dimens.edgeInsets10,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          AppColors.hintColor.withOpacity(.2),
                                      blurRadius: Dimens.five,
                                    )
                                  ],
                                ),
                                child: SvgPicture.asset(
                                  Assets.iconsSearch,
                                  colorFilter: const ColorFilter.mode(
                                      AppColors.blackColor, BlendMode.srcIn),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(SearchView());
                        },
                        child: Container(
                          height: Dimens.forty,
                          width: Dimens.twoHundredEightyOne,
                          decoration: BoxDecoration(
                            color: AppColors.searchColor,
                            borderRadius: BorderRadius.circular(Dimens.ten),
                          ),
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
                      ),
                      Dimens.boxWidth10,
                      InkWell(
                        onTap: () {
                          Get.to(FilterView());
                        },
                        child: SvgPicture.asset(
                          Assets.iconsFilter,
                        ),
                      ),
                    ],
                  ),
          ),
          floatingActionButton: InkWell(
            onTap: () {
              controller.showListView = !controller.showListView;
              controller.update();
            },
            child: Container(
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
                    controller.showListView
                        ? Assets.iconsMapView
                        : Assets.iconsListView,
                  ),
                  Dimens.boxWidth2,
                  AppText(
                    text: controller.showListView
                        ? TranslationKeys.mapView.tr
                        : TranslationKeys.listView.tr,
                    style: AppStyles.ubNavyBlue12W600,
                    maxLines: 1,
                  )
                ],
              ),
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
          body: Padding(
            padding: Dimens.edgeInsets16,
            child: HomeCustomListView(
              description:
                  'Dedicated nanny providing loving Care and guidance to littleness. Experienced in nurturing children',
              image: Assets.iconsImage,
              name: 'Christina Wang',
              rating: '4.5',
              reviews: '(21 reviews)',
              servicesList: controller.homeCustomList,
              isHeartTapped: false,
              heartSvg: Assets.iconsHeartOutline,
            ),
          ),
        ),
      );
}
