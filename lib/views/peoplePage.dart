import 'package:flutter/material.dart';
import 'package:learn_live_app/models/userModel.dart';
import 'package:learn_live_app/services/userServices.dart';
import 'package:learn_live_app/utils/sizeConfig.dart';

class PeoplePage extends StatefulWidget {
  @override
  _PeoplePageState createState() => _PeoplePageState();
}

class _PeoplePageState extends State<PeoplePage> {
  UserServices userServices;

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
        child: Container(
            child: FutureBuilder<List<UserModel>>(
          future: userServices.getUsers(),
          builder:
              (BuildContext context, AsyncSnapshot<List<UserModel>> snapshot) {
            if (snapshot.data != null && snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, i) {
                    return userWidget(snapshot.data[i].name);
                  });
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        )),
      ),
    );
  }

  Widget userWidget(String name) {
    return Container(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              child: Text(name != null ? name : 'Name'),
            ),
          ),
          Divider()
        ],
      ),
    );
  }
}
