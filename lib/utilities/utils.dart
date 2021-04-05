import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medis/utilities/waktu.dart';

class Utils {
  static String getCurrentTime() {
    final DateTime now = DateTime.now();
    return Waktu(now).format('EEEE, dd MMMM yyyy \n h:mm:s a');
  }

  static String getCurrentDate() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now);
    return formatted;
  }

  static String getDateFormat(String dateString) {
    DateTime datetime = DateTime.parse(dateString);
    return Waktu(datetime).foryMMMMEEEEd();
  }

  static List<String> getTwoWeekDays() {
    List<String> twoWeekDays = [];
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');

    var daysAdd = 1;
    if (now.weekday > 5) {
      daysAdd = 3;
    }

    var oneDaysFromNow = now.add(new Duration(days: daysAdd));
    var twoDaysFromNow = oneDaysFromNow.add(new Duration(days: 1));
    twoWeekDays.add(formatter.format(oneDaysFromNow));
    twoWeekDays.add(formatter.format(twoDaysFromNow));

    return twoWeekDays;
  }

  static String getDateOnlyFormat(String dateString) {
    return DateFormat("yyyy-MM-dd").format(DateTime.parse(dateString));
  }

  static ThemeData getTheme() {
    return ThemeData(
        primaryColor: Colors.green[400],
        primaryIconTheme: const IconThemeData.fallback().copyWith(
          color: Colors.white,
        ),
        backgroundColor: Colors.white,
        primaryTextTheme: TextTheme(
            headline6: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: "QuickSand",
                fontWeight: FontWeight.bold)),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: "QuickSand");
  }
}
