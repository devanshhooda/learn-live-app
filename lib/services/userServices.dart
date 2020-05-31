import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:learn_live_app/models/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserServices with ChangeNotifier {
  String url = 'http://192.168.43.223:3000/api/user';
  String token;
  var userDetails;
  SharedPreferences sharedPreferences;

  addTokenToSP(String token) async {
    // print("Add Token: $token");
    if (sharedPreferences == null) {
      sharedPreferences = await SharedPreferences.getInstance();
    }
    sharedPreferences.setString('token', token);
  }

  getTokenFromSP() async {
    if (sharedPreferences == null) {
      sharedPreferences = await SharedPreferences.getInstance();
    }
    String _token = sharedPreferences.getString('token');
    // print("Get Token: $_token");
    return _token;
  }

  addUserStatusToSP() async {
    if (sharedPreferences == null) {
      sharedPreferences = await SharedPreferences.getInstance();
    }
    sharedPreferences.setBool('userExist', true);
  }

  getUserStatusFromSP() async {
    if (sharedPreferences == null) {
      sharedPreferences = await SharedPreferences.getInstance();
    }
    bool _status = sharedPreferences.getBool('userExist');
    return _status;
  }

  Future<bool> signUp(String phoneNumber, String password) async {
    print(phoneNumber);
    print(password);
    String signUpUrl = url + '/create';
    try {
      http.Response response = await http.post(signUpUrl,
          body: {'phoneNumber': phoneNumber, 'password': password});
      var data = json.decode(response.body);
      print('message : ${data['message']}');
      if (data['status']) {
        token = data['token'];
        await addTokenToSP(token);
        await addUserStatusToSP();
        return true;
      } else {
        print('error : ${data['error']}');
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> updateDetails(String phoneNumber, var newdetails) async {
    print('rcvd details : $newdetails');
    print(phoneNumber);
    String updateUpUrl = url + '/update?phoneNumber=$phoneNumber';
    try {
      token = await getTokenFromSP();
      var body = json.encode(newdetails);
      print('body to parse : $body');
      http.Response response = await http.put(updateUpUrl,
          headers: <String, String>{'Authorization': 'jwt ' + token},
          body: body);
      print(response.body);
      var data = json.decode(response.body);
      userDetails = data['userDetails'];
      print(data);
      print('previousDetails : $userDetails');
      print('message : ${data['message']}');
      if (data['status']) {
        token = data['token'];
        await addTokenToSP(token);
        return true;
      } else {
        print('error : ${data['error']}');
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> login(String phoneNumber, String password) async {
    String loginUrl = url + '/login';
    try {
      http.Response response = await http.post(loginUrl,
          body: {'phoneNumber': phoneNumber, 'password': password});
      var data = json.decode(response.body);
      userDetails = data['userDetails'];
      print(data);
      print('userDetails : $userDetails');
      print('message : ${data['message']}');
      if (data['status']) {
        token = data['token'];
        await addTokenToSP(token);
        await addUserStatusToSP();
        return true;
      } else {
        print('error : ${data['error']}');
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<List<UserModel>> getUsers() async {
    // String profession, String company, String institute) async {
    UserModel userModel;
    List<UserModel> usersList;
    String showAllUrl = url + '/showAll';
    // String showAllUrl = url +
    //     '/showAll?profession=$profession&company=$company&institute=$institute';
    token = await getTokenFromSP();
    http.Response response = await http.get(showAllUrl,
        headers: <String, String>{'Authorization': 'jwt ' + token});
    print('response : ${response.body}');
    var data = await json.decode(response.body);
    print('data : $data');
    var users = data['users'];
    print('users : $users');
    print(users.length);
    for (var u in users) {
      userModel = UserModel(
        phoneNumber: u['phoneNumber'],
        // name: u['name'],
        // age: u['age'],
        // profession: u['profession'],
        // company: u['company'],
        // institute: u['institute'],
        // graduationYear: u['graduationYear'],
        // currentCity: u['currentCity'],
        // homeCity: u['homeCity']
      );
      usersList.add(userModel);
      print(usersList);
    }
    return usersList;
  }
}
