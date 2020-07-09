import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:learn_live_app/services/userServices.dart';
import 'package:learn_live_app/services/videoCallService.dart';
import 'package:learn_live_app/views/videocallPage.dart';

class NotificationServices {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  VideoCallService videoCallService = new VideoCallService();
  UserServices _userServices = new UserServices();
  var _initializationSettings;
  String candidate;
  GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

  NotificationServices() {
    _initNotifs();
  }

  // notifications initialisation
  _initNotifs() async {
    try {
      flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
      var initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');
      var initializationSettingsIOS = IOSInitializationSettings();
      _initializationSettings = InitializationSettings(
          initializationSettingsAndroid, initializationSettingsIOS);
      await flutterLocalNotificationsPlugin.initialize(_initializationSettings,
          onSelectNotification: _onSelectNotification);
      print('init done');
    } catch (e) {
      print(e);
    }
  }

  incomingCallNotification(Map<String, dynamic> message) {
    try {
      candidate = message['data']['candidate'];
      String notifTitle = 'Learn live video call request';
      String callerName = message['notification']['body'];
      // String callerId = message['data']['message'];
      BotToast.showNotification(
          duration: Duration(minutes: 1),
          title: (_) => Text('$notifTitle'),
          subtitle: (_) => Text('$callerName calling you...'),
          onTap: () {
            answerCall();
          });

      var android = AndroidNotificationDetails(
          'channelId', 'channelName', 'channelDescription',
          enableVibration: true,
          timeoutAfter: 60000,
          importance: Importance.Max,
          priority: Priority.Max,
          playSound: true,
          onlyAlertOnce: false);
      var iOS = IOSNotificationDetails();
      var platform = NotificationDetails(android, iOS);
      flutterLocalNotificationsPlugin.show(
          0, '$notifTitle', '$callerName calling you...', platform,
          payload: 'Call received');
    } catch (e) {
      print(e);
    }
  }

  // on click on the notification
  Future _onSelectNotification(String payload) async {
    if (payload != null) {
      print(payload);
      if (payload == 'Call received') {
        answerCall();
      }
    }
  }

  answerCall() async {
    String answer = videoCallService.createAnswer();
    await _userServices.sendCallAnswer(answer).then((_) async {
      await videoCallService.setCandidate(candidate).then((_) {
        Navigator.of(navigatorKey.currentContext)
            .push(CupertinoPageRoute(builder: (_) => VideoCallPage()));
      });
    });
  }
}
