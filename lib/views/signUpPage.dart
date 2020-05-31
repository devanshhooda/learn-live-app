import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learn_live_app/services/userServices.dart';
import 'package:learn_live_app/utils/sizeConfig.dart';
import 'package:learn_live_app/views/enterDetailsPage.dart';
import 'loginPage.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _phoneNumber = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  TextEditingController _confirmPassword = new TextEditingController();
  UserServices userServices;
  String message = '';
  bool filled = false, isMatch = false;
  String phoneNumber = '', password = '', confirmPassword = '';

  @override
  void initState() {
    userServices = new UserServices();
    super.initState();
  }

  // to check the existence of filled information
  void checkFilled() {
    phoneNumber = _phoneNumber.text;
    password = _password.text;
    confirmPassword = _confirmPassword.text;
    if (_phoneNumber != null &&
        _password != null &&
        _confirmPassword != null &&
        phoneNumber.isNotEmpty &&
        password.isNotEmpty &&
        confirmPassword.isNotEmpty) {
      setState(() {
        filled = true;
      });
    } else {
      setState(() {
        filled = false;
        message = '';
      });
    }
  }

  void isPassMatched() {
    if (password == confirmPassword) {
      setState(() {
        message = 'Password Matched';
        isMatch = true;
      });
    } else {
      setState(() {
        message = 'Password not Matched';
        isMatch = false;
      });
    }
  }

  // to confirm the password
  isPasswordMatch() {
    if (_password.text == _confirmPassword.text) {
      return true;
    } else {
      return false;
    }
  }

  signUpProcess() async {
    bool isSignedUp = await userServices.signUp(phoneNumber, password);
    if (isSignedUp) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => EnterDetailsPage(
                    phoneNumber: phoneNumber,
                  )),
          ModalRoute.withName('/'));
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
              height: SizeConfig.safeBlockVertical * 3,
            ),
            new Container(
              height: SizeConfig.blockSizeVertical * 40,
              padding: EdgeInsets.all(2),
              child: SvgPicture.asset('assets/sign_up.svg'),
            ),
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
                    isPassMatched();
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
                  controller: _confirmPassword,
                  style: inputTextStyle,
                  keyboardType: TextInputType.text,
                  cursorWidth: 2,
                  cursorColor: Colors.indigo,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    hintStyle: hintStyle,
                    border: InputBorder.none,
                    icon: Icon(
                      Icons.lock,
                      size: SizeConfig.safeBlockVertical * 3.5,
                    ),
                  ),
                  onChanged: (val) {
                    checkFilled();
                    isPassMatched();
                  },
                )),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 2,
            ),
            Center(
              child: new Container(
                child: Text(
                  '$message',
                  style: TextStyle(
                      fontSize: SizeConfig.font_size * 3,
                      color: isMatch ? Colors.green : Colors.red),
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 3,
            ),
            new Container(
              height: SizeConfig.blockSizeVertical * 6,
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.safeBlockHorizontal * 25,
              ),
              child: new RaisedButton(
                onPressed: filled
                    ? () async {
                        print('Sign Up');
                        if (isMatch) {
                          await signUpProcess();
                        }
                      }
                    : null,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Colors.indigo[300],
                elevation: 0,
                child: new Container(
                  child: new Text(
                    'Sign Up',
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
