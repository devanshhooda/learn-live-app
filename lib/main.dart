import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learn_live_app/models/userModel.dart';
import 'package:learn_live_app/services/notificationServices.dart';
import 'package:learn_live_app/services/userServices.dart';
import 'package:learn_live_app/utils/sizeConfig.dart';
import 'package:learn_live_app/views/connectsPage.dart';
import 'package:learn_live_app/views/loginOptionsPage.dart';
import 'package:learn_live_app/views/notificationsPage.dart';
import 'package:learn_live_app/views/peoplePage.dart';
import 'package:learn_live_app/views/settingsPage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final NotificationServices _notificationServices = new NotificationServices();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.deepPurpleAccent[400],
          primarySwatch: Colors.deepPurple),
      title: 'Learn Live',
      home: LoginCheck(),
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      navigatorKey: _notificationServices.navigatorKey,
      debugShowCheckedModeBanner: false,
    );
  }
}

// this is for existence of user
class LoginCheck extends StatefulWidget {
  @override
  _LoginCheckState createState() => _LoginCheckState();
}

class _LoginCheckState extends State<LoginCheck> {
  UserServices userServices;

  @override
  void initState() {
    userServices = new UserServices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return FutureBuilder(
      future: userServices.getUserIdFromSP(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return LearnLiveApp();
        } else {
          return LoginOptionsPage();
        }
      },
    );
  }
}

// this is the home of app
class LearnLiveApp extends StatefulWidget {
  @override
  _LearnLiveAppState createState() => _LearnLiveAppState();
}

class _LearnLiveAppState extends State<LearnLiveApp>
    with TickerProviderStateMixin {
  List<Tab> tabs = [
    Tab(
      text: 'People',
    ),
    Tab(
      text: 'Connects',
    ),
    Tab(
      text: 'Settings',
    ),
  ];

  TabController controller;
  // UserModel userModel;
  UserServices userServices;

  @override
  void initState() {
    controller = TabController(length: 3, vsync: this);
    super.initState();
    userServices = UserServices();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel>(
        future: userServices.getUser(),
        builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Learn  Live'),
                centerTitle: true,
                bottom: TabBar(
                  tabs: tabs,
                  controller: controller,
                  indicatorColor: Colors.white,
                ),
                actions: <Widget>[
                  IconButton(
                      icon: Icon(Icons.notifications),
                      onPressed: () {
                        print('Notifcations Page');
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => NotificationsPage(
                                receivedRequests: snapshot.hasData
                                    ? snapshot.data.receivedRequests
                                    : null)));
                      })
                ],
              ),
              body: TabBarView(
                children: <Widget>[
                  PeoplePage(),
                  ConnectsPage(
                    currentUser: snapshot.hasData ? snapshot.data : null,
                  ),
                  SettingsPage()
                ],
                controller: controller,
              ),
              // floatingActionButton: FloatingActionButton(
              //   backgroundColor: Colors.deepPurpleAccent[400],
              //   onPressed: () {
              //     print('Call logs');
              //   },
              //   child: Icon(Icons.video_call),
              // ),
            );
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
