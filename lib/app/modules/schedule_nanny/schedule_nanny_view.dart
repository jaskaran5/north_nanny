import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';
import 'package:northshore_nanny_flutter/app/res/constants/enums.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_app_bar.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_button.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../navigators/routes_management.dart';
import '../../res/theme/colors.dart';
import '../../res/theme/styles.dart';
import '../../widgets/app_text.dart';
import '../../widgets/custom_booking_receipt_tile.dart';
import '../../widgets/custom_drop_down.dart';

class ScheduleNannyView extends StatelessWidget {
  const ScheduleNannyView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: CustomAppbarWidget(
          title: TranslationKeys.scheduleNanny.tr,
        ),
        body: Padding(
          padding: Dimens.edgeInsets16,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(Dimens.eight),
                    border: Border.all(
                      color: AppColors.dividerColor,
                      width: Dimens.one,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.lightNavyBlue.withOpacity(.8),
                        blurRadius: Dimens.five,
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: Dimens.edgeInsetsL10R10,
                        child: TableCalendar(
                          sixWeekMonthsEnforced: true,
                          startingDayOfWeek: StartingDayOfWeek.monday,
                          daysOfWeekStyle: DaysOfWeekStyle(
                            weekdayStyle: AppStyles.ubHintColor13W500,
                            weekendStyle: AppStyles.ubHintColor13W500,
                          ),
                          calendarStyle: CalendarStyle(
                            defaultTextStyle: AppStyles.ubBlack15W600,
                            weekendTextStyle: AppStyles.ubBlack15W600,
                            outsideTextStyle: AppStyles.ubHintColor15W500,
                            todayDecoration: const BoxDecoration(
                              color: AppColors.navyBlue,
                              shape: BoxShape.circle,
                            ),
                            todayTextStyle: AppStyles.ubWhite15700,
                            selectedTextStyle: AppStyles.ubWhite15700,
                            selectedDecoration: const BoxDecoration(
                              color: AppColors.navyBlue,
                              shape: BoxShape.circle,
                            ),
                            markersMaxCount: 1,
                          ),
                          firstDay: DateTime.now(),
                          lastDay: DateTime.utc(
                            2050,
                          ),
                          headerStyle: HeaderStyle(
                            titleTextStyle: AppStyles.ubBlack18W600,
                            formatButtonVisible: false,
                            titleCentered: true,
                            leftChevronIcon: SvgPicture.asset(Assets.iconsLeft),
                            rightChevronIcon:
                                SvgPicture.asset(Assets.iconsRight),
                          ),
                          onDaySelected: (selectedDay, focusedDay) {},
                          focusedDay: DateTime.now(),
                        ),
                      ),
                      Divider(
                        color: AppColors.dividerColor,
                        height: Dimens.one,
                      ),
                      Padding(
                        padding: Dimens.edgeInsets16,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              text: '03',
                              style: AppStyles.ubBlack30W600,
                              maxLines: 1,
                              textAlign: TextAlign.start,
                            ),
                            Dimens.boxWidth16,
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  text: 'Februaery 2024 Friday',
                                  style: AppStyles.ubGrey12W400,
                                  maxLines: 1,
                                  textAlign: TextAlign.start,
                                ),
                                Dimens.boxHeight8,
                                AppText(
                                  text: '10:00 Am to 05:00 PM',
                                  style: AppStyles.ubBlack14W700,
                                  maxLines: 1,
                                  textAlign: TextAlign.start,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: AppColors.dividerColor,
                        height: Dimens.one,
                      ),
                      Padding(
                        padding: Dimens.edgeInsets16,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(Assets.iconsInfoGreen),
                            Dimens.boxWidth10,
                            Flexible(
                              child: AppText(
                                text:
                                    'This nanny is available from 10:00 AM to 12:00 PM and 02:00 PM to 05:00 PM',
                                maxLines: 2,
                                style: AppStyles.ubGreen12W600,
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Dimens.boxHeight16,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: Dimens.fiftyThree,
                      width: Dimens.oneHundredFifty,
                      padding: Dimens.edgeInsets8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          Dimens.eight,
                        ),
                        border: Border.all(
                          color: AppColors.lightNavyBlue,
                          width: Dimens.one,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            Assets.iconsClock,
                            height: Dimens.twenty,
                            width: Dimens.twenty,
                          ),
                          Dimens.boxWidth10,
                          AppText(
                            text: '01:00 PM',
                            style: AppStyles.ubBlack15W600,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: Dimens.fiftyThree,
                      width: Dimens.oneHundredFifty,
                      padding: Dimens.edgeInsets8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          Dimens.eight,
                        ),
                        border: Border.all(
                          color: AppColors.lightNavyBlue,
                          width: Dimens.one,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            Assets.iconsClock,
                            height: Dimens.twenty,
                            width: Dimens.twenty,
                          ),
                          Dimens.boxWidth10,
                          AppText(
                            text: '05:00 PM',
                            style: AppStyles.ubBlack15W600,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Dimens.boxHeight8,
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      Assets.iconsInfoGreyCircle,
                    ),
                    Dimens.boxWidth8,
                    Flexible(
                        child: AppText(
                      text: 'The nanny is available from 12:00 PM to 5:00 PM',
                      maxLines: 1,
                      style: AppStyles.ubHintColor12W500,
                    ))
                  ],
                ),
                Dimens.boxHeight16,
                AppDropdown(
                  selectedItem: '${TranslationKeys.typeOfServices.tr} ',
                  itemBuilderPhysics: const ScrollPhysics(),
                  onChanged: (value) {},
                  maxHeight: Dimens.twoHundredSeventy,
                  baseTextStyle: AppStyles.ubHintColor15W500,
                  prefix: SvgPicture.asset(Assets.iconsBrifecaseCross),
                  items: [
                    Services.homeWorkHelp.name,
                    Services.driving.name,
                    Services.petCare.name,
                    Services.homeWorkHelp.name,
                    Services.funActivityOutHouse.name,
                  ],
                  itemBuilder: (context, item, isSelected) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: Dimens.edgeInsetsH20V15,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppText(
                                text: item.toString().tr,
                                maxLines: 1,
                                textAlign: TextAlign.start,
                                style: AppStyles.ubNavyBlue15W600,
                              ),
                              // item == controller.selectedGender
                              SvgPicture.asset(Assets.iconsCircleTick)
                              //     : Dimens.box0,
                            ],
                          ),
                        ),
                        // item != controller.genderList.last
                        //     ? Dimens.boxHeight2
                        //     : Dimens.box0,
                        // item != controller.genderList.last
                        //     ?
                        Divider(
                          color: AppColors.dividerColor,
                          height: Dimens.two,
                        )
                        // : Dimens.box0,
                      ],
                    );
                  },
                ),
                Dimens.boxHeight16,
                AppDropdown(
                  selectedItem: '${TranslationKeys.selectChildren.tr} ',
                  onChanged: (value) {},
                  baseTextStyle: AppStyles.ubHintColor15W500,
                  prefix: SvgPicture.asset(Assets.iconsBabyBoy),
                  items: const [
                    'Select all',
                    'Alexander',
                    'Oliver',
                    'add',
                  ],
                  itemBuilderPhysics: const ScrollPhysics(),
                  maxHeight: Dimens.twoHundred,
                  itemBuilder: (context, item, isSelected) {
                    return Visibility(
                      visible: item != "add",
                      replacement: Padding(
                        padding: Dimens.edgeInsets16,
                        child: Center(
                          child: AppText(
                            text: '+ Add kids',
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            style: AppStyles.ubNavyBlue15W600,
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: Dimens.edgeInsetsH20V15,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppText(
                                  text: item.toString().tr,
                                  maxLines: 1,
                                  textAlign: TextAlign.start,
                                  style: AppStyles.ubNavyBlue15W600,
                                ),
                                // item == controller.selectedGender
                                SvgPicture.asset(Assets.iconsCircleTick)
                                //     : Dimens.box0,
                              ],
                            ),
                          ),
                          // item != controller.genderList.last
                          //     ? Dimens.boxHeight2
                          //     : Dimens.box0,
                          // item != controller.genderList.last
                          //     ?
                          Divider(
                            color: AppColors.dividerColor,
                            height: Dimens.two,
                          )
                          // : Dimens.box0,
                        ],
                      ),
                    );
                  },
                ),
                Dimens.boxHeight16,
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(Dimens.eight),
                    border: Border.all(
                      color: AppColors.dividerColor,
                      width: Dimens.one,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.lightNavyBlue.withOpacity(.8),
                        blurRadius: Dimens.five,
                      )
                    ],
                  ),
                  child: const CustomBookingReceiptTile(
                    receiptHeader: 'Receipt',
                    receiptDetailsList: [
                      'Housekeeping',
                      'Driving',
                      '2 children',
                      'Total Time: 4 Hours',
                    ],
                    shoBorder: false,
                    showHeader: false,
                    totalPriceReceived: 112,
                    receiptPricesList: [
                      10,
                      10,
                      23,
                      92,
                    ],
                  ),
                ),
                Dimens.boxHeight16,
                CustomButton(
                  title: TranslationKeys.confirmBooking.tr,
                  backGroundColor: AppColors.navyBlue,
                  onTap: () {
                    RouteManagement.goToAddPaymentMethodScreen(
                      isComeFromNannyProfile: true,
                      buttonText: TranslationKeys.submit.tr,
                      onTapButton: () {
                        RouteManagement.goToSuccessView(
                          buttonText: TranslationKeys.backToHome.tr,
                          successSvg: Assets.iconsSuccess,
                          header: TranslationKeys.nannyRequested.tr,
                          headerStyle: AppStyles.ubDarkBlackColor24W700,
                          subHeader: TranslationKeys.notificationNannyAccept.tr,
                          onTapButton: () {
                            RouteManagement.goToOffAllDashboard(
                                isFromSetting: false);
                          },
                          subTitleStyle: AppStyles.ubGrey16W500,
                          subHeaderMaxLines: 2,
                          headerMaxLines: 2,
                          successImage: '',
                          sendTipText: false,
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );
}
