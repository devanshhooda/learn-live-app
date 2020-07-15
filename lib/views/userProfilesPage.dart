import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_live_app/models/userModel.dart';
import 'package:learn_live_app/services/userServices.dart';
import 'package:learn_live_app/services/videoCallService.dart';
import 'package:learn_live_app/utils/sizeConfig.dart';

class UserProfilesPage extends StatefulWidget {
  UserModel userModel;
  UserModel currentUser;
  bool fromPeoplesPage;
  UserProfilesPage(
      {@required this.userModel, this.fromPeoplesPage, this.currentUser});
  @override
  _UserProfilesPageState createState() => _UserProfilesPageState();
}

class _UserProfilesPageState extends State<UserProfilesPage> {
  UserServices userServices;
  VideoCallService videoCallService;
  @override
  void initState() {
    userServices = new UserServices();
    videoCallService = new VideoCallService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.userModel.name != null ? '${widget.userModel.name}' : ''),
        actions: widget.fromPeoplesPage
            ? null
            : <Widget>[
                IconButton(
                    icon: Icon(Icons.videocam),
                    onPressed: () async {
                      print('Calling');
                      videoCallService.joinMeeting(
                          userName: widget.userModel.name,
                          sendingId: widget.currentUser.id,
                          receivingId: widget.userModel.id);
                      await userServices.requestVideoCall(widget.currentUser.id,
                          widget.userModel.id, widget.currentUser.name);
                      Navigator.of(context).pop();
                    }),
              ],
      ),
      body: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: SizeConfig.safeBlockVertical * 5,
            ),
            new CircleAvatar(
              radius: SizeConfig.safeBlockVertical * 10,
              child: SvgPicture.asset(
                'assets/profile_pic.svg',
              ),
            ),
            Center(
              child: Text(
                widget.userModel.bio != null
                    ? 'Bio: ${widget.userModel.bio}'
                    : '',
                style: GoogleFonts.patrickHand(
                    textStyle: TextStyle(fontSize: SizeConfig.font_size * 5)),
              ),
            ),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 1,
            ),
            // detail('Bio', widget.userModel.bio),
            detail('Name', widget.userModel.name),
            detail('Age', widget.userModel.age.toString()),
            detail('Profession', widget.userModel.profession),
            detail('Company', widget.userModel.company),
            detail('Institute', widget.userModel.institute),
            detail(
                'Graduation Year', widget.userModel.graduationYear.toString()),
            detail('Current City', widget.userModel.currentCity),
            detail('Home City', widget.userModel.homeCity),
            connectButton(widget.userModel.id)
          ],
        ),
      ),
    );
  }

  Widget detail(String columnName, String info) {
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.safeBlockHorizontal * 3),
        margin: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 1.5),
        child: Text(
          info != null ? '$columnName : $info' : '',
          style: GoogleFonts.ptSans(
              textStyle: TextStyle(fontSize: SizeConfig.font_size * 5)),
        ));
  }

  Widget connectButton(String id) {
    bool requestSent;
    return new Container(
      margin: EdgeInsets.symmetric(
          vertical: SizeConfig.safeBlockVertical * 3,
          horizontal: SizeConfig.safeBlockHorizontal * 20),
      height: SizeConfig.blockSizeVertical * 8,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(80), color: Colors.greenAccent),
      child: new RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
        color: widget.fromPeoplesPage ? Colors.indigo[400] : Colors.red,
        elevation: 0,
        onPressed: widget.fromPeoplesPage
            ? () async {
                print('Connect');
                requestSent = await userServices.sendConnectionRequest(id);
                print('requestSent : $requestSent');
              }
            : () {
                print('Disconnect');
              },
        child: new Text(
          widget.fromPeoplesPage ? 'Connect' : 'Disconnect',
          style: TextStyle(
              color: Colors.white, fontSize: SizeConfig.font_size * 5),
        ),
      ),
    );
  }
}
