import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tagging/flutter_tagging.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learn_live_app/main.dart';
import 'package:learn_live_app/models/skillsModel.dart';
import 'package:learn_live_app/services/userServices.dart';
import 'package:learn_live_app/utils/sizeConfig.dart';
import 'loginPage.dart';

class EnterDetailsPage extends StatefulWidget {
  @override
  _EnterDetailsPageState createState() => _EnterDetailsPageState();
}

class _EnterDetailsPageState extends State<EnterDetailsPage> {
  TextEditingController _name = new TextEditingController();
  TextEditingController _age = new TextEditingController();
  TextEditingController _profession = new TextEditingController();
  TextEditingController _company = new TextEditingController();
  TextEditingController _institute = new TextEditingController();
  TextEditingController _graduationYear = new TextEditingController();
  TextEditingController _currentCity = new TextEditingController();
  TextEditingController _homeCity = new TextEditingController();

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
            Center(
              child: new Container(
                child: Text(
                  'Enter your details : ',
                  style: GoogleFonts.laila(
                      textStyle: TextStyle(fontSize: SizeConfig.font_size * 5)),
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 3,
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
                  controller: _name,
                  style: inputTextStyle,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  cursorWidth: 2,
                  cursorColor: Colors.indigo,
                  decoration: InputDecoration(
                    hintText: 'Name',
                    hintStyle: hintStyle,
                    border: InputBorder.none,
                    icon: Icon(
                      Icons.person,
                      size: SizeConfig.safeBlockVertical * 3.5,
                    ),
                  ),
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
                  controller: _age,
                  style: inputTextStyle,
                  keyboardType: TextInputType.datetime,
                  cursorWidth: 2,
                  cursorColor: Colors.indigo,
                  decoration: InputDecoration(
                    hintText: 'Age',
                    hintStyle: hintStyle,
                    border: InputBorder.none,
                    icon: Icon(
                      Icons.date_range,
                      size: SizeConfig.safeBlockVertical * 3.5,
                    ),
                  ),
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
                  controller: _profession,
                  style: inputTextStyle,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  cursorWidth: 2,
                  cursorColor: Colors.indigo,
                  decoration: InputDecoration(
                    hintText: 'Profession',
                    hintStyle: hintStyle,
                    border: InputBorder.none,
                    icon: Icon(
                      Icons.portrait,
                      size: SizeConfig.safeBlockVertical * 3.5,
                    ),
                  ),
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
                  controller: _institute,
                  style: inputTextStyle,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  cursorWidth: 2,
                  cursorColor: Colors.indigo,
                  decoration: InputDecoration(
                    hintText: 'Institute',
                    hintStyle: hintStyle,
                    border: InputBorder.none,
                    icon: Icon(
                      Icons.school,
                      size: SizeConfig.safeBlockVertical * 3.5,
                    ),
                  ),
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
                  controller: _graduationYear,
                  style: inputTextStyle,
                  keyboardType: TextInputType.datetime,
                  cursorWidth: 2,
                  cursorColor: Colors.indigo,
                  decoration: InputDecoration(
                    hintText: 'Graduation Year',
                    hintStyle: hintStyle,
                    border: InputBorder.none,
                    icon: Icon(
                      Icons.calendar_today,
                      size: SizeConfig.safeBlockVertical * 3.5,
                    ),
                  ),
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
                  controller: _company,
                  style: inputTextStyle,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  cursorWidth: 2,
                  cursorColor: Colors.indigo,
                  decoration: InputDecoration(
                    hintText: 'Company',
                    hintStyle: hintStyle,
                    border: InputBorder.none,
                    icon: Icon(
                      Icons.work,
                      size: SizeConfig.safeBlockVertical * 3.5,
                    ),
                  ),
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
                  controller: _currentCity,
                  style: inputTextStyle,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  cursorWidth: 2,
                  cursorColor: Colors.indigo,
                  decoration: InputDecoration(
                    hintText: 'Current City',
                    hintStyle: hintStyle,
                    border: InputBorder.none,
                    icon: Icon(
                      Icons.place,
                      size: SizeConfig.safeBlockVertical * 3.5,
                    ),
                  ),
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
                  controller: _homeCity,
                  style: inputTextStyle,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  cursorWidth: 2,
                  cursorColor: Colors.indigo,
                  decoration: InputDecoration(
                    hintText: 'Home City',
                    hintStyle: hintStyle,
                    border: InputBorder.none,
                    icon: Icon(
                      Icons.home,
                      size: SizeConfig.safeBlockVertical * 3.5,
                    ),
                  ),
                )),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 3,
            ),
            new Container(
              height: SizeConfig.blockSizeVertical * 6,
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.safeBlockHorizontal * 25,
              ),
              child: new RaisedButton(
                onPressed: () {
                  print('Next');

                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ChooseProfileImage(
                            name: _name.text,
                            age: _age.text,
                            profession: _profession.text,
                            institute: _institute.text,
                            graduationYear: _graduationYear.text,
                            company: _company.text,
                            currentCity: _currentCity.text,
                            homeCity: _homeCity.text,
                          )));
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Colors.indigo[300],
                elevation: 0,
                child: new Container(
                  child: new Text(
                    'Next',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: SizeConfig.font_size * 4.5),
                  ),
                ),
              ),
            ),
            // SizedBox(
            //   height: SizeConfig.safeBlockVertical * 3,
            // ),
            // new Container(
            //   decoration: BoxDecoration(
            //       color: Colors.black12,
            //       borderRadius: BorderRadius.circular(20)),
            //   margin: EdgeInsets.only(
            //       left: SizeConfig.safeBlockHorizontal * 50,
            //       right: SizeConfig.safeBlockHorizontal * 5),
            //   child: FlatButton(
            //       onPressed: () {
            //         print('Skip');
            //         Navigator.of(context).push(MaterialPageRoute(
            //             builder: (context) => ChooseProfileImage()));
            //       },
            //       child: Text(
            //         'Skip',
            //         style: TextStyle(
            //             color: Colors.blue, fontSize: SizeConfig.font_size * 4),
            //       )),
            // ),
          ],
        ),
      ),
    );
  }
}

class ChooseProfileImage extends StatefulWidget {
  String name = '',
      age = '',
      profession = '',
      company = '',
      institute = '',
      graduationYear = '',
      currentCity = '',
      homeCity = '';
  String phoneNumber;

  ChooseProfileImage(
      {this.name,
      this.age,
      this.profession,
      this.institute,
      this.graduationYear,
      this.company,
      this.currentCity,
      this.homeCity});
  @override
  _ChooseProfileImageState createState() => _ChooseProfileImageState();
}

class _ChooseProfileImageState extends State<ChooseProfileImage> {
  List<Skills> _selectedSkills = new List<Skills>();
  List skills = new List();
  String skill;
  File _imageFile;
  TextEditingController _bio = new TextEditingController();
  UserServices userServices;

  @override
  void initState() {
    userServices = new UserServices();
    super.initState();
  }

  Future<void> getImage(int i) async {
    var image;
    try {
      if (i == 0) {
        image =
            await ImagePicker.platform.pickImage(source: ImageSource.camera);
      } else if (i == 1) {
        image =
            await ImagePicker.platform.pickImage(source: ImageSource.gallery);
      }
    } catch (e) {
      print(e.toString());
    }

    setState(() {
      _imageFile = image;
    });
    Navigator.of(context).pop();
  }

  updateProcess() async {
    Map<String, dynamic> details = new Map<String, dynamic>();
    if (widget.name != null && widget.name.isNotEmpty) {
      details['name'] = widget.name;
    }
    if (widget.age != null && widget.age.isNotEmpty) {
      // details['age'] = int.parse(widget.age);
      details['age'] = widget.age;
    }
    if (widget.profession != null && widget.profession.isNotEmpty) {
      details['profession'] = widget.profession;
    }
    if (widget.institute != null && widget.institute.isNotEmpty) {
      details['institute'] = widget.institute;
    }
    if (widget.graduationYear != null && widget.graduationYear.isNotEmpty) {
      // details['graduationYear'] = int.parse(widget.graduationYear);
      details['graduationYear'] = widget.graduationYear;
    }
    if (widget.company != null && widget.company.isNotEmpty) {
      details['company'] = widget.company;
    }
    if (widget.currentCity != null && widget.currentCity.isNotEmpty) {
      details['currentCity'] = widget.currentCity;
    }
    if (widget.homeCity != null && widget.homeCity.isNotEmpty) {
      details['homeCity'] = widget.homeCity;
    }
    if (_bio != null && _bio.text.isNotEmpty) {
      details['bio'] = _bio.text;
    }

    if (_selectedSkills != null && _selectedSkills.isNotEmpty) {
      for (var s in _selectedSkills) {
        if (!skills.contains(s.name)) skills.add(s.name);
      }
      if (skills != null && skills.isNotEmpty) {
        details['interests'] = skills;
      }
    }

    print('details to be updated : $details');

    bool isUpdated = await userServices.updateDetails(details);

    if (isUpdated) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LearnLiveApp()),
          ModalRoute.withName(''));
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
            Center(
              child: Text(
                'Choose your profile pic by clicking below',
                style: TextStyle(
                  fontSize: SizeConfig.font_size * 4,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 2,
            ),
            GestureDetector(
              child: new CircleAvatar(
                radius: SizeConfig.safeBlockVertical * 15,
                child: _imageFile == null
                    ? SvgPicture.asset('assets/profile_pic.svg')
                    : Image.file(
                        _imageFile,
                        fit: BoxFit.fill,
                      ),
              ),
              onTap: () {
                print('Select Image');
                showDialog(
                    context: context,
                    child: AlertDialog(
                      title: Center(child: Text('Choose one method')),
                      titleTextStyle: TextStyle(
                          color: Colors.deepPurpleAccent,
                          fontSize: SizeConfig.font_size * 5,
                          fontWeight: FontWeight.w400),
                      actionsPadding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.safeBlockHorizontal * 15),
                      actions: <Widget>[
                        IconButton(
                            color: Colors.deepPurpleAccent,
                            iconSize: SizeConfig.safeBlockVertical * 6,
                            icon: Icon(Icons.camera_alt),
                            onPressed: () async {
                              await getImage(0);
                            }),
                        IconButton(
                            color: Colors.deepPurpleAccent,
                            iconSize: SizeConfig.safeBlockVertical * 6,
                            icon: Icon(Icons.image),
                            onPressed: () async {
                              await getImage(1);
                            }),
                      ],
                    ));
              },
            ),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 5,
            ),
            new Container(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.safeBlockHorizontal * 10),
              child: TextField(
                controller: _bio,
                minLines: 1,
                maxLines: 5,
                style: inputTextStyle,
                decoration:
                    InputDecoration(hintText: 'Add Bio', hintStyle: hintStyle),
              ),
            ),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 5,
            ),
            Center(
              child: Text(
                'Add you skills/interests :',
                style: TextStyle(
                  fontSize: SizeConfig.font_size * 4,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 2,
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: SizeConfig.safeBlockHorizontal * 10,
              ),
              child: FlutterTagging<Skills>(
                  initialItems: _selectedSkills,
                  textFieldConfiguration: TextFieldConfiguration(
                      style: inputTextStyle,
                      onChanged: (val) {
                        skill = val;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          filled: true,
                          fillColor: Colors.black12,
                          hintText: 'Search Skills',
                          hintStyle: hintStyle)),
                  findSuggestions: SkillsModel.getSkills,
                  additionCallback: (value) {
                    return Skills(
                      name: value,
                    );
                  },
                  onAdded: (skill) {
                    print(_selectedSkills);
                    return Skills();
                  },
                  configureSuggestion: (skl) {
                    return SuggestionConfiguration(
                      title: Text(skl.name),
                      additionWidget: Chip(
                        avatar: Icon(
                          Icons.add_circle,
                          color: Colors.white,
                          size: SizeConfig.safeBlockVertical * 2.5,
                        ),
                        label: Text('Add new'),
                        labelStyle: TextStyle(
                          color: Colors.white,
                          fontSize: SizeConfig.font_size * 3,
                          fontWeight: FontWeight.w300,
                        ),
                        backgroundColor: Colors.indigo[300],
                      ),
                    );
                  },
                  configureChip: (skl) {
                    return ChipConfiguration(
                      label: Text(skl.name != null ? skl.name : skill),
                      backgroundColor: Colors.indigo[300],
                      labelStyle: TextStyle(color: Colors.white),
                      deleteIconColor: Colors.white,
                    );
                  },
                  onChanged: () {}),
            ),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 10,
            ),
            new Container(
              height: SizeConfig.blockSizeVertical * 6,
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.safeBlockHorizontal * 25,
              ),
              child: new RaisedButton(
                onPressed: () async {
                  print('Finish');
                  await updateProcess();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Colors.indigo[300],
                elevation: 0,
                child: new Container(
                  child: new Text(
                    'Finish',
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
