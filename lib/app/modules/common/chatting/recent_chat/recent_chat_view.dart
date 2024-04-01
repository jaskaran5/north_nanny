import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/common/chatting/recent_chat/recent_chat_controller.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_recant_chat_list.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_text_field.dart';
import 'package:skeletonizer/skeletonizer.dart';

class RecentChatView extends GetView<RecentChatController> {
  RecentChatView({super.key}) {
    controller.initMessages();
  }

  @override
  RecentChatController controller =
      Get.put(RecentChatController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: RecentChatController(),
        builder: (RecentChatController control) {
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),

                      controller.isSearchable.value
                          ?
                          //** SEARCH */
                          SizedBox(
                              height: Dimens.forty,
                              width: Dimens.twoHundredEightyOne,
                              child: TextField(
                                controller:
                                    controller.recentChatTextEditingController,
                                onChanged: controller.searchChat,
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
                                      controller.recentChatTextEditingController
                                          .clear();
                                      controller.searchChat('');
                                      controller.toggleSearch();
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
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Messages",
                                    style: AppStyles.pdNormal,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      controller.toggleSearch();
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
                                            color: AppColors.hintColor
                                                .withOpacity(.2),
                                            blurRadius: Dimens.five,
                                          )
                                        ],
                                      ),
                                      child: SvgPicture.asset(
                                        Assets.iconsHomeSearchIcon,
                                        height: Dimens.twenty,
                                        width: Dimens.twenty,
                                        colorFilter: const ColorFilter.mode(
                                            Colors.black, BlendMode.srcIn),
                                      ),
                                    ),
                                  ),
                                  // Container(
                                  //   height: Dimens.forty,
                                  //   width: Dimens.forty,
                                  //   decoration: BoxDecoration(
                                  //       boxShadow: [
                                  //         BoxShadow(
                                  //             color: AppColors.blackColor
                                  //                 .withOpacity(.05),
                                  //             blurRadius: 10.0)
                                  //       ],
                                  //       color: Colors.white,
                                  //       borderRadius:
                                  //           BorderRadius.circular(20)),
                                  //   child: Icon(
                                  //     Icons.search,
                                  //     color: Colors.black,
                                  //     size: Dimens.twentyFive,
                                  //   ),
                                  // )
                                ],
                              ),
                            ),

                      Dimens.boxHeight10,
                      //check
                      Skeletonizer(
                        enabled: controller.isShimmerEnabled.value,
                        child: ListView.builder(
                          itemCount: controller.recentChatList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                controller.redirectToChatScreen(
                                    id: controller.recentChatList[index].userId!
                                        .toString());
                              },
                              child: CustomRecentChatListTile(
                                image: controller.recentChatList[index].image ??
                                    '',
                                chatData: controller.recentChatList[index],
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
