import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/common/favorite_view/favorite_controller.dart';
import 'package:northshore_nanny_flutter/app/modules/customer/home/widgets/custom_home_list.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/utils/utility.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_app_bar.dart';
import 'package:northshore_nanny_flutter/app/widgets/review_custom_bottom_sheet.dart';
import 'package:northshore_nanny_flutter/navigators/routes_management.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) => GetBuilder(
        init: FavoriteController(),
        builder: (controller) => Scaffold(
          appBar: CustomAppbarWidget(
            title: TranslationKeys.favorites.tr,
          ),
          body: controller.favouriteListNanny.isEmpty
              ? Center(
                  child: AppText(
                    text: TranslationKeys.noResultFound.tr,
                    style: AppStyles.pdNavyBlue20W600,
                  ),
                )
              : Padding(
                  padding: Dimens.edgeInsets16,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.favouriteListNanny.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          RouteManagement.goToGetNannyProfileView(
                              argument:
                                  controller.favouriteListNanny[index].nannyId);
                        },
                        child: HomeCustomListView(
                          // servicesListData: controller,
                          distance:
                              ((controller.favouriteListNanny[index].distance)!
                                      .toInt())
                                  .toString(),

                          age: controller.favouriteListNanny[index].age
                              .toString(),
                          experience: (controller
                                  .favouriteListNanny[index].experience
                                  .toString())
                              .split(' ')
                              .first,

                          description:
                              controller.favouriteListNanny[index].aboutMe ??
                                  '',
                          image:
                              controller.favouriteListNanny[index].image ?? '',
                          name: controller.favouriteListNanny[index].name ?? '',
                          rating:
                              controller.favouriteListNanny[index].rating == 0.0
                                  ? '0'
                                  : controller.favouriteListNanny[index].rating
                                      .toString(),
                          reviews:
                              '${controller.favouriteListNanny[index].reviewCount}',
                          // servicesList: controller.homeCustomList,
                          isHeartTapped: true,
                          heartSvg: Assets.iconsHeartOutline,
                          onTapHeartIcon: () {
                            controller.toggleFavouriteAndUnFavouriteApi(
                                userId: controller
                                    .favouriteListNanny[index].nannyId!,
                                isFavourite: !controller
                                    .favouriteListNanny[index].isFavorite);
                          },
                          onTapRating: () {
                            Utility.openBottomSheet(
                              CustomReviewBottomSheet(
                                totalReviews: controller
                                    .favouriteListNanny[index].reviewCount,
                                totalReviewsRating:
                                    controller.favouriteListNanny[index].rating,
                                reviewsList: controller
                                        .favouriteListNanny[index].ratingList ??
                                    [],
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),

          // Padding(
          //   padding: Dimens.edgeInsets16,
          //   child: HomeCustomListView(
          //     age: "20",
          //     distance: "15",
          //     experience: "6",
          //     image: Assets.iconsImage,
          //     name: 'Sudhanshu',
          //     rating: " 4.5",
          //     reviews: "(21 reviews)",
          //     description:
          //         'Dedicated nanny providing loving Care and guidance to littleness. Experienced in nurturing children',
          //     // servicesList: const [
          //     //   'Distance: 10 miles',
          //     //   'Age 23',
          //     //   'Experience 7+'
          //     // ],
          //     isHeartTapped: true,
          //     heartSvg: Assets.iconsHeartFilled,
          //     onTapHeartIcon: () {},
          //   ),
          // ),
        ),
      );
}
