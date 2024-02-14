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
