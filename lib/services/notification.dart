import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:my_journaling/util/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationService {
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Set notification on shared preferences
  setNotificationTime(TimeOfDay time) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(Strings.SHAREDPREF, time.toString());
  }

  /// get notification time from shared preferences
  Future<TimeOfDay> getNotificationTime() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return convertStringToTimeOfDay(pref.get(Strings.SHAREDPREF));
  }

  /// Set the daily notification
  Future<void> showDailyNotification(TimeOfDay timeOfDay, int id) async {
    Time time = Time(timeOfDay.hour, timeOfDay.minute, 0);
    var platformChannel = _initPlatform();

    await _flutterLocalNotificationsPlugin.showDailyAtTime(
        id,
        Strings.NOTIFICATION_TITLE,
        Strings.NOTIFICATION_BODY,
        time,
        platformChannel
    );
  }

  /// Init notification for specific platforms
  NotificationDetails _initPlatform() {
    final androidPlatformChannel = new AndroidNotificationDetails(
      Strings.CHANNEL_ID,
      Strings.CHANNEL_NAME,
      Strings.CHANNEL_DESCRIPTION,
    );

    final iosPlatform = new IOSNotificationDetails();

    final platformChannel = new NotificationDetails(
      androidPlatformChannel,
      iosPlatform,
    );

    return platformChannel;
  }

  /// Convert a string to TimeOfDay object
  TimeOfDay convertStringToTimeOfDay(String timeOfDay) {
    timeOfDay = timeOfDay.substring(timeOfDay.indexOf("(")+1, timeOfDay.indexOf(")"));

    int minutes = int.parse(timeOfDay.split(":")[1]);
    int hour = int.parse(timeOfDay.split(":")[0]);

    return TimeOfDay(hour: hour, minute: minutes);
  }
}