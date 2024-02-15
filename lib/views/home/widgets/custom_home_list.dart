import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:northshore_nanny_flutter/res/res.dart';
import 'package:northshore_nanny_flutter/widgets/app_text.dart';

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
  });

  final String image;
  final String heartSvg;
  final String name;
  final String rating;
  final String reviews;
  final String description;
  final List<String> servicesList;
  final bool isHeartTapped;

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
                  color: AppColors.lightNavyBlue.withOpacity(.7),
                  blurRadius: Dimens.eight,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                        AppText(
                          text: name,
                          style: AppStyles.ubBlack14W700,
                          maxLines: 1,
                          textAlign: TextAlign.start,
                        ),
                        Dimens.boxHeight4,
                        Row(
                          children: [
                            SvgPicture.asset(Assets.iconsStar),
                            RichText(
                              text: TextSpan(
                                text: rating,
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
                        Dimens.boxHeight4,
                        SizedBox(
                          width: Dimens.oneHundredFifty,
                          child: AppText(
                            text: description,
                            maxLines: 4,
                            style: AppStyles.ubGrey12W400,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                    Dimens.boxWidth16,
                    SvgPicture.asset(
                      heartSvg,
                    ),
                  ],
                ),
                Dimens.boxHeight14,
                SizedBox(
                  height: Dimens.thirty,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: List.generate(
                      servicesList.length,
                      (index) => Container(
                        height: Dimens.twentyFive,
                        padding: Dimens.edgeInsetsL6T10R6B10,
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
