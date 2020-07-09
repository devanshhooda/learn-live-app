import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learn_live_app/models/userModel.dart';
import 'package:learn_live_app/services/userServices.dart';
import 'package:learn_live_app/utils/sizeConfig.dart';
import 'package:learn_live_app/views/userProfilesPage.dart';

class ConnectsPage extends StatefulWidget {
  UserModel currentUser;

  ConnectsPage({this.currentUser});
  @override
  _ConnectsPageState createState() => _ConnectsPageState();
}

class _ConnectsPageState extends State<ConnectsPage> {
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
          child: (widget.currentUser.connects != null &&
                  widget.currentUser.connects.isNotEmpty)
              ? ListView.builder(
                  itemCount: widget.currentUser.connects.length,
                  itemBuilder: (context, i) {
                    return FutureBuilder<UserModel>(
                        future: userServices
                            .getUserByUid(widget.currentUser.connects[i]),
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
                                  title: (snapshot.data.name == null &&
                                          snapshot.data.age == null)
                                      ? null
                                      : (snapshot.data.name != null &&
                                              snapshot.data.age == null)
                                          ? Text('${snapshot.data.name}')
                                          : (snapshot.data.name == null &&
                                                  snapshot.data.age != null)
                                              ? Text('${snapshot.data.age}')
                                              : Text(
                                                  '${snapshot.data.name}, ${snapshot.data.age}'),
                                  subtitle: (snapshot.data.profession == null &&
                                          snapshot.data.company == null)
                                      ? null
                                      : (snapshot.data.profession != null &&
                                              snapshot.data.company == null)
                                          ? Text('${snapshot.data.profession}')
                                          : (snapshot.data.profession == null &&
                                                  snapshot.data.company != null)
                                              ? Text('${snapshot.data.company}')
                                              : Text(
                                                  '${snapshot.data.profession}, ${snapshot.data.company}'),
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                UserProfilesPage(
                                                  userModel: snapshot.data,
                                                  currentUser:
                                                      widget.currentUser,
                                                  connected: false,
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
                  child: Text('No Connections'),
                )),
    );
  }
}
