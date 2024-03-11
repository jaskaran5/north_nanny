import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:northshore_nanny_flutter/app/modules/customer/home/widgets/custom_home_list.dart';
import 'package:northshore_nanny_flutter/app/modules/nanny_profile/nanny_profile_view.dart';
import 'package:northshore_nanny_flutter/app/modules/search_view/search_view.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/utils/utility.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_app_bar.dart';
import 'package:northshore_nanny_flutter/navigators/routes_management.dart';

import '../../../widgets/review_custom_bottom_sheet.dart';
import 'customer_home_controller.dart';

class CustomerHomeView extends StatelessWidget {
  const CustomerHomeView({super.key});
  @override
  Widget build(BuildContext context) => GetBuilder(
        init: CustomerHomeController(),
        builder: (controller) => Scaffold(
          appBar: CustomAppbarWidget(
            leadingWidth: Dimens.zero,
            addBackButton: false,
            titleWidget: controller.showListView.value
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
                            GestureDetector(
                              onTap: () {
                                RouteManagement.goToFilterView();
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
                                  height: Dimens.twenty,
                                  width: Dimens.twenty,
                                  colorFilter: const ColorFilter.mode(
                                      Colors.black, BlendMode.srcIn),
                                ),
                              ),
                            ),
                            Dimens.boxWidth10,
                            GestureDetector(
                              onTap: () async {
                                bool? check = await Get.to(SearchView());

                                if (check != null && check == true) {
                                  controller.getDashboardApi();
                                }
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
                                  Assets.iconsHomeSearchIcon,
                                  height: Dimens.twenty,
                                  width: Dimens.twenty,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          bool? check = await Get.to(SearchView());

                          if (check != null && check == true) {
                            controller.getDashboardApi();
                          }
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
                      GestureDetector(
                        onTap: () {
                          RouteManagement.goToFilterView();
                        },
                        child: SvgPicture.asset(
                          Assets.iconsFilter,
                        ),
                      ),
                    ],
                  ),
          ),
          floatingActionButton: GestureDetector(
            onTap: () {
              controller.updateScreen();
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
                    controller.showListView.value
                        ? Assets.iconsMapView
                        : Assets.iconsListView,
                  ),
                  Dimens.boxWidth2,
                  AppText(
                    text: controller.showListView.value
                        ? TranslationKeys.mapView.tr
                        : TranslationKeys.listView.tr,
                    style: AppStyles.ubNavyBlue12W600,
                    maxLines: 1,
                  )
                ],
              ),
            ),
          ),
          body: controller.isGoogleMap.value
              ? GoogleMap(
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(30.7046, 76.7179),
                    zoom: 14.4746,
                  ),
                  markers: controller.markers,
                  onMapCreated: (contro) {
                    controller.onMapCreated(controller: contro);
                  },
                )
              : controller.homeNannyList.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Image.asset(
                            Assets.imagesNoDataPng,
                            scale: 2,
                          ),
                        ),
                      ],
                    )
                  : Padding(
                      padding: Dimens.edgeInsets16,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.homeNannyList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Get.to(
                                () => NannyProfileView(
                                  isComeFromSetting: false,
                                  appBarTitle: TranslationKeys.nannyProfile.tr,
                                ),
                              );
                            },
                            child: HomeCustomListView(
                              // servicesListData: controller,
                              distance:
                                  ((controller.homeNannyList[index].distance)!
                                          .toInt())
                                      .toString(),

                              age: controller.homeNannyList[index].age
                                  .toString(),
                              experience: (controller
                                      .homeNannyList[index].experience
                                      .toString())
                                  .split(' ')
                                  .first,

                              description:
                                  controller.homeNannyList[index].aboutMe,
                              image: controller.homeNannyList[index].image,
                              name: controller.homeNannyList[index].name,
                              rating: controller.homeNannyList[index].rating
                                  .toString(),
                              reviews:
                                  '(${controller.homeNannyList[index].reviewCount} reviews)',
                              // servicesList: controller.homeCustomList,
                              isHeartTapped:
                                  controller.homeNannyList[index].isFavorite!,
                              heartSvg: Assets.iconsHeartOutline,
                              onTapHeartIcon: () {
                                controller.toggleFavouriteAndUnFavouriteApi(
                                    isFavourite: !controller
                                        .homeNannyList[index].isFavorite!,
                                    userId:
                                        controller.homeNannyList[index].id!);
                              },
                              onTapRating: () {
                                Utility.openBottomSheet(
                                  const CustomReviewBottomSheet(
                                    totalReviews: 21,
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
                          );
                        },
                      ),
                    ),
        ),
      );
}
