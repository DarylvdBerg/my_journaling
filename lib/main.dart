import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:my_journaling/services/auth.dart';
import 'package:my_journaling/wrapper.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';

final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final initSettingsAndroid = new AndroidInitializationSettings('mipmap/ic_launcher');
  final initSettingsIos = IOSInitializationSettings();
  final initSettings = InitializationSettings(initSettingsAndroid, initSettingsIos);
  _flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onSelectNotification: (String payload) async{
        print(payload);
      }
  );
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
        title: 'MyJournaling',
      ),
    );
  }
}



