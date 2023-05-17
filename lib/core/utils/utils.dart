import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

String dateToString(Timestamp date) {
  return '${date.toDate().day}/${date.toDate().month}/${date.toDate().year}'; // TODO change format
}

String parseTime(String? time) {
  if (time == null) return '';
  return time.contains(':') ? time.replaceAll(RegExp(":"), "h") : '${time}h';
}

String parseHoraire(Timestamp timestamp, int duration) {
  initializeDateFormatting();
  // "Oct. 31, 2022 à 11h-11h30"
  var month = DateFormat.MMM().format(timestamp.toDate());
  var day = timestamp.toDate().day;
  var startHour = timestamp.toDate().hour;
  var endHour = timestamp.toDate().add(Duration(minutes: duration)).hour;
  var dayWeek = DateFormat('EEEE', 'fr_FR').format(timestamp.toDate());

  return '$month. $day, à ${startHour}h-${endHour}h30 ($dayWeek)';
}

String getDayOfWeek(Timestamp timestamp) {
  return DateFormat('EEEE', 'fr_FR').format(timestamp.toDate());
}

String toDate(Timestamp timestamp) {
  return DateFormat('dd/MM/yyyy').format(timestamp.toDate());
}

String parseBetweenTime(String time) { // TODO change name of this function
  return time.contains(':')
      ? time
      : (time.contains("h") ? time.replaceAll(RegExp("h"), ":") : "$time:00");
}
bool isBetween(String timestamp, String start, String end) {

  DateTime startTime = DateFormat("HH:mm").parse(parseBetweenTime(start));
  DateTime endTime = DateFormat("HH:mm").parse(parseBetweenTime(end));
  DateTime timestampTime = DateFormat("HH:mm").parse(timestamp);
  return timestampTime.isAfter(startTime) && timestampTime.isBefore(endTime);
}
