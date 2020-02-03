import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class TimestampConverter {

  static String getDayFromTimestamp(Timestamp timestamp) {
    DateTime date = timestamp.toDate();
    return DateFormat('EEEE').format(date);
  }

  static String getFullDateFromTimestamp(Timestamp timestamp) {
    DateTime date = timestamp.toDate();
    return DateFormat('dd-MM-yyyy HH:mm').format(date);
  }
}