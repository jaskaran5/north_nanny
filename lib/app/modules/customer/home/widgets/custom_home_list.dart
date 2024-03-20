import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_cache_network.dart';

class HomeCustomListView extends StatelessWidget {
  const HomeCustomListView({
    super.key,
    required this.image,
    required this.name,
    required this.rating,
    required this.reviews,
    required this.description,
    required this.isHeartTapped,
    required this.heartSvg,
    required this.onTapHeartIcon,
    required this.distance,
    required this.age,
    required this.experience,
    this.onTapRating,
    this.canClose = false,
    this.onTapClose,
  });

  final String image;
  final String heartSvg;
  final String name;
  final String rating;
  final String reviews;
  final String description;
  final String distance;
  final String age;
  final String experience;
  final bool? canClose;

  final bool isHeartTapped;
  final Function() onTapHeartIcon;
  final Function()? onTapRating;
  final Function()? onTapClose;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimens.oneHundredEightyTwo,
      padding: Dimens.edgeInsets16,
      margin: Dimens.edgeInsetsB16,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(Dimens.ten),
        boxShadow: [
          BoxShadow(
            color: AppColors.lightNavyBlue.withOpacity(.9),
            blurRadius: Dimens.eight,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: Get.width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomCacheNetworkWidget(image: image),
                // Container(
                //   height: Dimens.hundred,
                //   width: Dimens.eightySix,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(Dimens.ten),
                //     image: DecorationImage(
                //         image: NetworkImage(image), fit: BoxFit.cover),
                //   ),
                // ),
                Dimens.boxWidth16,
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: Dimens.oneHundredNinety,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: Get.width * .4,
                            child: AppText(
                              overflow: TextOverflow.ellipsis,
                              text: name,
                              style: AppStyles.ubBlack14W700,
                              maxLines: 1,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          GestureDetector(
                            onTap: onTapHeartIcon,
                            child: SvgPicture.asset(
                              isHeartTapped
                                  ? Assets.iconsHeartFilled
                                  : Assets.iconsHeartOutline,
                            ),
                          ),
                          GestureDetector(
                            onTap: onTapClose,
                            child: Visibility(
                                visible: canClose ?? false,
                                child: SvgPicture.asset(
                                  Assets.iconsCancel,
                                )),
                          )
                        ],
                      ),
                    ),
                    Dimens.boxHeight4,
                    GestureDetector(
                      onTap: onTapRating,
                      child: Row(
                        children: [
                          SvgPicture.asset(Assets.iconsStar),
                          RichText(
                            text: TextSpan(
                              text: ' $rating ',
                              style: AppStyles.ubBlack12W500,
                              children: [
                                TextSpan(
                                  text: reviews,
                                  style: AppStyles.ubGrey12W400,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Dimens.boxHeight4,
                    SizedBox(
                      width: Dimens.oneHundredNinety,
                      child: AppText(
                        text: description,
                        maxLines: 4,
                        style: AppStyles.ubGrey12W400,
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Dimens.boxHeight14,

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /**distance */
              Container(
                height: Dimens.twentyFive,
                padding: Dimens.edgeInsets8_4,
                margin: Dimens.edgeInsetsR16,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.listColor,
                  borderRadius: BorderRadius.circular(Dimens.eight),
                ),
                child: AppText(
                  text: "Distance: $distance miles",
                  style: AppStyles.ubGrey10W400,
                  maxLines: 1,
                ),
              ),
/**age  */
              Container(
                height: Dimens.twentyFive,
                padding: Dimens.edgeInsets8_4,
                margin: Dimens.edgeInsetsR16,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.listColor,
                  borderRadius: BorderRadius.circular(Dimens.eight),
                ),
                child: AppText(
                  text: "Age: $age",
                  style: AppStyles.ubGrey10W400,
                  maxLines: 1,
                ),
              ),

              /**experience  */
              Container(
                height: Dimens.twentyFive,
                padding: Dimens.edgeInsets8_4,
                margin: Dimens.edgeInsetsR16,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.listColor,
                  borderRadius: BorderRadius.circular(Dimens.eight),
                ),
                child: AppText(
                  text: "Experience: $experience yrs",
                  style: AppStyles.ubGrey10W400,
                  maxLines: 1,
                ),
              ),
            ],
          )
          // SizedBox(
          //   height: Dimens.thirty,
          //   child: ListView(
          //     physics: const NeverScrollableScrollPhysics(),
          //     scrollDirection: Axis.horizontal,
          //     children: List.generate(
          //       servicesList.length,
          //       (index) => Container(
          //         height: Dimens.twentyFive,
          //         padding: Dimens.edgeInsetsL12T6R12B6,
          //         margin: Dimens.edgeInsetsR16,
          //         alignment: Alignment.center,
          //         decoration: BoxDecoration(
          //           color: AppColors.listColor,
          //           borderRadius: BorderRadius.circular(Dimens.eight),
          //         ),
          //         child: AppText(
          //           text: servicesList[index].toString(),
          //           style: AppStyles.ubGrey10W400,
          //           maxLines: 1,
          //         ),
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
      // );
      // ),
    );
  }
}
