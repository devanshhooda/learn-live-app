import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learn_live_app/models/userModel.dart';
import 'package:learn_live_app/utils/sizeConfig.dart';

class ConnectsPage extends StatefulWidget {
  List connectsList;

  ConnectsPage({this.connectsList});
  @override
  _ConnectsPageState createState() => _ConnectsPageState();
}

class _ConnectsPageState extends State<ConnectsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          child: (widget.connectsList != null && widget.connectsList.isNotEmpty)
              ? ListView.builder(itemBuilder: (context, i) {
                  return ListTile(
                    leading: CircleAvatar(
                      radius: SizeConfig.safeBlockVertical * 3.5,
                      child: SvgPicture.asset(
                        'assets/profile_pic.svg',
                      ),
                    ),
                    title: Text('${widget.connectsList[i]}'),
                  );
                })
              : Center(
                  child: Text('No Connections !'),
                )),
    );
  }
}
