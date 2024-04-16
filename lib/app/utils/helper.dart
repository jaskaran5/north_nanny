import 'package:flutter/material.dart';

String addStringsWithSpace(String str1, String str2) {
  return '$str1 $str2';
}

bool isTimeEqual(TimeOfDay time1, TimeOfDay time2) {
  return time1.hour == time2.hour && time1.minute == time2.minute;
}

bool isTimeBefore(TimeOfDay time1, TimeOfDay time2) {
  return time1.hour < time2.hour || (time1.hour == time2.hour && time1.minute < time2.minute);
}

bool isTimeAfter(TimeOfDay time1, TimeOfDay time2) {
  return time1.hour > time2.hour || (time1.hour == time2.hour && time1.minute > time2.minute);
}
bool isTimeOfDayBetween(TimeOfDay startTime, TimeOfDay endTime, TimeOfDay currentTime) {
  final startMinutes = startTime.hour * 60 + startTime.minute;
  final endMinutes = endTime.hour * 60 + endTime.minute;
  final currentMinutes = currentTime.hour * 60 + currentTime.minute;

  return currentMinutes >= startMinutes && currentMinutes <= endMinutes;
}

bool isTimeDifferenceGreaterThanOrEqualToOneHour(TimeOfDay time1, TimeOfDay time2) {
  final int minutesDifference =
      (time1.hour - time2.hour) * 60 + (time1.minute - time2.minute);
  return minutesDifference >= 60 || minutesDifference <= -60;
}

