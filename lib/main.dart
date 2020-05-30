import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.deepPurpleAccent[400],
          primarySwatch: Colors.deepPurple),
      title: 'Learn Live',
      home: LoginOptionsPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

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

  @override
  void initState() {
    controller = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
                    builder: (context) => NotificationsPage()));
              })
        ],
      ),
      body: TabBarView(
        children: <Widget>[PeoplePage(), ConnectsPage(), SettingsPage()],
        controller: controller,
      ),
    );
  }
}
