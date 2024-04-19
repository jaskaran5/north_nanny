import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/customer/home/customer_home_controller.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_text_field.dart';
import 'package:northshore_nanny_flutter/app/widgets/short_detail_of_nanny_profile.dart';
import 'package:northshore_nanny_flutter/navigators/routes_management.dart';

import '../../widgets/app_text.dart';

class SearchView extends StatelessWidget {
  SearchView({super.key});
  final searchTextEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) =>
      Scaffold(body: GetBuilder<CustomerHomeController>(
        builder: (controller) {
          return SafeArea(
            child: Padding(
              padding: Dimens.edgeInsets16,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back(result: true);
                        },
                        child: SvgPicture.asset(Assets.iconsBackArrow),
                      ),
                      Dimens.boxWidth16,

                      //** SEARCH */
                      SizedBox(
                        height: Dimens.forty,
                        width: Dimens.twoHundredEightyOne,
                        child: TextField(
                          controller: searchTextEditingController,
                          onChanged: controller.searchNanny,
                          maxLines: 1,
                          minLines: 1,
                          decoration: customFieldDeco(
                            hintText: '${TranslationKeys.search.tr} ',
                            fillColor: AppColors.searchColor,
                            prefixWidget: Padding(
                              padding: Dimens.edgeInsets12,
                              child: SvgPicture.asset(
                                Assets.iconsSearch,
                                height: Dimens.ten,
                                width: Dimens.ten,
                              ),
                            ),
                            suffix: GestureDetector(
                              onTap: () {
                                searchTextEditingController.clear();
                                controller.searchNanny('');
                              },
                              child: Padding(
                                padding: Dimens.edgeInsets10,
                                child: SvgPicture.asset(
                                  Assets.iconsRemove,
                                ),
                              ),
                            ),
                            hintStyle: AppStyles.ubHintColor12W500,
                          ),
                          cursorColor: AppColors.blackColor,
                          cursorWidth: Dimens.one,
                          style: AppStyles.ubBlack14W600,
                          keyboardType: TextInputType.text,
                        ),
                      ),
                    ],
                  ),
                  Dimens.boxHeight16,
                  controller.homeNannyList.isEmpty
                      ? Expanded(
                          child: Center(
                            child:  AppText(
                              text: TranslationKeys.noResultFound.tr,
                              style: AppStyles.pdNavyBlue20W600,
                            ),
                          ),
                        )
                      :

                      //** SEARCH LIST */
                      Expanded(
                          child: SizedBox(
                            height: 300, // Set a fixed height for the container
                            child: ListView.builder(
                              itemCount: controller.homeNannyList.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    RouteManagement.goToGetNannyProfileView(
                                        argument:
                                            controller.homeNannyList[index].id);
                                  },
                                  child: ShortDetailProfileView(
                                    image:
                                        controller.homeNannyList[index].image,
                                    nannyName:
                                        controller.homeNannyList[index].name,
                                    totalRating:
                                        controller.homeNannyList[index].rating,
                                    totalReviews: controller
                                        .homeNannyList[index].reviewCount,
                                    ratingList: controller
                                            .homeNannyList[index].ratingList ??
                                        [],
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                ],
              ),
            ),
          );
        },
      ));
}
