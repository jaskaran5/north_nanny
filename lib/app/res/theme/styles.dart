import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:northshore_nanny_flutter/app/res/constants/app_constants.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';

class AppStyles {
  const AppStyles._();

  static TextStyle pdNormal = TextStyle(
    fontWeight: FontWeight.normal,
    fontFamily: AppConstants.fontFamilyPlayfairDisplay,
    fontSize: Dimens.twentyFour,
    color: AppColors.blackColor,
  );

  static TextStyle pdSemiBoldBlack24 = TextStyle(
    fontWeight: FontWeight.w600,
    fontFamily: AppConstants.fontFamilyPlayfairDisplay,
    fontSize: Dimens.twentyFour,
    color: AppColors.blackColor,
  );
  static TextStyle pdBlack22W600 = TextStyle(
    fontWeight: FontWeight.w600,
    fontFamily: AppConstants.fontFamilyPlayfairDisplay,
    fontSize: Dimens.twentyTwo,
    color: AppColors.blackColor,
  );
  static TextStyle pdBlack18W600 = TextStyle(
    fontWeight: FontWeight.w600,
    fontFamily: AppConstants.fontFamilyPlayfairDisplay,
    fontSize: Dimens.eighteen,
    color: AppColors.blackColor,
  );
  static TextStyle pdRegularBlack24 = TextStyle(
    fontWeight: FontWeight.w400,
    fontFamily: AppConstants.fontFamilyPlayfairDisplay,
    fontSize: Dimens.twentyFour,
    color: AppColors.blackColor,
  );
  static TextStyle pdMediumBlack24 = TextStyle(
    fontWeight: FontWeight.w500,
    fontFamily: AppConstants.fontFamilyPlayfairDisplay,
    fontSize: Dimens.twentyFour,
    color: AppColors.blackColor,
  );
  static TextStyle pdBoldBlack24 = TextStyle(
    fontWeight: FontWeight.w700,
    fontFamily: AppConstants.fontFamilyPlayfairDisplay,
    fontSize: Dimens.twentyFour,
    color: AppColors.blackColor,
  );
  static TextStyle pdBlackExtraBold24 = TextStyle(
    fontWeight: FontWeight.w800,
    fontFamily: AppConstants.fontFamilyPlayfairDisplay,
    fontSize: Dimens.twentyFour,
    color: AppColors.blackColor,
  );

  static TextStyle ubWhite15700 = TextStyle(
    fontWeight: FontWeight.w700,
    fontFamily: AppConstants.fontFamilyUrbanist,
    color: AppColors.primaryColor,
    fontSize: Dimens.fifteen,
  );
  static TextStyle ubWhite14700 = TextStyle(
    fontWeight: FontWeight.w700,
    fontFamily: AppConstants.fontFamilyUrbanist,
    color: AppColors.primaryColor,
    fontSize: Dimens.fourteen,
  );
  static TextStyle ubBlack15W600 = TextStyle(
    fontWeight: FontWeight.w600,
    fontFamily: AppConstants.fontFamilyUrbanist,
    fontSize: Dimens.fifteen,
    color: AppColors.blackColor,
  );
  static TextStyle ubHintColor15W500 = TextStyle(
    fontWeight: FontWeight.w500,
    fontFamily: AppConstants.fontFamilyUrbanist,
    fontSize: Dimens.fifteen,
    color: AppColors.hintColor,
  );
  static TextStyle ubHintColor20W500 = TextStyle(
    fontWeight: FontWeight.w500,
    fontFamily: AppConstants.fontFamilyUrbanist,
    fontSize: Dimens.twenty,
    color: AppColors.hintColor,
  );
  static TextStyle ubHintColor13W500 = TextStyle(
    fontWeight: FontWeight.w500,
    fontFamily: AppConstants.fontFamilyUrbanist,
    fontSize: Dimens.thirteen,
    color: AppColors.hintColor,
  );
  static TextStyle ubHintColor12W500 = TextStyle(
    fontWeight: FontWeight.w500,
    fontFamily: AppConstants.fontFamilyUrbanist,
    fontSize: Dimens.twelve,
    color: AppColors.hintColor,
  );
  static TextStyle ubGrey16W400 = TextStyle(
    fontWeight: FontWeight.w400,
    fontFamily: AppConstants.fontFamilyUrbanist,
    fontSize: Dimens.sixteen,
    color: AppColors.greyColor,
  );
  static TextStyle ubGrey16W500 = TextStyle(
    fontWeight: FontWeight.w500,
    fontFamily: AppConstants.fontFamilyUrbanist,
    fontSize: Dimens.sixteen,
    color: AppColors.greyColor,
  );
  static TextStyle ubGreyA116W500 = TextStyle(
    fontWeight: FontWeight.w500,
    fontFamily: AppConstants.fontFamilyUrbanist,
    fontSize: Dimens.sixteen,
    color: AppColors.greyA1Color,
  );
  static TextStyle ubGrey14W500 = TextStyle(
    fontWeight: FontWeight.w500,
    fontFamily: AppConstants.fontFamilyUrbanist,
    fontSize: Dimens.fourteen,
    color: AppColors.greyColor,
  );
  static TextStyle ubGrey14W600 = TextStyle(
    fontWeight: FontWeight.w600,
    fontFamily: AppConstants.fontFamilyUrbanist,
    fontSize: Dimens.fourteen,
    color: AppColors.greyColor,
  );
  static TextStyle ubBlack14W500 = TextStyle(
    fontWeight: FontWeight.w500,
    fontFamily: AppConstants.fontFamilyUrbanist,
    fontSize: Dimens.fourteen,
    color: AppColors.blackColor,
  );
  static TextStyle ubBlack12W500 = TextStyle(
    fontWeight: FontWeight.w500,
    fontFamily: AppConstants.fontFamilyUrbanist,
    fontSize: Dimens.twelve,
    color: AppColors.blackColor,
  );
  static TextStyle ubGrey12W400 = TextStyle(
    fontWeight: FontWeight.w400,
    fontFamily: AppConstants.fontFamilyUrbanist,
    fontSize: Dimens.twelve,
    color: AppColors.greyColor,
  );
  static TextStyle ubGrey12W600 = TextStyle(
    fontWeight: FontWeight.w600,
    fontFamily: AppConstants.fontFamilyUrbanist,
    fontSize: Dimens.twelve,
    color: AppColors.greyColor,
  );
  static TextStyle ubGreen12W600 = TextStyle(
    fontWeight: FontWeight.w600,
    fontFamily: AppConstants.fontFamilyUrbanist,
    fontSize: Dimens.twelve,
    color: AppColors.greenColor,
  );
  static TextStyle ubGrey10W400 = TextStyle(
    fontWeight: FontWeight.w400,
    fontFamily: AppConstants.fontFamilyUrbanist,
    fontSize: Dimens.ten,
    color: AppColors.greyColor,
  );
  static TextStyle ubBlack14W400 = TextStyle(
    fontWeight: FontWeight.w400,
    fontFamily: AppConstants.fontFamilyUrbanist,
    fontSize: Dimens.fourteen,
    color: AppColors.blackColor,
  );
  static TextStyle ubLocationColor14W400 = TextStyle(
    fontWeight: FontWeight.w400,
    fontFamily: AppConstants.fontFamilyUrbanist,
    fontSize: Dimens.fourteen,
    color: AppColors.locationColor,
  );
  static TextStyle ubBlack14W600 = TextStyle(
    fontWeight: FontWeight.w600,
    fontFamily: AppConstants.fontFamilyUrbanist,
    fontSize: Dimens.fourteen,
    color: AppColors.blackColor,
  );
  static TextStyle ubBlack14W700 = TextStyle(
    fontWeight: FontWeight.w700,
    fontFamily: AppConstants.fontFamilyUrbanist,
    fontSize: Dimens.fourteen,
    color: AppColors.blackColor,
  );
  static TextStyle ubBlack24W700 = TextStyle(
    fontWeight: FontWeight.w700,
    fontFamily: AppConstants.fontFamilyUrbanist,
    fontSize: Dimens.twentyFour,
    color: AppColors.blackColor,
  );
  static TextStyle ubBlack16W600 = TextStyle(
    fontWeight: FontWeight.w600,
    fontFamily: AppConstants.fontFamilyUrbanist,
    fontSize: Dimens.sixteen,
    color: AppColors.blackColor,
  );
  static TextStyle ubBlack16W700 = TextStyle(
    fontWeight: FontWeight.w700,
    fontFamily: AppConstants.fontFamilyUrbanist,
    fontSize: Dimens.sixteen,
    color: AppColors.blackColor,
  );
  static TextStyle ubBlack18W600 = TextStyle(
    fontWeight: FontWeight.w600,
    fontFamily: AppConstants.fontFamilyUrbanist,
    fontSize: Dimens.eighteen,
    color: AppColors.blackColor,
  );
  static TextStyle ubBlack30W600 = TextStyle(
    fontWeight: FontWeight.w600,
    fontFamily: AppConstants.fontFamilyUrbanist,
    fontSize: Dimens.thirty,
    color: AppColors.blackColor,
  );
  static TextStyle ubDarkBlackColor26W700 = TextStyle(
    fontWeight: FontWeight.w700,
    fontFamily: AppConstants.fontFamilyUrbanist,
    fontSize: Dimens.twentySix,
    color: AppColors.darkBlackColor,
  );
  static TextStyle ubDarkBlackColor24W700 = TextStyle(
    fontWeight: FontWeight.w700,
    fontFamily: AppConstants.fontFamilyUrbanist,
    fontSize: Dimens.twentyFour,
    color: AppColors.darkBlackColor,
  );
  static TextStyle ubGrey15W500 = TextStyle(
    fontWeight: FontWeight.w500,
    fontFamily: AppConstants.fontFamilyUrbanist,
    fontSize: Dimens.fifteen,
    color: AppColors.greyColor,
  );
  static TextStyle ubNavyBlue14W700 = TextStyle(
    fontWeight: FontWeight.w700,
    fontFamily: AppConstants.fontFamilyUrbanist,
    fontSize: Dimens.fourteen,
    color: AppColors.navyBlue,
  );
  static TextStyle ubNavyBlue14W600 = TextStyle(
    fontWeight: FontWeight.w600,
    fontFamily: AppConstants.fontFamilyUrbanist,
    fontSize: Dimens.fourteen,
    color: AppColors.navyBlue,
  );
  static TextStyle ubNavyBlue14W400 = TextStyle(
    fontWeight: FontWeight.w400,
    fontFamily: AppConstants.fontFamilyUrbanist,
    fontSize: Dimens.fourteen,
    color: AppColors.navyBlue,
  );
  static TextStyle pdNavyBlue20W600 = TextStyle(
    fontWeight: FontWeight.w600,
    fontFamily: AppConstants.fontFamilyPlayfairDisplay,
    fontSize: Dimens.twenty,
    color: AppColors.navyBlue,
  );
  static TextStyle ubNavyBlue12W600 = TextStyle(
    fontWeight: FontWeight.w600,
    fontFamily: AppConstants.fontFamilyUrbanist,
    fontSize: Dimens.twelve,
    color: AppColors.navyBlue,
  );
  static TextStyle ubNavyBlue12W500 = TextStyle(
    fontWeight: FontWeight.w500,
    fontFamily: AppConstants.fontFamilyUrbanist,
    fontSize: Dimens.twelve,
    color: AppColors.navyBlue,
  );
  static TextStyle ubHintColor14W600 = TextStyle(
    fontWeight: FontWeight.w600,
    fontFamily: AppConstants.fontFamilyUrbanist,
    fontSize: Dimens.fourteen,
    color: AppColors.hintColor,
  );
  static TextStyle ubNavyBlue15W700 = TextStyle(
    fontWeight: FontWeight.w700,
    fontFamily: AppConstants.fontFamilyUrbanist,
    fontSize: Dimens.fifteen,
    color: AppColors.navyBlue,
  );
  static TextStyle ubNavyBlue15W600 = TextStyle(
    fontWeight: FontWeight.w600,
    fontFamily: AppConstants.fontFamilyUrbanist,
    fontSize: Dimens.fifteen,
    color: AppColors.navyBlue,
  );
  static TextStyle ubNavyBlue20W600 = TextStyle(
    fontWeight: FontWeight.w600,
    fontFamily: AppConstants.fontFamilyUrbanist,
    fontSize: Dimens.twenty,
    color: AppColors.navyBlue,
  );
  static TextStyle ubNavyBlue16W700 = TextStyle(
    fontWeight: FontWeight.w700,
    fontFamily: AppConstants.fontFamilyUrbanist,
    fontSize: Dimens.sixteen,
    color: AppColors.navyBlue,
  );
  static TextStyle navyBlue15UbW600 = TextStyle(
    fontWeight: FontWeight.w600,
    fontFamily: AppConstants.fontFamilyUrbanist,
    fontSize: Dimens.fifteen,
    color: AppColors.navyBlue,
  );

  static TextStyle navyBlueUrbanist14 = TextStyle(
    fontWeight: FontWeight.normal,
    fontFamily: AppConstants.fontFamilyUrbanist,
    fontSize: Dimens.fourteen,
    color: Colors.black,
  );

  static TextStyle B0B0BUrbanist15 = TextStyle(
    fontWeight: FontWeight.w600,
    fontFamily: AppConstants.fontFamilyUrbanist,
    fontSize: Dimens.fifteen,
    color: HexColor("#0B0B0B"),
  );

  static TextStyle B0B0BUrbanist15White = TextStyle(
    fontWeight: FontWeight.w600,
    fontFamily: AppConstants.fontFamilyUrbanist,
    fontSize: Dimens.fifteen,
    color: HexColor("#FFFFFF"),
  );
  static TextStyle B0B0BUrbanist14 = TextStyle(
    fontWeight: FontWeight.w600,
    fontFamily: AppConstants.fontFamilyUrbanist,
    fontSize: Dimens.fourteen,
    color: HexColor("#0B0B0B"),
  );

  static TextStyle E5F60Urbanist12 = TextStyle(
    fontWeight: FontWeight.w500,
    fontFamily: AppConstants.fontFamilyUrbanist,
    fontSize: Dimens.twelve,
    color: HexColor("#5E5F60"),
  );

  static TextStyle E8F94AEUrbanist15 = TextStyle(
    fontWeight: FontWeight.w500,
    fontFamily: AppConstants.fontFamilyUrbanist,
    fontSize: Dimens.fifteen,
    color: HexColor("#8F94AE"),
  );

  static TextStyle B0B0BPlayfair24 = TextStyle(
    fontWeight: FontWeight.w600,
    fontFamily: AppConstants.fontFamilyPlayfairDisplay,
    fontSize: Dimens.twentyFour,
    color: HexColor("#0B0B0B"),
  );
}
