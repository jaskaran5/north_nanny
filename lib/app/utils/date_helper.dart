import 'dart:developer';

import 'package:intl/intl.dart';

class DateHelper {
  static const _locale = 'en';
  static const int secondMiles = 1000;
  static const int minuteMiles = 60 * secondMiles;
  static const int hourMiles = 60 * minuteMiles;
  static final _timeFormat12 = DateFormat("hh:mm a", _locale);
  static final _timeFormat24 = DateFormat("HH:mm:ss", _locale);
  static final _timeFormat24Post = DateFormat("HH:mm", _locale);
  static final _dateFormatLog = DateFormat("dd MMM yyyy", _locale);
  static final _dateFormatSince = DateFormat("MMM dd, yyyy", _locale);
  static final _dateFormatWithTime = DateFormat("MMM dd, yyyy h:mm a", _locale);
  static final _dateFormatMedication = DateFormat("MM/dd/yyyy", _locale);
  static final _dateFormatSinceWithDate = DateFormat("MMM dd, yyyy", _locale);
  static final _dateFormatGetEvent = DateFormat("yyyy-MM-dd", _locale);
  static final chatTime = DateFormat("yyyy-MM-dd", _locale);
  static final _dateFormatEvent = DateFormat("dd MMM yyyy", _locale);
  static final _joiningDate = DateFormat("dd MMM yyyy", _locale);
  static final dateFormatEventDetail = DateFormat("EEEE, MMM dd", _locale);
  static final _dateFormatNotification = DateFormat("MMM dd", _locale);
  static final _expiryMonthCard = DateFormat("MM", _locale);
  static final _expiryYearCard = DateFormat("dd", _locale);
  static final _addCardDateFormat = DateFormat("MM/yyyy", _locale);
  static final dateFormatWithoutString = DateFormat("yyyy-MM-dd", _locale);
  static final dateFormatNoString = DateFormat("dd/MM/yyyy", _locale);
  static final walletScreenFormat = DateFormat("MMMdd,yyyy h:mm a", _locale);
  static final dateTimeFormat = DateFormat("dd MM yyyy HH:mm", _locale);
  static final _nameOfDay = DateFormat('EEEE', _locale);
  static final _dob = DateFormat('dd-MM-yyyy', _locale);
  static final _journalDate = DateFormat('MM-dd-yyyy', _locale);
  static final _calenderEvent = DateFormat('MM-yyyy', _locale);
  static final isoTime = DateFormat('yyyy-MM-dd HH:mm:ss', _locale);

  static DateFormat getDateFormat(String dateFormat) {
    return DateFormat(dateFormat, _locale);
  }

  static String getDateOfBirth(DateTime? dateTime) {
    return _dob.format(dateTime!);
  }

  static String getJournalDate(DateTime? dateTime) {
    return _journalDate.format(dateTime!);
  }

  static String getCalendarEventDte(DateTime dateTime) {
    return _calenderEvent.format(dateTime);
  }

  static DateTime getDateTimeDOB(String dateTime) {
    return _dateFormatMedication.parse(dateTime);
  }

  static String getDateInSlashFormat(DateTime? dateTime) {
    return _dateFormatMedication.format(dateTime!);
  }

  static String getStringFromDate(String dateFormat, DateTime dateTime) {
    return getDateFormat(dateFormat).format(dateTime);
  }

  static DateTime getDateFromString(String dateFormat, String dateTime) {
    return getDateFormat(dateFormat).parse(dateTime);
  }

  static DateTime getEventDateObject(String? date) {
    return _dateFormatSince.parse(date!);
  }

  static String getMeetingDate(DateTime dateTime) {
    return _dateFormatEvent.format(dateTime);
  }

  static String getDateWithTime(DateTime dateTime) {
    return _dateFormatWithTime.format(dateTime);
  }

  static String getEventDate(String date) {
    return _dateFormatEvent.format(DateTime.parse(date));
  }

  static String getEventDetailDate(String date) {
    DateTime aDate = _dateFormatGetEvent.parse(date);
    return _dateFormatEvent.format(aDate);
  }

  static String getChatDate(String date) {
    try {
      DateTime aDate = DateTime.parse(date).toLocal();
      return _dateFormatWithTime.format(aDate);
    } catch (e) {
      return "";
    }
  }

  static String getMedicationDate(String date) {
    try {
      DateTime aDate = DateTime.parse(date).toLocal();
      return _dateFormatMedication.format(aDate);
    } catch (e) {
      return "";
    }
  }

  static String getEventStringDate(DateTime? date) {
    return _dateFormatEvent.format(date!);
  }

  static String getEventTime(String time) {
    DateTime date = _timeFormat24.parse(time);
    return _timeFormat12.format(date);
  }

  static DateTime getEventTimeObject(String time) {
    return _timeFormat24.parse(time);
  }

  static bool isToday(DateTime date) {
    return isSameDay(date, DateTime.now());
  }

  static bool isSameDay(DateTime dateTime1, DateTime dateTime2) {
    final aDate1 = DateTime(dateTime1.year, dateTime1.month, dateTime1.day);
    final aDate2 = DateTime(dateTime2.year, dateTime2.month, dateTime2.day);
    return aDate1 == aDate2;
  }

  static bool dayIsYesterday(DateTime dateTime) {
    final now = DateTime.now();
    final yesterday = DateTime(now.year, now.month, now.day - 1);

    final aDate = DateTime(dateTime.year, dateTime.month, dateTime.day);
    return yesterday == aDate;
  }

  static String formatTimeTo12Hour(String? dateTimeString) {
    if (dateTimeString == null) {
      return "";
    }
    var dateTime =
        DateFormat("yyyy-MM-dd HH:mm:ss").parse(dateTimeString, true);
    var dateLocal = dateTime.toLocal();
    String formattedTime = _timeFormat12.format(dateLocal);
    return formattedTime;
  }

  static String getDateTimeAgo(String? dateTimeString) {
    log("date time :-->> $dateTimeString");
    if (dateTimeString == null) {
      return "";
    }
    var date = DateFormat("yyyy-MM-dd HH:mm:ss").parse(dateTimeString, true);
    int time = date.millisecondsSinceEpoch;

    int now = DateTime.now().millisecondsSinceEpoch;

    if (time > now || time <= 0) {
      return "";
    }

    final int diff = now - time;
    if (diff < minuteMiles) {
      return "now";
    } else if (isToday(date)) {
      return formatTimeTo12Hour(dateTimeString);
    } else if (dayIsYesterday(date)) {
      return "Yesterday, ${formatTimeTo12Hour(dateTimeString)}";
    } else {
      return _dateFormatLog.format(date);
    }
  }

  static String convertDateTo24(DateTime dateTime) {
    return _timeFormat24.format(dateTime);
  }

  static String getNotificationDate(DateTime dateTime) {
    return _dateFormatNotification.format(dateTime.toLocal());
  }

  static DateTime excludeSeconds(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day, dateTime.hour,
        dateTime.minute);
  }

  static DateTime getOnlyDate(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day);
  }

  static String joiningDate(DateTime? dateTime) {
    return _joiningDate.format(dateTime!);
  }

  static String expiryMonth(DateTime dateTime) {
    return _expiryMonthCard.format(dateTime);
  }

  static String expiryYear(DateTime dateTime) {
    return _expiryYearCard.format(dateTime);
  }

  static String getDayOfWeek(DateTime dateTime) {
    return _nameOfDay.format(dateTime);
  }

  static DateTime getAddCardDate(String date) {
    return _addCardDateFormat.parse(date);
  }

  static String getCardDate(DateTime? date) {
    if (date == null) return "";
    return _addCardDateFormat.format(date);
  }

  static String getReservationDate(DateTime? date) {
    if (date == null) return "";
    return dateFormatWithoutString.format(date);
  }

  static String getSince(DateTime? date) {
    if (date == null) return "";
    return _dateFormatSince.format(date);
  }

  static String getSinceWithDate(DateTime? date) {
    if (date == null) return "";
    return _dateFormatSinceWithDate.format(date);
  }

  static String getUpdateDateMyPostList(DateTime? dateTime) {
    if (dateTime == null) return "0";
    return dateFormatNoString.format(dateTime);
  }

  static String getPickupTimeMyPostList(String? time) {
    if (time == null) {
      return "";
    }
    var date = _timeFormat24Post.parse(time);
    return _timeFormat12.format(date);
  }

  static DateTime getPickUpTimeDateObject(String? time) {
    return _timeFormat24Post.parse(time!);
  }

  static String getPostDateToSend(DateTime? date) {
    return _dateFormatGetEvent.format(date!);
  }

  static String convertDateTo24Post(DateTime? dateTime) {
    return _timeFormat24Post.format(dateTime!);
  }

  static String getPickupDateMyPostList(String? time) {
    if (time == null) {
      return '';
    } else {
      var date = dateFormatWithoutString.parse(time);
      return dateFormatNoString.format(date);
    }
  }

  static String getMyPostDetailsDate(String? time) {
    if (time == null) {
      return '';
    }
    var date = dateFormatWithoutString.parse(time);
    return _dateFormatLog.format(date);
  }

  static String getChatScreenTime(DateTime? time) {
    if (time == null) {
      return '';
    }
    return _timeFormat12.format(time);
  }
}
