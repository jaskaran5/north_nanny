import 'package:northshore_nanny_flutter/res/constants/constants.dart';
import 'package:northshore_nanny_flutter/utils/translations/translation_keys.dart';

extension BottomTabName on BottomTabs {
  String get bottomTabName {
    switch (this) {
      case BottomTabs.home:
        return TranslationKeys.home;
      case BottomTabs.messages:
        return TranslationKeys.messages;

      case BottomTabs.notifications:
        return '';
      case BottomTabs.calender:
        return TranslationKeys.calender;
      case BottomTabs.settings:
        return TranslationKeys.settings;
    }
  }

  String get bottomSvg {
    switch (this) {
      case BottomTabs.home:
        return Assets.iconsHomeOutline;
      case BottomTabs.messages:
        return Assets.iconsMessage;
      case BottomTabs.notifications:
        return Assets.iconsNotificationOutline;
      case BottomTabs.calender:
        return Assets.iconsCalendar;
      case BottomTabs.settings:
        return Assets.iconsSettingOutline;
    }
  }

  String get selectedBottomSvg {
    switch (this) {
      case BottomTabs.home:
        return Assets.iconsHomeFilled;
      case BottomTabs.messages:
        return Assets.iconsMessageFilled;
      case BottomTabs.notifications:
        return Assets.iconsNotificationOutline;
      case BottomTabs.calender:
        return Assets.iconsCalendarFilled;
      case BottomTabs.settings:
        return Assets.iconsSettingFilled;
    }
  }
}

extension ServiceName on Services {
  String get serviceName {
    switch (this) {
      case Services.houseKeeping:
        return TranslationKeys.houseKeeping;
      case Services.driving:
        return TranslationKeys.driving;
      case Services.petCare:
        return TranslationKeys.petCare;
      case Services.homeWorkHelp:
        return TranslationKeys.homeWorkHelp;
      case Services.runningErrands:
        return TranslationKeys.runningErrands;
      case Services.funActivityOutHouse:
        return TranslationKeys.funActivityOutHouse;
    }
  }

  String get servicesSvg {
    switch (this) {
      case Services.houseKeeping:
        return Assets.iconsHouseKeeping;
      case Services.driving:
        return Assets.iconsStaringWheel;
      case Services.petCare:
        return Assets.iconsPetThumb;
      case Services.homeWorkHelp:
        return Assets.iconsHomeWork;
      case Services.runningErrands:
        return Assets.iconsShoppingCart;
      case Services.funActivityOutHouse:
        return Assets.iconsFunActivity;
    }
  }

  String get serviceDescription {
    switch (this) {
      case Services.houseKeeping:
        return 'This service includes, but is not limited to the following household chores: dishes, laundry, floors, countertops, and general tidying up.';
      case Services.driving:
        return 'This service includes school, camp, club, and sport pick-ups/drop-offs. (Only nannies who have proven that they have a driver’s license will be eligible for this service).';
      case Services.petCare:
        return 'The pet-care service includes feeding, walking, etc.';
      case Services.homeWorkHelp:
        return 'This service includes nannies assisting your child with completing their daily homework assignments.';
      case Services.runningErrands:
        return 'This service includes running everyday errands such as grocery shopping, etc.';
      case Services.funActivityOutHouse:
        return 'This service includes taking your children on fun activities such as: the trampoline park, pool/ beach, park, etc. This is included at no extra cost.';
    }
  }
}

extension GenderName on GenderConstant {
  String get genderName {
    switch (this) {
      case GenderConstant.male:
        return TranslationKeys.male;
      case GenderConstant.female:
        return TranslationKeys.female;
    }
  }
}
