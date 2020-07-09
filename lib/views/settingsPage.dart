import 'package:flutter/material.dart';
import 'package:learn_live_app/services/userServices.dart';
import 'package:learn_live_app/utils/sizeConfig.dart';

import '../main.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  UserServices userServices;

  @override
  void initState() {
    userServices = UserServices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        child: Center(
          child: Container(
            child: RaisedButton(
                padding: EdgeInsets.symmetric(
                    vertical: SizeConfig.safeBlockVertical * 2,
                    horizontal: SizeConfig.blockSizeHorizontal * 10),
                color: Colors.deepPurpleAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
                child: Text(
                  'Sign Out',
                  style: TextStyle(
                      color: Colors.white, fontSize: SizeConfig.font_size * 5),
                ),
                onPressed: () async {
                  bool isSignedOut = await userServices.signOut();
                  if (isSignedOut) {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => LoginCheck()),
                        ModalRoute.withName(''));
                  }
                  print('SignOut');
                }),
          ),
        ),
      ),
    );
  }

  // Future onSelectNotification(String payload) async {
  //   if (payload != null) {
  //     debugPrint('notification payload: ' + payload);
  //   }
  // }

  // showNotification() {
  //   try {
  //     var android = new AndroidNotificationDetails(
  //       'channel id',
  //       'channelName',
  //       'channelDescription',
  //       importance: Importance.Max,
  //       priority: Priority.Max,
  //       playSound: true,
  //       enableVibration: true,
  //     );
  //     var iOS = new IOSNotificationDetails();
  //     var platform = NotificationDetails(android, iOS);
  //     flutterLocalNotificationsPlugin.show(0, 'title', 'body', platform,
  //         payload: 'Hello');
  //     // flutterLocalNotificationsPlugin.periodicallyShow(
  //     //     0, 'title', 'body', RepeatInterval.EveryMinute, platform);
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}
