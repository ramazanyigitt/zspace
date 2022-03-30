import 'package:intl/intl.dart' as intl;
import 'package:intl/intl.dart';

String formatDateHm(
  int timeAgo, {
  required bool isMilliSeconds,
}) {
  var dateFormat = intl.DateFormat.jm();
  var _formatter = dateFormat;
  var _formattedDate = _formatter.format(DateTime.fromMillisecondsSinceEpoch(
      (timeAgo * (isMilliSeconds ? 1 : 1000))));
  return _formattedDate;
}

String formatDateyMd({
  required int timeAgo,
  required bool addHM,
  required bool isMilliSeconds,
  bool monthDayYear: false,
}) {
  DateTime tm = DateTime.fromMillisecondsSinceEpoch(
      (timeAgo * (isMilliSeconds ? 1 : 1000)));

  DateTime today = new DateTime.now();
  Duration oneWeek = new Duration(days: 7);
  late String month;
  switch (tm.month) {
    case 1:
      month = "January";
      break;
    case 2:
      month = "February";
      break;
    case 3:
      month = "March";
      break;
    case 4:
      month = "April";
      break;
    case 5:
      month = "May";
      break;
    case 6:
      month = "June";
      break;
    case 7:
      month = "July";
      break;
    case 8:
      month = "August";
      break;
    case 9:
      month = "September";
      break;
    case 10:
      month = "October";
      break;
    case 11:
      month = "November";
      break;
    case 12:
      month = "December";
      break;
    default:
      month = "";
  }

  Duration difference = today.difference(tm);

  if (tm.day == today.day && tm.year == today.year && tm.month == tm.month) {
    return formatDateHm(timeAgo, isMilliSeconds: isMilliSeconds);
  }
  /*else if (difference.compareTo(oneWeek) < 1) {
    late String weekday;
    switch (tm.weekday) {
      case 1:
        weekday = "Mon";
        break;
      case 2:
        weekday = "Tue";
        break;
      case 3:
        weekday = "Wed";
        break;
      case 4:
        weekday = "Thu";
        break;
      case 5:
        weekday = "Fri";
        break;
      case 6:
        weekday = "Sat";
        break;
      case 7:
        weekday = "Sun";
        break;
      default:
        weekday = "";
    }
    return addHM
        ? '$weekday ${formatDateHm(timeAgo, isMilliSeconds: isMilliSeconds)}'
        : weekday;
  } else */
  if (tm.year == today.year) {
    return addHM
        ? '${tm.day} $month ${formatDateHm(timeAgo, isMilliSeconds: isMilliSeconds)}'
        : monthDayYear
            ? '$month ${tm.day}, ${tm.year}'
            : '${tm.day} $month ${tm.year}';
  } else {
    return addHM
        ? '${DateFormat('M/d/yy').format(tm)} ${formatDateHm(timeAgo, isMilliSeconds: isMilliSeconds)}'
        : DateFormat('M/d/yy').format(tm);
  }
}
