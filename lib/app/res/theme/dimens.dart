import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Dimens {
  const Dimens._();

  /// Get the height with the percent value of the screen height.
  static double percentHeight(double percentValue) => percentValue.sh;

  /// Get the width with the percent value of the screen width.
  static double percentWidth(double percentValue) => percentValue.sw;

  static final double zero = 0.sp;
  static final double one = 1.sp;
  static final double two = 2.sp;
  static final double three = 3.sp;
  static final double four = 4.sp;
  static final double five = 5.sp;
  static final double six = 6.sp;
  static final double seven = 7.sp;

  static final double eight = 8.sp;
  static final double nine = 9.sp;
  static final double ten = 10.sp;
  static final double twelve = 12.sp;
  static final double thirteen = 13.sp;
  static final double fourteen = 14.sp;

  static final double fifteen = 15.sp;
  static final double sixteen = 16.sp;
  static final double nineteen = 19.sp;
  static final double eighteen = 18.sp;
  static final double twenty = 20.sp;
  static final double twentyTwo = 22.sp;
  static final double twentyThree = 23.sp;
  static final double twentyFour = 24.sp;
  static final double twentyFive = 25.sp;
  static final double twentySix = 26.sp;
  static final double twentyEight = 28.sp;

  static final double thirty = 30.sp;
  static final double thirtyTwo = 32.sp;
  static final double thirtyFour = 34.sp;
  static final double thirtyFive = 35.sp;
  static final double thirtyEight = 38.sp;

  static final double forty = 40.sp;
  static final double fortyOne = 41.sp;
  static final double fortySix = 46.sp;
  static final double fifty = 50.sp;
  static final double fiftyThree = 53.sp;
  static final double fiftyFive = 55.sp;
  static final double sixty = 60.sp;
  static final double sixtyFour = 64.sp;
  static final double sixtyEight = 68.sp;
  static final double seventy = 70.sp;
  static final double seventyEight = 78.sp;

  static final double eighty = 80.sp;
  static final double eightyThree = 83.sp;
  static final double eightySix = 86.sp;
  static final double ninety = 90.sp;
  static final double ninetyFour = 94.sp;

  static final double hundred = 100.sp;
  static final double hundredTwo = 102.sp;
  static final double hundredFive = 105.sp;
  static final double hundredEight = 108.sp;
  static final double hundredTen = 110.sp;
  static final double hundredFourteen = 114.sp;
  static final double oneHundredTwenty = 120.sp;
  static final double oneHundredTwentySeven = 127.sp;
  static final double hundredForty = 140.sp;
  static final double hundredFortyFive = 145.sp;
  static final double oneHundredFifty = 150.sp;
  static final double oneHundredSeventy = 170.sp;
  static final double oneHundredEightyTwo = 182.sp;
  static final double oneHundredNinety = 190.sp;
  static final double twoHundred = 200.sp;
  static final double twoHundredThirteen = 213.sp;
  static final double twoHundredTwenty = 220.sp;
  static final double twoHundredFifty = 250.sp;
  static final double twoHundredSeventy = 270.sp;
  static final double twoHundredEightyOne = 281.sp;
  static final double twoHundredNinety = 290.sp;
  static final double threeHundredThirtyOne = 331.sp;
  static final double threeHundredThirtyFive = 335.sp;
  static final double threeHundredFortyOne = 341.sp;
  static final double fourHundredEighty = 480.sp;
  static final double fiveHundred = 500.sp;

  static final Widget box0 = SizedBox(height: zero);

  static final Widget boxHeight2 = SizedBox(height: two);
  static final Widget boxHeight4 = SizedBox(height: four);
  static final Widget boxHeight5 = SizedBox(height: five);
  static final Widget boxHeight8 = SizedBox(height: eight);
  static final Widget boxHeight10 = SizedBox(height: ten);
  static final Widget boxHeight14 = SizedBox(height: fourteen);

  static final Widget boxHeight16 = SizedBox(height: sixteen);
  static final Widget boxHeight20 = SizedBox(height: twenty);
  static final Widget boxHeight24 = SizedBox(height: twentyFour);
  static final Widget boxHeight26 = SizedBox(height: twentySix);
  static final Widget boxHeight32 = SizedBox(height: thirtyTwo);
  static final Widget boxHeight50 = SizedBox(height: fifty);
  static final Widget boxHeight70 = SizedBox(height: seventy);
  static final Widget boxHeight100 = SizedBox(height: hundred);

  static final Widget boxWidth2 = SizedBox(width: two);
  static final Widget boxWidth4 = SizedBox(width: four);
  static final Widget boxWidth8 = SizedBox(width: eight);
  static final Widget boxWidth10 = SizedBox(width: ten);
  static final Widget boxWidth12 = SizedBox(width: twelve);
  static final Widget boxWidth16 = SizedBox(width: sixteen);
  static final Widget boxWidth20 = SizedBox(width: twenty);
  static final Widget boxWidth24 = SizedBox(width: twentyFour);
  static final Widget boxWidth32 = SizedBox(width: thirtyTwo);
  static final Widget boxWidth55 = SizedBox(width: fiftyFive);

  static const EdgeInsets edgeInsets0 = EdgeInsets.zero;
  static final EdgeInsets edgeInsets2 = EdgeInsets.all(two);
  static final EdgeInsets edgeInsets4 = EdgeInsets.all(four);
  static final EdgeInsets edgeInsets5 = EdgeInsets.all(five);
  static final EdgeInsets edgeInsets6 = EdgeInsets.all(six);
  static final EdgeInsets edgeInsets8 = EdgeInsets.all(eight);
  static final EdgeInsets edgeInsets10 = EdgeInsets.all(ten);
  static final EdgeInsets edgeInsets12 = EdgeInsets.all(twelve);
  static final EdgeInsets edgeInsets16 = EdgeInsets.all(sixteen);

  static final EdgeInsets edgeInsetsL2 = EdgeInsets.only(left: two);
  static final EdgeInsets edgeInsetsT10 = EdgeInsets.only(top: ten);
  static final EdgeInsets edgeInsetsT5 = EdgeInsets.only(top: five);
  static final EdgeInsets edgeInsetsB10 = EdgeInsets.only(bottom: ten);
  static final EdgeInsets edgeInsetsB16 = EdgeInsets.only(bottom: sixteen);
  static final EdgeInsets edgeInsetsT16B16 =
      EdgeInsets.only(top: sixteen, bottom: sixteen);
  static final EdgeInsets edgeInsetsB55 = EdgeInsets.only(bottom: fiftyFive);

  static final EdgeInsets edgeInsetsL4 = EdgeInsets.only(left: four);
  static final EdgeInsets edgeInsetsL6 = EdgeInsets.only(left: six);
  static final EdgeInsets edgeInsetsL12T6R12B6 =
      EdgeInsets.only(left: twelve, top: six, right: twelve, bottom: six);
  static final EdgeInsets edgeInsetsL10T10R16B10 =
      EdgeInsets.only(left: ten, top: ten, right: sixteen, bottom: ten);
  static final EdgeInsets edgeInsetsT16R16 =
      EdgeInsets.only(top: sixteen, right: sixteen);
  static final EdgeInsets edgeInsetsL15 = EdgeInsets.only(
    left: fifteen,
  );
  static final EdgeInsets edgeInsetsL16R16 = EdgeInsets.only(
    left: sixteen,
    right: sixteen,
  );
  static final EdgeInsets edgeInsetsL10R10 = EdgeInsets.only(
    left: ten,
    right: ten,
  );
  static final EdgeInsets edgeInsetsL16R16B16 = EdgeInsets.only(
    left: fifteen,
    right: sixteen,
    bottom: sixteen,
  );
  static final EdgeInsets edgeInsetsL16R16B20 = EdgeInsets.only(
    left: fifteen,
    right: sixteen,
    bottom: twentyFive,
  );
  static final EdgeInsets edgeInsetsR4 = EdgeInsets.only(right: four);
  static final EdgeInsets edgeInsetsR8 = EdgeInsets.only(right: eight);
  static final EdgeInsets edgeInsetsR16 = EdgeInsets.only(right: sixteen);

  static final EdgeInsets edgeInsets2_0 = EdgeInsets.symmetric(horizontal: two);
  static final EdgeInsets edgeInsets4_0 =
      EdgeInsets.symmetric(horizontal: four);
  static final EdgeInsets edgeInsets8_0 =
      EdgeInsets.symmetric(horizontal: eight);
  static EdgeInsets edgeInsets10_0 = EdgeInsets.symmetric(horizontal: ten);
  static EdgeInsets edgeInsetsH20V15 =
      EdgeInsets.symmetric(horizontal: twenty, vertical: fifteen);

  static final EdgeInsets edgeInsets0_4 = EdgeInsets.symmetric(vertical: four);
  static final EdgeInsets edgeInsets0_8 = EdgeInsets.symmetric(vertical: eight);

  static final EdgeInsets edgeInsets4_8 =
      EdgeInsets.symmetric(horizontal: four, vertical: eight);
  static final EdgeInsets edgeInsets8_4 =
      EdgeInsets.symmetric(horizontal: eight, vertical: four);
}
