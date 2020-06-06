import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tagging/flutter_tagging.dart';
import 'package:learn_live_app/models/companyFilterModel.dart';
import 'package:learn_live_app/models/instituteFiltersModel.dart';
import 'package:learn_live_app/models/professionFiltersModel.dart';
import 'package:learn_live_app/models/userModel.dart';
import 'package:learn_live_app/services/userServices.dart';
import 'package:learn_live_app/utils/sizeConfig.dart';
import 'package:learn_live_app/views/userProfilesPage.dart';
import 'loginPage.dart';

class PeoplePage extends StatefulWidget {
  @override
  _PeoplePageState createState() => _PeoplePageState();
}

class _PeoplePageState extends State<PeoplePage> {
  UserServices userServices;
  // TextEditingController _search = new TextEditingController();
  // List<String> professionFilters = new List<String>();
  // List<String> companyFilters = new List<String>();
  // List<String> instituteFilters = new List<String>();
  List<ProfessionsFilter> professionsList = new List<ProfessionsFilter>();
  List<CompanyFilter> companyList = new List<CompanyFilter>();
  List<InstituteFilter> institutesList = new List<InstituteFilter>();
  List selectedProfessions = new List();
  List selectedCompanies = new List();
  List selectedInstitutes = new List();
  String profession = '', company = '', institute = '';
  Map<String, dynamic> filters = new Map<String, dynamic>();
  bool filterApplied = false;

  applyFilters() {
    if (filters.isNotEmpty) {
      setState(() {
        filterApplied = true;
      });
    } else {
      setState(() {
        filterApplied = false;
      });
    }
    print('$filters');
  }

  @override
  void initState() {
    userServices = new UserServices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          child: Column(
            children: <Widget>[
              Container(
                  color: Colors.purple[100],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      // filters(context, 'Profession', 0),
                      // filters(context, 'Company', 1),
                      // filters(context, 'Institute', 2),
                      FlatButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              child: AlertDialog(
                                title: Container(
                                  child: Text('Search Profession :'),
                                  margin: EdgeInsets.symmetric(
                                      horizontal:
                                          SizeConfig.safeBlockHorizontal * 10),
                                ),
                                content: FlutterTagging<ProfessionsFilter>(
                                    initialItems: professionsList,
                                    textFieldConfiguration:
                                        TextFieldConfiguration(
                                            style: inputTextStyle,
                                            onChanged: (val) {
                                              profession = val;
                                            },
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                filled: true,
                                                fillColor: Colors.black12,
                                                hintText: 'Search',
                                                hintStyle: hintStyle)),
                                    findSuggestions:
                                        ProfessionsFiltersModel.getFilters,
                                    additionCallback: (value) {
                                      return ProfessionsFilter(
                                        name: value,
                                      );
                                    },
                                    onAdded: (profession) {
                                      print(professionsList);
                                      return ProfessionsFilter();
                                    },
                                    configureSuggestion: (prfsn) {
                                      return SuggestionConfiguration(
                                        title: Text(prfsn.name),
                                        additionWidget: Chip(
                                          avatar: Icon(
                                            Icons.add_circle,
                                            color: Colors.white,
                                            size: SizeConfig.safeBlockVertical *
                                                2.5,
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
                                    configureChip: (prfsn) {
                                      return ChipConfiguration(
                                        label: Text(prfsn.name != null
                                            ? prfsn.name
                                            : profession),
                                        backgroundColor: Colors.indigo[300],
                                        labelStyle:
                                            TextStyle(color: Colors.white),
                                        deleteIconColor: Colors.white,
                                      );
                                    },
                                    onChanged: () {}),
                                actions: <Widget>[
                                  FlatButton(
                                      onPressed: () {
                                        if (professionsList != null &&
                                            professionsList.isNotEmpty) {
                                          for (var p in professionsList) {
                                            if (!selectedProfessions
                                                .contains(p.name))
                                              selectedProfessions.add(p.name);
                                            else
                                              selectedProfessions
                                                  .remove(p.name);
                                          }
                                          if (selectedProfessions != null &&
                                              selectedProfessions.isNotEmpty) {
                                            filters['profession'] =
                                                selectedProfessions;
                                          }
                                        }
                                        print(selectedProfessions);
                                        applyFilters();
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Done')),
                                  // FlatButton(
                                  //     onPressed: () {
                                  //       Navigator.of(context).pop();
                                  //     },
                                  //     child: Text('Cancel'))
                                ],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                            );
                          },
                          child: Text('Profession')),
                      FlatButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              child: AlertDialog(
                                title: Text('Search Company :'),
                                content: FlutterTagging<CompanyFilter>(
                                    initialItems: companyList,
                                    textFieldConfiguration:
                                        TextFieldConfiguration(
                                            style: inputTextStyle,
                                            onChanged: (val) {
                                              company = val;
                                            },
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                filled: true,
                                                fillColor: Colors.black12,
                                                hintText: 'Search',
                                                hintStyle: hintStyle)),
                                    findSuggestions:
                                        CompanyFiltersSModel.getFilters,
                                    additionCallback: (value) {
                                      return CompanyFilter(
                                        name: value,
                                      );
                                    },
                                    onAdded: (company) {
                                      print(companyList);
                                      return CompanyFilter();
                                    },
                                    configureSuggestion: (cmpny) {
                                      return SuggestionConfiguration(
                                        title: Text(cmpny.name),
                                        additionWidget: Chip(
                                          avatar: Icon(
                                            Icons.add_circle,
                                            color: Colors.white,
                                            size: SizeConfig.safeBlockVertical *
                                                2.5,
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
                                    configureChip: (cmpny) {
                                      return ChipConfiguration(
                                        label: Text(cmpny.name != null
                                            ? cmpny.name
                                            : company),
                                        backgroundColor: Colors.indigo[300],
                                        labelStyle:
                                            TextStyle(color: Colors.white),
                                        deleteIconColor: Colors.white,
                                      );
                                    },
                                    onChanged: () {}),
                                actions: <Widget>[
                                  FlatButton(
                                      onPressed: () {
                                        if (companyList != null &&
                                            companyList.isNotEmpty) {
                                          for (var c in companyList) {
                                            if (!selectedCompanies
                                                .contains(c.name))
                                              selectedCompanies.add(c.name);
                                            else
                                              selectedCompanies.remove(c.name);
                                          }
                                          if (selectedCompanies != null &&
                                              selectedCompanies.isNotEmpty) {
                                            filters['company'] =
                                                selectedCompanies;
                                          }
                                        }
                                        print(selectedCompanies);
                                        applyFilters();
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Done')),
                                  // FlatButton(
                                  //     onPressed: () {
                                  //       Navigator.of(context).pop();
                                  //     },
                                  //     child: Text('Cancel'))
                                ],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                            );
                          },
                          child: Text('Company')),
                      FlatButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              child: AlertDialog(
                                title: Text('Search Institute :'),
                                content: FlutterTagging<InstituteFilter>(
                                    initialItems: institutesList,
                                    textFieldConfiguration:
                                        TextFieldConfiguration(
                                            style: inputTextStyle,
                                            onChanged: (val) {
                                              institute = val;
                                            },
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                filled: true,
                                                fillColor: Colors.black12,
                                                hintText: 'Search',
                                                hintStyle: hintStyle)),
                                    findSuggestions:
                                        InstituteFiltersSModel.getFilters,
                                    additionCallback: (value) {
                                      return InstituteFilter(
                                        name: value,
                                      );
                                    },
                                    onAdded: (institute) {
                                      print(institutesList);
                                      return InstituteFilter();
                                    },
                                    configureSuggestion: (intut) {
                                      return SuggestionConfiguration(
                                        title: Text(intut.name),
                                        additionWidget: Chip(
                                          avatar: Icon(
                                            Icons.add_circle,
                                            color: Colors.white,
                                            size: SizeConfig.safeBlockVertical *
                                                2.5,
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
                                    configureChip: (intut) {
                                      return ChipConfiguration(
                                        label: Text(intut.name != null
                                            ? intut.name
                                            : company),
                                        backgroundColor: Colors.indigo[300],
                                        labelStyle:
                                            TextStyle(color: Colors.white),
                                        deleteIconColor: Colors.white,
                                      );
                                    },
                                    onChanged: () {}),
                                actions: <Widget>[
                                  FlatButton(
                                      onPressed: () {
                                        if (institutesList != null &&
                                            institutesList.isNotEmpty) {
                                          for (var i in institutesList) {
                                            if (!selectedInstitutes
                                                .contains(i.name))
                                              selectedInstitutes.add(i.name);
                                            else
                                              selectedInstitutes.remove(i.name);
                                          }
                                          if (selectedInstitutes != null &&
                                              selectedInstitutes.isNotEmpty) {
                                            filters['institute'] =
                                                selectedInstitutes;
                                          }
                                        }
                                        print(selectedInstitutes);
                                        applyFilters();
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Done')),
                                  // FlatButton(
                                  //     onPressed: () {
                                  //       Navigator.of(context).pop();
                                  //     },
                                  //     child: Text('Cancel'))
                                ],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                            );
                          },
                          child: Text('Institute')),
                    ],
                  )),
              Expanded(
                child: Container(
                    child: FutureBuilder<List<UserModel>>(
                  future: filterApplied
                      ? userServices.getUsersWithFilters(filters)
                      : userServices.getUsers(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<UserModel>> snapshot) {
                    if (snapshot.data != null && snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, i) {
                            return UserWidget(userModel: snapshot.data[i]);
                          });
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                )),
              ),
            ],
          )),
    );
  }

  // Widget filters(BuildContext context, String filterName, int i) {
  //   return FlatButton(
  //       onPressed: () {
  //         showDialog(
  //           context: context,
  //           child: AlertDialog(
  //             title: Text('Search $filterName :'),
  //             content: TextField(
  //               controller: _search,
  //               style: TextStyle(fontSize: SizeConfig.font_size * 4),
  //               decoration: InputDecoration(
  //                   hintText: 'Search',
  //                   hintStyle: TextStyle(fontSize: SizeConfig.font_size * 4),
  //                   suffixIcon: IconButton(
  //                       icon: Icon(Icons.arrow_forward_ios),
  //                       iconSize: SizeConfig.safeBlockVertical * 2,
  //                       onPressed: () {
  //                         String searchText = _search.text;
  //                         if (filterName == 'Profession') {
  //                           professionFilters.add(searchText);
  //                         } else if (filterName == 'Company') {
  //                           companyFilters.add(searchText);
  //                         } else if (filterName == 'Institute') {
  //                           instituteFilters.add(searchText);
  //                         }
  //                       })),
  //             ),

  //             actions: <Widget>[
  //               FlatButton(
  //                   onPressed: () {
  //                     Navigator.of(context).pop();
  //                   },
  //                   child: Text('Apply')),
  //               FlatButton(
  //                   onPressed: () {
  //                     Navigator.of(context).pop();
  //                   },
  //                   child: Text('Cancel'))
  //             ],
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(20)),
  //           ),
  //         );
  //       },
  //       child: Text('$filterName'));
  // }
}

class UserWidget extends StatelessWidget {
  UserModel userModel;
  UserWidget({@required this.userModel});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
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
                Text(userModel.name != null ? '${userModel.name}, ' : ''),
                Text(userModel.age != null ? '${userModel.age}' : '')
              ],
            ),
            subtitle: Row(
              children: <Widget>[
                Text(userModel.profession != null
                    ? '${userModel.profession}, '
                    : ''),
                Text(userModel.company != null ? '${userModel.company}' : '')
              ],
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => UserProfilesPage(
                        userModel: userModel,
                        i: true,
                      )));
            },
          ),
          Padding(
            padding: EdgeInsets.only(
              left: SizeConfig.safeBlockHorizontal * 5,
              right: SizeConfig.safeBlockHorizontal * 5,
            ),
            child: Divider(),
          ),
        ],
      ),
    );
  }
}
