import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:northshore_nanny_flutter/app/modules/nanny_profile/nanny_profile_controller.dart';
import 'package:northshore_nanny_flutter/app/modules/schedule_nanny/schedule_nanny_view.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';
import 'package:northshore_nanny_flutter/app/res/constants/enums.dart';
import 'package:northshore_nanny_flutter/app/res/constants/extensions.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/utils/utility.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_about_section.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_app_bar.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_button.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_nanny_home_svg_tile.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_nanny_profile_view.dart';
import 'package:northshore_nanny_flutter/app/widgets/review_custom_bottom_sheet.dart';
import 'package:northshore_nanny_flutter/navigators/routes_management.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

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
                    imageUrl: controller.profileData.data?.image,
                    nannyName: controller.profileData.data?.name.toString(),
                    // servicesList: isComeFromSetting
                    //     ? ['Gender: Female', 'Age: 40', 'Experience: 7+ yrs']
                    //     : controller.homeCustomList,
                    totalRating: controller.profileData.data?.rating,
                    totalReview: controller.profileData.data?.reviewCount,
                    nannyAge: controller.profileData.data?.age.toString(),
                    nannyExperience: controller.profileData.data?.experience,
                    nannyGender: controller.profileData.data?.gender == 1
                        ? TranslationKeys.male.tr
                        : controller.profileData.data?.gender == 2
                            ? TranslationKeys.female.tr
                            : '',
                    onTapRating: () {
                      Utility.openBottomSheet(CustomReviewBottomSheet(
                          totalReviews:
                              controller.profileData.data?.reviewCount ?? 0,
                          totalReviewsRating:
                              controller.profileData.data?.rating ?? 0.0,
                          reviewsList:
                              controller.profileData.data?.ratingList ?? []));
                    },
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
                    CustomAbout(
                      aboutNanny: controller.profileData.data?.about ?? '',
                    ),
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
                              text: TranslationKeys.education.tr,
                              maxLines: 1,
                              textAlign: TextAlign.start,
                              style: AppStyles.ubBlack14W700,
                            ),
                            Dimens.boxHeight14,
                            CustomNannySvgTile(
                              assetName: Assets.iconsHouse,
                              heading: TranslationKeys.highSchool.tr,
                              aboutHeading: controller
                                      .profileData.data?.highSchool
                                      .toString() ??
                                  '',
                            ),
                            Dimens.boxHeight14,
                            CustomNannySvgTile(
                              assetName: Assets.iconsBuilding,
                              heading: TranslationKeys.college.tr,
                              aboutHeading: controller.profileData.data?.college
                                      .toString() ??
                                  '',
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
                            CustomNannySvgTile(
                              assetName: Assets.iconsLocationDot,
                              heading: TranslationKeys.location.tr,
                              aboutHeading:
                                  controller.profileData.data?.location ?? '',
                            ),
                            Dimens.boxHeight14,
                            CustomNannySvgTile(
                              assetName: Assets.iconsPhone,
                              heading: TranslationKeys.phoneNumber.tr,
                              aboutHeading:
                                  controller.profileData.data?.mobileNo ?? '',
                            ),
                            Dimens.boxHeight14,
                            if (controller.profileData.data?.isDrivingLicence !=
                                null) ...[
                              CustomNannySvgTile(
                                assetName: Assets.iconsPersonalcard,
                                heading: TranslationKeys.driversLicense.tr,
                                aboutHeading: controller
                                        .profileData.data?.isDrivingLicence
                                        .toString() ??
                                    '',
                              ),
                              Dimens.boxHeight14,
                            ],
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomNannySvgTile(
                              assetName: Assets.iconsDollarCircle,
                              heading: TranslationKeys.referralEarned.tr,
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
                          RouteManagement.goToEditNannyProfileView();
                        },
                      ),
                    ],
                  ],
                  if (controller.selectedIndex == 1) ...[
                    servicesView(
                        // rateList: controller.priceList,
                        servicesList: controller.profileData.data?.services,
                        isComeFromSetting: isComeFromSetting),
                    if (isComeFromSetting)
                      CustomButton(
                        backGroundColor: AppColors.navyBlue,
                        title: TranslationKeys.editServices.tr,
                        onTap: () {
                          RouteManagement.goToEditNannyServicesView();
                        },
                      ),
                  ],
                  if (controller.selectedIndex == 2) ...[
                    availabilityView(
                      isComeFromSetting: isComeFromSetting,
                      controller: controller,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      );
}

Widget servicesView(
        {List<String>? rateList,
        List<String>? servicesList,
        required bool isComeFromSetting}) =>
    Padding(
      padding: Dimens.edgeInsetsL16R16,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          servicesList?.length ?? 0,
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
                            (Services.values
                                    .firstWhereOrNull((element) =>
                                        element.serviceName ==
                                        servicesList?[index].toString())
                                    ?.servicesSvg) ??
                                Services.funActivityOutHouse.servicesSvg,
                          ),
                        ),
                        Dimens.boxWidth10,
                        AppText(
                          text: (Services.values
                                  .firstWhereOrNull((element) =>
                                      element.serviceName ==
                                      servicesList?[index].toString())
                                  ?.serviceName
                                  .tr) ??
                              Services.funActivityOutHouse.serviceName.tr,
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
        {required bool isComeFromSetting,
        required NannyProfileController controller}) =>
    Padding(
      padding: Dimens.edgeInsetsL16R16,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: Dimens.edgeInsets10,
            alignment: Alignment.center,
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
            child: SfDateRangePicker(
              selectionMode: DateRangePickerSelectionMode.range,
              navigationMode: DateRangePickerNavigationMode.none,
              onSelectionChanged: (DateRangePickerSelectionChangedArgs dateRangePickerSelectionChangedArgs) {
                // DateFormat('yyy-MM-dd').format()
              },
              view: DateRangePickerView.month,
              initialSelectedDate: controller.selectedDate,
              allowViewNavigation: false,
              backgroundColor: AppColors.primaryColor,
              enablePastDates: false,
              headerStyle: DateRangePickerHeaderStyle(
                  textStyle: AppStyles.ubBlack18W600,
                  backgroundColor: AppColors.primaryColor,
                  textAlign: TextAlign.left),
              minDate: DateTime.now(),
              monthCellStyle: DateRangePickerMonthCellStyle(
                disabledDatesTextStyle: AppStyles.ubHintColor13W500,
                weekendTextStyle: AppStyles.ubHintColor15W500,
                textStyle: AppStyles.ubBlack15W600,
                todayTextStyle: AppStyles.ubNavyBlue15W600,
                leadingDatesTextStyle: AppStyles.ubHintColor13W500,
                trailingDatesTextStyle: AppStyles.ubHintColor13W500,
                todayCellDecoration: const BoxDecoration(
                    color: Colors.transparent, shape: BoxShape.circle),
              ),
              monthViewSettings: DateRangePickerMonthViewSettings(
                showTrailingAndLeadingDates: true,
                viewHeaderStyle: DateRangePickerViewHeaderStyle(
                  textStyle: AppStyles.ubGrey14W500,
                ),
              ),
              initialDisplayDate: controller.selectedDate,
              rangeSelectionColor: AppColors.lightNavyBlue,
              startRangeSelectionColor: AppColors.navyBlue,
              rangeTextStyle: AppStyles.ubBlack15W600,
              endRangeSelectionColor: AppColors.navyBlue,
              todayHighlightColor: AppColors.navyBlue,
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
                      text: '01',
                      // 'controller.selectedDate.first.day.toString().padLeft(2, '')',
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
                            TranslationKeys.edit.tr,
                            maxLines: 1,
                            style: AppStyles.ubGreen05B016Color12W500,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        PopupMenuItem(
                          child: Text(
                            TranslationKeys.delete.tr,
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
                ? TranslationKeys.addAvailability.tr
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
                                      text: TranslationKeys.addAvailability.tr,
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
                                        hintText: TranslationKeys.startTime.tr,
                                      ),
                                      cursorColor: AppColors.blackColor,
                                      cursorWidth: Dimens.one,
                                      style: AppStyles.ubBlack15W600,
                                    ),
                                    Dimens.boxHeight14,
                                    TextField(
                                      maxLines: 1,
                                      readOnly: true,
                                      onTap: () async {
                                        var endValue = await showTimePicker(
                                          context: Get.context!,
                                          initialTime: TimeOfDay.now(),
                                        );
                                        print('value:$endValue');
                                      },
                                      minLines: 1,
                                      decoration: customFieldDeco(
                                        hintText: TranslationKeys.endTime.tr,
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
