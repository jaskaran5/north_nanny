import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/nanny/nanny_views/nanny_edit_profile_view/nanny_edit_profile_view.dart';
import 'package:northshore_nanny_flutter/app/modules/nanny/nanny_views/nanny_edit_select_services/nanny_edit_services_view.dart';
import 'package:northshore_nanny_flutter/app/modules/nanny_profile/nanny_profile_controller.dart';
import 'package:northshore_nanny_flutter/app/modules/schedule_nanny/schedule_nanny_view.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';
import 'package:northshore_nanny_flutter/app/res/constants/enums.dart';
import 'package:northshore_nanny_flutter/app/res/constants/extensions.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_about_section.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_app_bar.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_button.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_nanny_home-svg_tile.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_nanny_profile_view.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../widgets/custom_bottom_sheet.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/houry_rate_view.dart';

class NannyProfileView extends StatelessWidget {
  const NannyProfileView(
      {super.key, required this.isComeFromSetting, required this.appBarTitle});
  final bool isComeFromSetting;
  final String appBarTitle;

  @override
  Widget build(BuildContext context) => GetBuilder(
        init: NannyProfileController(),
        builder: (controller) => Scaffold(
          appBar: CustomAppbarWidget(
            title: appBarTitle,
            centerTitle: true,
            actions: [
              if (!isComeFromSetting)
                GestureDetector(
                  onTap: () {
                    controller.isFavorite = !controller.isFavorite;
                    controller.update();
                  },
                  child: Padding(
                    padding: Dimens.edgeInsetsL16R16,
                    child: SvgPicture.asset(controller.isFavorite
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
                  CustomNannyProfileView(
                    nannyName: 'Christina Wang',
                    servicesList: isComeFromSetting
                        ? ['Gender: Female', 'Age: 40', 'Experience: 7+ yrs']
                        : controller.homeCustomList,
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
                        controller.profileTabList.length,
                        (index) => GestureDetector(
                          onTap: () {
                            controller.selectedIndex = index;
                            controller.update();
                          },
                          child: Container(
                            height: Dimens.forty,
                            width: Dimens.hundredEight,
                            // padding: Dimens.edgeInsets8,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: controller.selectedIndex == index
                                  ? AppColors.navyBlue
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(Dimens.eight),
                            ),
                            child: AppText(
                              text: controller.profileTabList[index].tr,
                              style: controller.selectedIndex == index
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
                  if (controller.selectedIndex == 0) ...[
                    const CustomAbout(
                        aboutNanny:
                            'Dedicated nanny providing loving Care and guidance to littleness. Experienced in nurturing children\'s development and ensuring a safe, happy environment.\n \n I have very Strong communication and instructional skill; patience and i have a Degree.'),
                    Dimens.boxHeight20,
                    if (!isComeFromSetting) ...[
                      Padding(
                        padding: Dimens.edgeInsetsL16R16,
                        child: HourlyRateView(
                          showShadow: false,
                          borderRadius: Dimens.ten,
                        ),
                      )
                    ],
                    if (isComeFromSetting) ...[
                      Container(
                        padding: Dimens.edgeInsets16,
                        margin: Dimens.edgeInsetsL16R16,
                        width: Get.width,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(
                            Dimens.eight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.lightNavyBlue.withOpacity(.8),
                              blurRadius: Dimens.five,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              text: 'Education',
                              maxLines: 1,
                              textAlign: TextAlign.start,
                              style: AppStyles.ubBlack14W700,
                            ),
                            Dimens.boxHeight14,
                            const CustomNannySvgTile(
                              assetName: Assets.iconsHouse,
                              heading: 'High school',
                              aboutHeading:
                                  'Austin Community Academy High School',
                            ),
                            Dimens.boxHeight14,
                            const CustomNannySvgTile(
                              assetName: Assets.iconsBuilding,
                              heading: 'College',
                              aboutHeading: 'Hebrew Theological College',
                            ),
                            Dimens.boxHeight14,
                          ],
                        ),
                      ),
                      Dimens.boxHeight20,
                      Container(
                        padding: Dimens.edgeInsets16,
                        width: Get.width,
                        margin: Dimens.edgeInsetsL16R16,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(
                            Dimens.eight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.lightNavyBlue.withOpacity(.8),
                              blurRadius: Dimens.five,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const CustomNannySvgTile(
                              assetName: Assets.iconsLocationDot,
                              heading: 'Location',
                              aboutHeading: 'Chicago, Naperville',
                            ),
                            Dimens.boxHeight14,
                            const CustomNannySvgTile(
                              assetName: Assets.iconsPhone,
                              heading: 'Phone number',
                              aboutHeading: '985 968 8745',
                            ),
                            Dimens.boxHeight14,
                            const CustomNannySvgTile(
                              assetName: Assets.iconsPersonalcard,
                              heading: 'Driver’s license',
                              aboutHeading: 'Yes',
                            ),
                            Dimens.boxHeight14,
                          ],
                        ),
                      ),
                      Dimens.boxHeight20,
                      Container(
                        padding: Dimens.edgeInsets16,
                        margin: Dimens.edgeInsetsL16R16,
                        width: Get.width,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(
                            Dimens.eight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.lightNavyBlue.withOpacity(.8),
                              blurRadius: Dimens.five,
                            ),
                          ],
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomNannySvgTile(
                              assetName: Assets.iconsDollarCircle,
                              heading: 'Referral bonus earned ',
                              aboutHeading: '\$5.00',
                            ),
                          ],
                        ),
                      ),
                      Dimens.boxHeight20,
                      CustomButton(
                        backGroundColor: AppColors.navyBlue,
                        title: TranslationKeys.editProfile.tr,
                        onTap: () {
                          Get.to(const NannyEditProfileView());
                        },
                      ),
                    ],
                  ],
                  if (controller.selectedIndex == 1) ...[
                    servicesView(
                        rateList: controller.priceList,
                        isComeFromSetting: isComeFromSetting),
                    if (isComeFromSetting)
                      CustomButton(
                        backGroundColor: AppColors.navyBlue,
                        title: 'Edit services',
                        onTap: () {
                          Get.to(const NannyEditServicesView());
                        },
                      ),
                  ],
                  if (controller.selectedIndex == 2) ...[
                    availabilityView(
                        selectedDate: controller.selectedDate,
                        isComeFromSetting: isComeFromSetting),
                  ],
                ],
              ),
            ),
          ),
        ),
      );
}

Widget servicesView(
        {List<String>? rateList, required bool isComeFromSetting}) =>
    Padding(
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
                        if (!isComeFromSetting) ...[
                          AppText(
                            text: '${rateList?[index].toString()}',
                            style: AppStyles.ubNavyBlue16W700,
                            maxLines: 1,
                          ),
                          Dimens.boxWidth10,
                        ],
                        GestureDetector(
                          onTap: () {
                            if (!isComeFromSetting) {
                              Get.bottomSheet(
                                CustomBottomSheet(
                                  heading:
                                      Services.values[index].serviceName.tr,
                                  description: Services
                                      .values[index].serviceDescription.tr,
                                  headingSvg: Assets.iconsRemoveBottomSheet,
                                ),
                                barrierColor:
                                    AppColors.greyColor.withOpacity(.2),
                              );
                            }
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

Widget availabilityView(
        {required DateTime selectedDate, required bool isComeFromSetting}) =>
    Padding(
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
              // availableGestures: AvailableGestures.none,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
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
                            text: 'February 2024, Friday',
                            style: AppStyles.ubGrey12W400,
                            maxLines: 1,
                            textAlign: TextAlign.start),
                        Dimens.boxHeight8,
                        AppText(
                          text: '10:00 AM to 05:00 PM',
                          style: AppStyles.ubBlack14W700,
                          maxLines: 1,
                          textAlign: TextAlign.start,
                        )
                      ],
                    ),
                  ],
                ),
                if (isComeFromSetting) ...[
                  PopupMenuButton(
                    padding: Dimens.edgeInsets4,
                    position: PopupMenuPosition.under,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Dimens.six),
                    ),
                    icon: SvgPicture.asset(Assets.iconsMore),
                    itemBuilder: (BuildContext context) {
                      return [
                        PopupMenuItem(
                          child: Text(
                            "Edit ",
                            maxLines: 1,
                            style: AppStyles.ubGreen05B016Color12W500,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        PopupMenuItem(
                          child: Text(
                            "Delete",
                            style: AppStyles.ubFc3030RedColor12W500,
                            textAlign: TextAlign.left,
                            maxLines: 1,
                          ),
                        ),
                      ];
                    },
                  ),
                ],
              ],
            ),
          ),
          Dimens.boxHeight20,
          CustomButton(
            title: isComeFromSetting
                ? 'Add availability'
                : TranslationKeys.bookSitter.tr,
            backGroundColor: AppColors.navyBlue,
            onTap: () {
              if (isComeFromSetting) {
                Get.dialog(
                  Center(
                    child: Padding(
                      padding: Dimens.edgeInsetsL16R16,
                      child: Material(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(Dimens.twenty),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(Dimens.twenty),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: Dimens.edgeInsets10,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AppText(
                                      text: 'Add availability',
                                      maxLines: 1,
                                      textAlign: TextAlign.left,
                                      style: AppStyles.ubBlack16W700,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.back();
                                      },
                                      child: SvgPicture.asset(
                                        Assets.iconsRemoveBottomSheet,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                color: AppColors.lightNavyBlue,
                                height: Dimens.one,
                              ),
                              Dimens.boxHeight14,
                              Padding(
                                padding: Dimens.edgeInsets16,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextField(
                                      maxLines: 1,
                                      minLines: 1,
                                      decoration: customFieldDeco(
                                        hintText: 'Start time',
                                      ),
                                      cursorColor: AppColors.blackColor,
                                      cursorWidth: Dimens.one,
                                      style: AppStyles.ubBlack15W600,
                                    ),
                                    Dimens.boxHeight14,
                                    TextField(
                                      maxLines: 1,
                                      minLines: 1,
                                      decoration: customFieldDeco(
                                        hintText: 'End time',
                                      ),
                                      cursorColor: AppColors.blackColor,
                                      cursorWidth: Dimens.one,
                                      style: AppStyles.ubBlack15W600,
                                    ),
                                    Dimens.boxHeight14,
                                    CustomButton(
                                      backGroundColor: AppColors.navyBlue,
                                      title: TranslationKeys.submit.tr,
                                      onTap: () {
                                        Get.back();
                                      },
                                    ),
                                    Dimens.boxHeight10,
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                Get.to(const ScheduleNannyView());
              }
            },
          ),
        ],
      ),
    );
