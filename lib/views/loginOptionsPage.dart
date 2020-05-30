import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_live_app/utils/sizeConfig.dart';
import 'package:learn_live_app/views/signUpPage.dart';
import 'loginPage.dart';

class LoginOptionsPage extends StatefulWidget {
  @override
  _LoginOptionsPageState createState() => _LoginOptionsPageState();
}

class _LoginOptionsPageState extends State<LoginOptionsPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
              child: Text(
                'Welcome to Learn Live',
                style: GoogleFonts.breeSerif(
                    textStyle: TextStyle(fontSize: SizeConfig.font_size * 6.5)),
              ),
            ),
            new Container(
              height: SizeConfig.blockSizeVertical * 40,
              padding: EdgeInsets.all(2),
              child: SvgPicture.asset('assets/login_logo.svg'),
            ),
            new Container(
              width: SizeConfig.blockSizeHorizontal * 100,
              padding: EdgeInsets.only(
                left: SizeConfig.safeBlockHorizontal * 1,
                right: SizeConfig.safeBlockHorizontal * 1,
              ),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.only(top: SizeConfig.safeBlockVertical * 2),
                  ),
                  new Container(
                    height: SizeConfig.blockSizeVertical * 8,
                    width: SizeConfig.blockSizeHorizontal * 45,
                    child: new Container(
                      height: SizeConfig.blockSizeVertical * 8.5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80),
                          color: Colors.indigo[300]),
                      child: new MaterialButton(
                        onPressed: () {
                          print('Sign Up page');
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SignUpPage()));
                        },
                        child: new Text(
                          'Sign Up',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: SizeConfig.font_size * 6),
                        ),
                      ),
                    ),
                  ),
                  new Container(
                    padding:
                        EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
                    child: new Container(
                      child: new Text(
                        'OR',
                        style: TextStyle(
                            letterSpacing: 2,
                            color: Colors.indigoAccent[200],
                            fontSize: SizeConfig.font_size * 4.5,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: SizeConfig.safeBlockVertical * 2),
                  ),
                  new Container(
                    child: new Container(
                      height: SizeConfig.blockSizeVertical * 8,
                      width: SizeConfig.blockSizeHorizontal * 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80),
                          color: Colors.indigo[300]),
                      child: new MaterialButton(
                        onPressed: () {
                          print('Login Page');
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LoginPage()));
                        },
                        child: new Text(
                          'Login',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: SizeConfig.font_size * 6),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
