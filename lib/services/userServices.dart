import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class UserServices with ChangeNotifier {
  String url = 'http://192.168.43.223:3000/api/user';
  String token;
  var userDetails;

  Future<bool> signUp(String phoneNumber, String password) async {
    print(phoneNumber);
    print(password);
    String signUpUrl = url + '/create';
    try {
      http.Response response = await http.post(signUpUrl,
          body: {'phoneNumber': phoneNumber, 'password': password});
      var data = json.decode(response.body);
      token = data['token'];
      print('message : ${data['message']}');
      if (data['status']) {
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
    String updateUpUrl = url + '/update?phoneNumber=$phoneNumber';
    try {
      http.Response response = await http.post(updateUpUrl,
          headers: <String, String>{'Authorization': 'jwt ' + token},
          body: newdetails);
      var data = json.decode(response.body);
      token = data['token'];
      userDetails = data['userDetails'];
      print(data);
      print('previousDetails : $userDetails');
      print('newDetails : $newdetails');
      print('message : ${data['message']}');
      if (data['status']) {
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
    // print('login');
    // print('login phn : $phoneNumber');
    // print('login pwd : $password');
    String loginUrl = url + '/login';
    try {
      http.Response response = await http.post(loginUrl,
          body: {'phoneNumber': phoneNumber, 'password': password});
      var data = json.decode(response.body);
      token = data['token'];
      userDetails = data['userDetails'];
      print(data);
      print('userDetails : $userDetails');
      print('message : ${data['message']}');
      if (data['status']) {
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
}
