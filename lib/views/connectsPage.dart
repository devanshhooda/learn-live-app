import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learn_live_app/models/userModel.dart';
import 'package:learn_live_app/services/userServices.dart';
import 'package:learn_live_app/utils/sizeConfig.dart';
import 'package:learn_live_app/views/userProfilesPage.dart';

class ConnectsPage extends StatefulWidget {
  List connectsList;

  ConnectsPage({this.connectsList});
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
          child: (widget.connectsList != null && widget.connectsList.isNotEmpty)
              ? ListView.builder(
                  itemCount: widget.connectsList.length,
                  itemBuilder: (context, i) {
                    return FutureBuilder<UserModel>(
                        future:
                            userServices.getUserByUid(widget.connectsList[i]),
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
                                          : ''),
                                    ],
                                  ),
                                  // trailing: IconButton(
                                  //   icon: Icon(Icons.call),
                                  //   onPressed: () {
                                  //     print('Voice Calling');
                                  //   },
                                  //   iconSize: SizeConfig.safeBlockVertical * 3,
                                  // ),
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                UserProfilesPage(
                                                  userModel: snapshot.data,
                                                  i: false,
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
