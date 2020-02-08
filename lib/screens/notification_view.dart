import 'package:flutter/material.dart';
import 'package:my_journaling/services/notification.dart';
import 'package:my_journaling/util/app_colors.dart';
import 'package:my_journaling/util/strings.dart';

class NotificationView extends StatefulWidget {
  @override
  _NotificationViewState createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  final NotificationService service = NotificationService();
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  TimeOfDay timeSelected;

  Future<Null> _setTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null && picked != timeSelected) {
      setState(() {
        timeSelected = picked;
        service.setNotificationTime(timeSelected);
      });
    }
  }

  String timeOfDayToString(TimeOfDay time) {
    return time.toString().substring(
        time.toString().indexOf("(") + 1, time.toString().indexOf(")"));
  }

  Future<void> saveNotificationTime() async {
    service.showDailyNotification(timeSelected, 0);
    _scaffoldState.currentState.showSnackBar(SnackBar(
      content: Text("Time for notification has been set."),
    ));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        backgroundColor: AppColor.PRIMARYCOLOR,
        title: Text(Strings.APPNAME),
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 4,
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FutureBuilder(
                      future: service.getNotificationTime(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        timeSelected = snapshot.data;
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                            return Text("Getting journal time...");
                          default:
                            if (timeSelected == null)
                              return Text("No time has been set");
                            else
                              return Text(
                                "Notification will be send everyday at: " +
                                    timeOfDayToString(timeSelected),
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              );
                        }
                      }),
                ],
              ),
            ),
          ),
          Theme(
            data: Theme.of(context).copyWith(
              primaryColor: AppColor.PRIMARYCOLOR,
              accentColor: AppColor.ACCENTCOLOR,
              colorScheme: ColorScheme.light(
                secondary: AppColor.ACCENTCOLOR
              ),
              buttonTheme: ButtonTheme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  secondary: AppColor.ACCENTCOLOR,
                ),
              ),
            ),
            child: Builder(
              builder: (context) => RaisedButton(
                onPressed: () => _setTime(context),
                color: Colors.white,
                child: Text(
                  "Pick time",
                  style: TextStyle(color: AppColor.ACCENTCOLOR),
                ),
              ),
            ),
          ),
          RaisedButton(
            onPressed: () async {
              await saveNotificationTime();
            },
            color: Colors.white,
            child: Text(
              "Set Notification",
              style: TextStyle(color: AppColor.ACCENTCOLOR),
            ),
          ),
        ],
      ),
    );
  }
}
