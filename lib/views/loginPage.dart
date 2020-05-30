import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learn_live_app/main.dart';
import 'package:learn_live_app/services/userServices.dart';
import 'package:learn_live_app/utils/sizeConfig.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

TextStyle inputTextStyle = TextStyle(
    fontSize: SizeConfig.font_size * 4.5,
    fontWeight: FontWeight.w600,
    color: Colors.deepPurpleAccent[400]);

TextStyle hintStyle = TextStyle(fontSize: SizeConfig.font_size * 4.5);

class _LoginPageState extends State<LoginPage> {
  TextEditingController _phoneNumber = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  bool filled = false;
  UserServices userServices;
  String phoneNumber = '', password = '';

  @override
  void initState() {
    userServices = new UserServices();
    super.initState();
  }

  loginProcess() async {
    bool isLogin = await userServices.login(phoneNumber, password);
    if (isLogin) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => LearnLiveApp()));
    }
  }

  void checkFilled() {
    phoneNumber = _phoneNumber.text;
    password = _password.text;
    if (_phoneNumber != null &&
        _password != null &&
        phoneNumber.isNotEmpty &&
        password.isNotEmpty) {
      setState(() {
        filled = true;
      });
    } else {
      setState(() {
        filled = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        child: ListView(
          children: <Widget>[
            new Container(
              padding: EdgeInsets.only(
                  right: SizeConfig.safeBlockHorizontal * 70,
                  top: SizeConfig.safeBlockVertical * 2),
              child: new CircleAvatar(
                radius: SizeConfig.blockSizeVertical * 2.2,
                backgroundColor: Colors.indigoAccent,
                child: new IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back_ios,
                      color: Colors.white,
                      size: SizeConfig.safeBlockVertical * 2.5),
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 5,
            ),
            new Container(
              height: SizeConfig.blockSizeVertical * 40,
              padding: EdgeInsets.all(2),
              child: SvgPicture.asset('assets/login_page.svg'),
            ),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 5,
            ),
            new Container(
                height: SizeConfig.blockSizeVertical * 6,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.black12),
                margin: EdgeInsets.symmetric(
                  horizontal: SizeConfig.safeBlockHorizontal * 7,
                ),
                padding: EdgeInsets.only(
                    left: SizeConfig.safeBlockHorizontal * 3,
                    top: SizeConfig.safeBlockVertical * 0.25),
                child: new TextField(
                  controller: _phoneNumber,
                  style: inputTextStyle,
                  keyboardType: TextInputType.number,
                  cursorWidth: 2,
                  cursorColor: Colors.indigo,
                  decoration: InputDecoration(
                    hintText: 'Phone Number',
                    hintStyle: hintStyle,
                    border: InputBorder.none,
                    icon: Icon(
                      Icons.phone,
                      size: SizeConfig.safeBlockVertical * 3.5,
                    ),
                  ),
                  onChanged: (val) {
                    checkFilled();
                  },
                )),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 2,
            ),
            new Container(
                height: SizeConfig.blockSizeVertical * 6,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.black12),
                margin: EdgeInsets.symmetric(
                  horizontal: SizeConfig.safeBlockHorizontal * 7,
                ),
                padding: EdgeInsets.only(
                    left: SizeConfig.safeBlockHorizontal * 3,
                    top: SizeConfig.safeBlockVertical * 0.25),
                child: new TextField(
                  controller: _password,
                  style: inputTextStyle,
                  keyboardType: TextInputType.text,
                  cursorWidth: 2,
                  cursorColor: Colors.indigo,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: hintStyle,
                    border: InputBorder.none,
                    icon: Icon(
                      Icons.lock,
                      size: SizeConfig.safeBlockVertical * 3.5,
                    ),
                  ),
                  onChanged: (val) {
                    checkFilled();
                  },
                )),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 5,
            ),
            new Container(
              height: SizeConfig.blockSizeVertical * 6,
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.safeBlockHorizontal * 25,
              ),
              child: new RaisedButton(
                // onPressed: filled ? loginProcess() : null,
                onPressed: filled
                    ? () {
                        loginProcess();
                      }
                    : null,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Colors.indigo[300],
                elevation: 0,
                child: new Container(
                  child: new Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: SizeConfig.font_size * 4.5),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
