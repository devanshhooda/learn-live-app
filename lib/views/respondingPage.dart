import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_live_app/models/userModel.dart';
import 'package:learn_live_app/services/userServices.dart';
import 'package:learn_live_app/utils/sizeConfig.dart';

class RespondingPage extends StatefulWidget {
  UserModel userModel;

  RespondingPage({this.userModel});
  @override
  _RespondingPageState createState() => _RespondingPageState();
}

class _RespondingPageState extends State<RespondingPage> {
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
        title: Text(
            widget.userModel.name != null ? '${widget.userModel.name}' : ''),
      ),
      body: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: SizeConfig.safeBlockVertical * 3,
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
            SizedBox(
              height: SizeConfig.safeBlockVertical * 2,
            ),
            acceptButton(),
            declineButton()
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

  Widget acceptButton() {
    bool requestAccepted;
    return new Container(
      margin: EdgeInsets.symmetric(
          vertical: SizeConfig.safeBlockVertical * 1,
          horizontal: SizeConfig.safeBlockHorizontal * 20),
      height: SizeConfig.blockSizeVertical * 8,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(80), color: Colors.greenAccent),
      child: new RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
        color: Colors.green,
        elevation: 0,
        onPressed: () async {
          print('Accept Request');
          requestAccepted = await userServices.respondConnectionRequest(
              widget.userModel.id, true);
          print('requestAccepted : $requestAccepted');
        },
        child: new Text(
          'Accept Request',
          style: TextStyle(
              color: Colors.white, fontSize: SizeConfig.font_size * 5),
        ),
      ),
    );
  }

  Widget declineButton() {
    bool requestDeclined;
    return new Container(
      margin: EdgeInsets.symmetric(
          vertical: SizeConfig.safeBlockVertical * 1,
          horizontal: SizeConfig.safeBlockHorizontal * 20),
      height: SizeConfig.blockSizeVertical * 8,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(80), color: Colors.greenAccent),
      child: new RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
        color: Colors.red,
        elevation: 0,
        onPressed: () async {
          print('Decline Request');
          requestDeclined = await userServices.respondConnectionRequest(
              widget.userModel.id, false);
          print('requestDeclined : $requestDeclined');
        },
        child: new Text(
          'Decline Request',
          style: TextStyle(
              color: Colors.white, fontSize: SizeConfig.font_size * 5),
        ),
      ),
    );
  }
}
