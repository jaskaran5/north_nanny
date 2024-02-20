import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/schedule_nanny/schedule_nanny_view.dart';
import 'package:northshore_nanny_flutter/app/res/constants/constants.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_app_bar.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_button.dart';
import 'package:northshore_nanny_flutter/app/widgets/houry_rate_view.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../widgets/custom_bottom_sheet.dart';

class NannyProfileView extends StatelessWidget {
  NannyProfileView({super.key});
  List<String> homeCustomList = [
    'Distance: 3 miles',
    'Age: 40',
    'Experience: 7+ yrs',
    'Experience: 7+ yrs',
  ];
  int selectedIndex = 0;

  DateTime selectedDate = DateTime.now();

  List<String>? priceList = [
    '\$ 10',
    '\$ 10',
    '\$ 10',
    '\$ 10',
    '\$ 10',
    '',
  ];
  bool isFavorite = false;

  List<String> profileTabList = [
    TranslationKeys.about.tr,
    TranslationKeys.services.tr,
    TranslationKeys.availability.tr
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: CustomAppbarWidget(
          title: TranslationKeys.nannyProfile.tr,
          centerTitle: true,
          actions: [
            GestureDetector(
              onTap: () {
                isFavorite = !isFavorite;
              },
              child: Padding(
                padding: Dimens.edgeInsetsL16R16,
                child: SvgPicture.asset(isFavorite
                    ? Assets.iconsHeartFilled
                    : Assets.iconsHeartOutline),
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.profileBackgroundColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: Dimens.edgeInsetsB16,
            child: Column(
              children: [
                profileView(
                  nannyName: 'Christina Wang',
                  servicesList: homeCustomList,
                  totalRating: 4.5,
                  totalReview: 12,
                ),
                Dimens.boxHeight20,
                Container(
                  margin: Dimens.edgeInsetsL16R16,
                  height: Dimens.fifty,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(Dimens.ten),
                  ),
                  child: Row(
                    children: List.generate(
                      profileTabList.length,
                      (index) => GestureDetector(
                        onTap: () {
                          selectedIndex = index;
                        },
                        child: Container(
                          height: Dimens.forty,
                          width: Dimens.hundredEight,
                          // padding: Dimens.edgeInsets8,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: selectedIndex == index
                                ? AppColors.navyBlue
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(Dimens.eight),
                          ),
                          child: AppText(
                            text: profileTabList[index].tr,
                            style: selectedIndex == index
                                ? AppStyles.ubWhite14700
                                : AppStyles.ubGrey14W600,
                            maxLines: 1,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Dimens.boxHeight20,
                selectedIndex == 0
                    ? aboutView()
                    : selectedIndex == 1
                        ? servicesView(rateList: priceList)
                        : availabilityView(selectedDate: selectedDate),
              ],
            ),
          ),
        ),
      );
}

Widget aboutView() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: Dimens.edgeInsetsL16R16,
          padding: Dimens.edgeInsets16,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(Dimens.ten),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: TranslationKeys.about.tr,
                style: AppStyles.ubBlack14W700,
                maxLines: 1,
                textAlign: TextAlign.start,
              ),
              Dimens.boxHeight16,
              AppText(
                text:
                    'Dedicated nanny providing loving Care and guidance to littleness. Experienced in nurturing children\'s development and ensuring a safe, happy environment.',
                style: AppStyles.ubGrey12W400,
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
        Dimens.boxHeight20,
        Padding(
          padding: Dimens.edgeInsetsL16R16,
          child: HourlyRateView(
            showShadow: false,
            borderRadius: Dimens.ten,
          ),
        ),
      ],
    );

Widget profileView({
  List<String>? servicesList,
  String? nannyName,
  double? totalRating,
  int? totalReview,
}) =>
    Container(
      color: AppColors.primaryColor,
      width: Get.width,
      padding: Dimens.edgeInsets16,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: Dimens.ninty,
            width: Dimens.ninty,
            padding: Dimens.edgeInsets2,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.activeBorderColor,
                width: Dimens.one,
              ),
              shape: BoxShape.circle,
            ),
            child: CircleAvatar(
              radius: Dimens.hundred,
              backgroundImage: const AssetImage(
                Assets.iconsImage,
              ),
            ),
          ),
          Dimens.boxHeight8,
          AppText(
            text: nannyName.toString(),
            style: AppStyles.ubBlack16W700,
            maxLines: 1,
            textAlign: TextAlign.center,
          ),
          Dimens.boxHeight8,
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(Assets.iconsStar),
              Dimens.boxWidth4,
              RichText(
                text: TextSpan(
                  text: totalRating.toString(),
                  style: AppStyles.ubBlack12W500,
                  children: [
                    TextSpan(
                      text:
                          '(${totalReview.toString()} ${TranslationKeys.reviews.tr})',
                      style: AppStyles.ubGrey12W400,
                    )
                  ],
                ),
                maxLines: 1,
              ),
            ],
          ),
          Dimens.boxHeight8,
          Container(
            height: Dimens.thirty,
            margin: Dimens.edgeInsetsL16R16,
            alignment: Alignment.center,
            child: ListView(
              padding: Dimens.edgeInsetsL15,
              scrollDirection: Axis.horizontal,
              children: List.generate(
                servicesList?.length ?? 0,
                (index) => Container(
                  height: Dimens.twentyEight,
                  padding: Dimens.edgeInsets6,
                  margin: Dimens.edgeInsetsR16,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.listColor,
                    borderRadius: BorderRadius.circular(Dimens.eight),
                  ),
                  child: AppText(
                    text: servicesList?[index].toString(),
                    style: AppStyles.ubGrey12W400,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

Widget servicesView({List<String>? rateList}) => Padding(
      padding: Dimens.edgeInsetsL16R16,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          Services.values.length,
          (index) => SizedBox(
            height: Dimens.seventy,
            child: Card(
              color: Colors.white,
              margin: Dimens.edgeInsetsB10,
              shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimens.ten),
                borderSide: const BorderSide(
                  color: AppColors.primaryColor,
                  width: 1.5,
                ),
              ),
              elevation: 0.5,
              shadowColor: AppColors.lightNavyBlue.withOpacity(.8),
              child: Padding(
                padding: Dimens.edgeInsets10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: Dimens.thirtyFive,
                          width: Dimens.thirtyFive,
                          padding: Dimens.edgeInsets10,
                          decoration: BoxDecoration(
                            color: AppColors.lightNavyBlue,
                            borderRadius: BorderRadius.circular(
                              Dimens.eight,
                            ),
                          ),
                          child: SvgPicture.asset(
                            Services.values[index].servicesSvg,
                          ),
                        ),
                        Dimens.boxWidth10,
                        AppText(
                          text: Services.values[index].serviceName.tr,
                          style: AppStyles.ubBlack14W600,
                          maxLines: 1,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                          text: '${rateList?[index].toString()}',
                          style: AppStyles.ubNavyBlue16W700,
                          maxLines: 1,
                        ),
                        Dimens.boxWidth10,
                        GestureDetector(
                          onTap: () {
                            Get.bottomSheet(
                              CustomBottomSheet(
                                heading: Services.values[index].serviceName.tr,
                                description: Services
                                    .values[index].serviceDescription.tr,
                                headingSvg: Assets.iconsHeartOutline,
                              ),
                              barrierColor: AppColors.greyColor.withOpacity(.2),
                            );
                          },
                          child: SvgPicture.asset(
                            Assets.iconsInfoCircle,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

Widget availabilityView({required DateTime selectedDate}) => Padding(
      padding: Dimens.edgeInsetsL16R16,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: Dimens.edgeInsets10,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(Dimens.eight),
              boxShadow: [
                BoxShadow(
                  color: AppColors.lightNavyBlue.withOpacity(.8),
                  blurRadius: Dimens.five,
                )
              ],
            ),
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
              ),
              selectedDayPredicate: (day) => day == selectedDate,
              onDaySelected: (selectedDay, focusedDay) {
                selectedDate = selectedDay;
              },
              focusedDay: selectedDate,
            ),
          ),
          Dimens.boxHeight20,
          Container(
            padding: Dimens.edgeInsets16,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(Dimens.eight),
              boxShadow: [
                BoxShadow(
                  color: AppColors.lightNavyBlue.withOpacity(.8),
                  blurRadius: Dimens.five,
                ),
              ],
            ),
            child: Row(
              // mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: selectedDate.day.toString().padLeft(2, '0'),
                  style: AppStyles.ubBlack30W600,
                  maxLines: 1,
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
                        textAlign: TextAlign.start),
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
          Dimens.boxHeight20,
          CustomButton(
            title: TranslationKeys.bookSitter.tr,
            backGroundColor: AppColors.navyBlue,
            onTap: () {
              Get.to(const ScheduleNannyView());
            },
          ),
        ],
      ),
    );
