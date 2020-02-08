import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:my_journaling/screens/home_view.dart';
import 'package:my_journaling/screens/journal_view.dart';
import 'package:my_journaling/screens/login_view.dart';
import 'package:my_journaling/services/auth.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    final initSettingsAndroid = new AndroidInitializationSettings('drawable/app_notification_icon');
    final initSettingsIos = IOSInitializationSettings();
    final initSettings = InitializationSettings(initSettingsAndroid, initSettingsIos);
    _flutterLocalNotificationsPlugin.initialize(
        initSettings,
        onSelectNotification: onSelectNotification
    );
  }

  Future onSelectNotification(String _) async {
    print(AuthService.currentUser);
    await Navigator
        .pushReplacement(context, MaterialPageRoute(builder: (context) => HomeView()));
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<User>(context);

    if(currentUser == null) {
      return LoginView();
    }

    return HomeView();

  }
}
