import 'package:flutter/material.dart';
import 'package:my_journaling/services/auth.dart';
import 'package:my_journaling/util/router.dart' as router;
import 'package:my_journaling/wrapper.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        title: 'MyJournaling',
        home: Wrapper(),
        onGenerateRoute: router.generateRoute,
      ),
    );
  }
}

