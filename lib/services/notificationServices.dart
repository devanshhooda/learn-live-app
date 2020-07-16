import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:learn_live_app/services/videoCallService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationServices {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  VideoCallService videoCallService = new VideoCallService();
  SharedPreferences sharedPreferences;
  var _initializationSettings;
  String candidate;
  GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
  // String sendingId, receivingId, callerName;

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
      // print('init done');
    } catch (e) {
      print(e);
    }
  }

  incomingCallNotification(Map<String, dynamic> message) {
    try {
      var notification = message['notification'];
      String notifTitle = notification['title'];
      String callerName = notification['body'];
      String notifSubtitle = '$callerName is calling you...';
      var data = message['data'];
      String sendingId = data['sendingId'];
      String receivingId = data['receivingId'];
      _saveInfoToSP(
          callerName: callerName,
          sendingId: sendingId,
          receivingId: receivingId);
      // String callerId = message['data']['message'];
      // BotToast.showNotification(
      //     duration: Duration(minutes: 1),
      //     title: (_) => Text('$notifTitle'),
      //     subtitle: (_) => Text('$callerName calling you...'),
      //     onTap: () {
      //       answerCall();
      //     });
      var vibrationPattern = new Int64List(4);
      vibrationPattern[0] = 0;
      vibrationPattern[1] = 1000;
      vibrationPattern[2] = 5000;
      vibrationPattern[3] = 2000;
      var android = AndroidNotificationDetails(
          'channelId', 'channelName', 'channelDescription',
          enableVibration: true,
          vibrationPattern: vibrationPattern,
          timeoutAfter: 60000,
          importance: Importance.Max,
          priority: Priority.Max,
          playSound: true,
          onlyAlertOnce: false);
      var iOS = IOSNotificationDetails();
      var platform = NotificationDetails(android, iOS);
      flutterLocalNotificationsPlugin.show(
          0, '$notifTitle', '$notifSubtitle', platform,
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
        _answerCall();
      }
    }
  }

  _saveInfoToSP(
      {String sendingId, String receivingId, String callerName}) async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('callerName', callerName);
    sharedPreferences.setString('receivingId', receivingId);
    sharedPreferences.setString('sendingId', sendingId);
  }

  _answerCall() async {
    String callerName = sharedPreferences.getString('callerName');
    String sendingId = sharedPreferences.getString('sendingId');
    String receivingId = sharedPreferences.getString('receivingId');
    print(
        'callerName : $callerName, sendingId : $sendingId, receivingId : $receivingId');
    videoCallService.joinMeeting(
        userName: callerName, sendingId: sendingId, receivingId: receivingId);
  }
}
