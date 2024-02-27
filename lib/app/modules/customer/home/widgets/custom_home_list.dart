import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';

class HomeCustomListView extends StatelessWidget {
  const HomeCustomListView({
    super.key,
    required this.image,
    required this.name,
    required this.rating,
    required this.reviews,
    required this.description,
    required this.servicesList,
    required this.isHeartTapped,
    required this.heartSvg,
    required this.onTapHeartIcon,
    this.onTapRating,
  });

  final String image;
  final String heartSvg;
  final String name;
  final String rating;
  final String reviews;
  final String description;
  final List<String> servicesList;
  final bool isHeartTapped;
  final Function() onTapHeartIcon;
  final Function()? onTapRating;

  @override
  Widget build(BuildContext context) => ListView(
        children: List.generate(
          3,
          (index) => Container(
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
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: Dimens.hundred,
                      width: Dimens.eightySix,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimens.ten),
                      ),
                      child: Image.asset(
                        image,
                        fit: BoxFit.contain,
                      ),
                    ),
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
                              AppText(
                                text: name,
                                style: AppStyles.ubBlack14W700,
                                maxLines: 1,
                                textAlign: TextAlign.start,
                              ),
                              GestureDetector(
                                onTap: onTapHeartIcon,
                                child: SvgPicture.asset(
                                  isHeartTapped
                                      ? Assets.iconsHeartFilled
                                      : Assets.iconsHeartOutline,
                                ),
                              ),
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
                                  text: '$rating ',
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
                Dimens.boxHeight14,
                SizedBox(
                  height: Dimens.thirty,
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: List.generate(
                      servicesList.length,
                      (index) => Container(
                        height: Dimens.twentyFive,
                        padding: Dimens.edgeInsetsL12T6R12B6,
                        margin: Dimens.edgeInsetsR16,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.listColor,
                          borderRadius: BorderRadius.circular(Dimens.eight),
                        ),
                        child: AppText(
                          text: servicesList[index].toString(),
                          style: AppStyles.ubGrey10W400,
                          maxLines: 1,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
}
