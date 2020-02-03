import 'package:flutter/material.dart';
import 'package:my_journaling/models/menu_choice.dart';
import 'package:my_journaling/screens/notification_view.dart';
import 'package:my_journaling/services/auth.dart';
import 'package:my_journaling/util/menu.dart';
import 'package:my_journaling/util/strings.dart';
import 'package:my_journaling/widgets/journalCounter.dart';
import 'package:my_journaling/widgets/journal_future_builder.dart';

import '../wrapper.dart';
import 'journal_view.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final AuthService _auth = AuthService();

  void _select(MenuChoice choice) {
    switch(choice.title) {
      case Strings.LOGOUT:
        signOut();
        break;
      case Strings.NOTIFICATIONS:
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => NotificationView())
        );
        break;
    }
  }

  void signOut() async {
    await _auth.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Wrapper()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.APPNAME),
        elevation: 0.0,
        actions: <Widget>[
          PopupMenuButton<MenuChoice>(
            onSelected: _select,
            itemBuilder: (BuildContext context){
              return Menu.choices.map((MenuChoice choice){
                return PopupMenuItem(
                  value: choice,
                  child: Row(
                    children: <Widget>[
                      Icon(choice.icon, size: 25, color: Colors.black,),
                      Text(choice.title),
                    ],
                  ),
                );
              }).toList();
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            JournalCounter(),
            JournalFutureBuilder()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => JournalView()),
          );
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
