import 'package:flutter/material.dart';
import 'package:my_journaling/services/notification.dart';
import 'package:my_journaling/util/strings.dart';

class NotificationView extends StatefulWidget {
  @override
  _NotificationViewState createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {

  final NotificationService service = NotificationService();
  TimeOfDay timeSelected;


  Future<Null> _setTime(BuildContext context) async{
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if(picked != null && picked != timeSelected) {
      setState(() {
        timeSelected = picked;
      });
    }
  }

  String timeOfDayToString(TimeOfDay time) {
    return time.toString().substring(time.toString().indexOf("(")+1, time.toString().indexOf(")"));
  }

  Future<void> saveNotificationTime() async {
    service.setNotificationTime(timeSelected);
    service.showDailyNotification(timeSelected, 0);
  }


  @override
  void initState() {
    service.getNotificationTime().then((val) => timeSelected = val);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.APPNAME),
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height/4,
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text((timeSelected == null) ? "No time has been set" : "Notifications everyday at: "+timeOfDayToString(timeSelected),
                  style: TextStyle(fontSize: 20),)
                ],
              ),
            ),
          ),
          RaisedButton(
            onPressed: () => _setTime(context),
            child: Text("Pick time"),
          ),
          RaisedButton(
            onPressed: () async {
               await saveNotificationTime();
            },
            child: Text("Set Notification"),
          ),
        ],
      ),
    );
  }
}
