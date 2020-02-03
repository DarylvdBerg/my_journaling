import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:my_journaling/util/strings.dart';

class Notification {
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  Notification(){
    _initializeNotification();
  }

  void _initializeNotification() {
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final initSettingsAndroid = AndroidInitializationSettings('');
    final initSettings = InitializationSettings(initSettingsAndroid, null);
    _flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onSelectNotification: onSelectNotification
    );
  }

  Future onSelectNotification(String payload) async {
    if(payload != null)
      print('Notification');
  }

  Future<void> showDailyNotification(Time time, int id) async {
    final androidPlatfromChannel = AndroidNotificationDetails(
      'show daily channel id',
      'show daily channel name',
      'show daily description'
    );

    final platformChannel = NotificationDetails(
      androidPlatfromChannel,
      null
    );

    await _flutterLocalNotificationsPlugin.showDailyAtTime(
        id,
        Strings.NOTIFICATION_TITLE,
        Strings.NOTIFICATION_BODY,
        time,
        platformChannel
    );
  }
}