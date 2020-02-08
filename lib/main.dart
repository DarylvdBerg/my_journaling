import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_journaling/services/auth.dart';
import 'package:my_journaling/wrapper.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';


void main() async {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {

  static final navigatorKey = new GlobalKey<NavigatorState>();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        navigatorKey: navigatorKey,
        home: Wrapper(),
        title: 'MyJournaling',
      ),
    );
  }
}



