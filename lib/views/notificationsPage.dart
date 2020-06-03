import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learn_live_app/models/userModel.dart';
import 'package:learn_live_app/services/userServices.dart';
import 'package:learn_live_app/utils/sizeConfig.dart';
import 'package:learn_live_app/views/respondingPage.dart';

class NotificationsPage extends StatefulWidget {
  List receivedRequests;
  NotificationsPage({this.receivedRequests});

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  UserServices userServices;

  @override
  void initState() {
    userServices = UserServices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: Container(
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          padding:
              EdgeInsets.symmetric(vertical: SizeConfig.safeBlockVertical * 1),
          child: (widget.receivedRequests != null &&
                  widget.receivedRequests.isNotEmpty)
              ? ListView.builder(
                  itemCount: widget.receivedRequests.length,
                  itemBuilder: (context, i) {
                    return FutureBuilder(
                        future: userServices
                            .getUserByUid(widget.receivedRequests[i]),
                        builder: (BuildContext context,
                            AsyncSnapshot<UserModel> snapshot) {
                          if (snapshot.hasData) {
                            return Column(
                              children: <Widget>[
                                ListTile(
                                  leading: CircleAvatar(
                                    radius: SizeConfig.safeBlockVertical * 3.5,
                                    child: SvgPicture.asset(
                                      'assets/profile_pic.svg',
                                    ),
                                  ),
                                  title: Row(
                                    children: <Widget>[
                                      Text(snapshot.data.name != null
                                          ? '${snapshot.data.name}, '
                                          : ''),
                                      Text(snapshot.data.age != null
                                          ? '${snapshot.data.age}'
                                          : '')
                                    ],
                                  ),
                                  subtitle: Row(
                                    children: <Widget>[
                                      Text(snapshot.data.profession != null
                                          ? '${snapshot.data.profession}, '
                                          : ''),
                                      Text(snapshot.data.company != null
                                          ? '${snapshot.data.company}'
                                          : '')
                                    ],
                                  ),
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RespondingPage(
                                                  userModel: snapshot.data,
                                                )));
                                  },
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          SizeConfig.safeBlockHorizontal * 7),
                                  child: Divider(),
                                )
                              ],
                            );
                          }
                          return Center(
                            child: LinearProgressIndicator(),
                          );
                        });
                  })
              : Center(
                  child: Text('No connects'),
                )),
    );
  }
}
