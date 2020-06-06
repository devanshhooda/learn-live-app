import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:learn_live_app/models/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserServices with ChangeNotifier {
  String url = 'http://192.168.43.223:3000/api/user';
  String token, userId;
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

  addUserIdToSP(String id) async {
    if (sharedPreferences == null) {
      sharedPreferences = await SharedPreferences.getInstance();
    }
    sharedPreferences.setString('userId', id);
  }

  getUserIdFromSP() async {
    if (sharedPreferences == null) {
      sharedPreferences = await SharedPreferences.getInstance();
    }
    String _id = sharedPreferences.getString('userId');
    return _id;
  }

  Future<bool> signUp(String phoneNumber, String password) async {
    print(phoneNumber);
    print(password);
    String signUpUrl = url + '/create';
    try {
      http.Response response = await http.post(signUpUrl,
          body: {'phoneNumber': phoneNumber, 'password': password});
      var data = json.decode(response.body);
      print(data);
      print('message : ${data['message']}');
      if (data['status']) {
        userDetails = data['userDetails'];
        userId = userDetails['_id'];
        print('user id from api : $userId');
        token = data['token'];
        await addTokenToSP(token);
        await addUserIdToSP(userId);
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

  Future<bool> updateDetails(var newdetails) async {
    print('rcvd details : $newdetails');
    // print(phoneNumber);
    userId = await getUserIdFromSP();
    print('user id from sp : $userId');
    String updateUrl = url + '/update?userId=$userId';
    try {
      token = await getTokenFromSP();
      var body = json.encode(newdetails);
      print('body to parse : $body');
      http.Response response = await http.put(updateUrl,
          headers: <String, String>{
            'Authorization': 'jwt ' + token,
            "Content-Type": "application/json"
          },
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
      print(data);
      print('message : ${data['message']}');
      if (data['status']) {
        userDetails = data['userDetails'];
        print('userDetails : $userDetails');
        print(userDetails['_id']);
        userId = userDetails['_id'];
        print('user id : $userId');
        token = data['token'];
        await addTokenToSP(token);
        await addUserIdToSP(userId);
        userId = await getUserIdFromSP();
        print('user id from sp : $userId');
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

  Future<UserModel> getUser() async {
    try {
      userId = await getUserIdFromSP();
      String getUserUrl = url + '/getUser?userId=$userId';
      token = await getTokenFromSP();
      http.Response response = await http.get(getUserUrl,
          headers: <String, String>{'Authorization': 'jwt ' + token});
      print(response.body);
      var data = json.decode(response.body);
      userDetails = data['userDetails'];
      print('userDetails : $userDetails');
      print('message : ${data['message']}');
      if (data['status']) {
        UserModel userModel = new UserModel(
            id: userDetails['_id'],
            name: userDetails['name'],
            age: userDetails['age'],
            profession: userDetails['profession'],
            company: userDetails['company'],
            institute: userDetails['institute'],
            graduationYear: userDetails['graduationyear'],
            currentCity: userDetails['currentCity'],
            homeCity: userDetails['homeCity'],
            connects: userDetails['connects'],
            sentRequests: userDetails['sentRequests'],
            receivedRequests: userDetails['receivedRequests']);
        return userModel;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<UserModel> getUserByUid(String userId) async {
    try {
      String getUserUrl = url + '/getUser?userId=$userId';
      token = await getTokenFromSP();
      http.Response response = await http.get(getUserUrl,
          headers: <String, String>{'Authorization': 'jwt ' + token});
      print(response.body);
      var data = json.decode(response.body);
      userDetails = data['userDetails'];
      print('userDetails : $userDetails');
      print('message : ${data['message']}');
      if (data['status']) {
        UserModel userModel = new UserModel(
            id: userDetails['_id'],
            name: userDetails['name'],
            age: userDetails['age'],
            profession: userDetails['profession'],
            company: userDetails['company'],
            institute: userDetails['institute'],
            graduationYear: userDetails['graduationYear'],
            currentCity: userDetails['currentCity'],
            homeCity: userDetails['homeCity'],
            connects: userDetails['connects'],
            sentRequests: userDetails['sentRequests'],
            receivedRequests: userDetails['receivedRequests']);
        return userModel;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<UserModel>> getUsers() async {
    // String profession, String company, String institute) async {
    // UserModel userModel;
    // List<UserModel> usersList = new List<UserModel>();
    List<UserModel> usersList = [];
    String showAllUrl = url + '/showAll';
    // String showAllUrl = url +
    //     '/showAll?profession=$profession&company=$company&institute=$institute';
    try {
      token = await getTokenFromSP();
      // userId = await getUserIdFromSP();
      http.Response response = await http.get(showAllUrl,
          headers: <String, String>{'Authorization': 'jwt ' + token});
      // print('response : ${response.body}');
      var data = await json.decode(response.body);
      print('message : ${data['message']}');
      // print('data : $data');
      var users = data['users'];
      // print('users : $users');
      userId = await getUserIdFromSP();
      for (var u in users) {
        // print('adding $u');
        UserModel userModel = UserModel(
            id: u['_id'],
            phoneNumber: u['phoneNumber'],
            name: u['name'],
            age: u['age'],
            bio: u['bio'],
            profession: u['profession'],
            company: u['company'],
            institute: u['institute'],
            graduationYear: u['graduationYear'],
            currentCity: u['currentCity'],
            homeCity: u['homeCity']);
        if (userModel.id != userId) {
          usersList.add(userModel);
        }
        // usersList.add(userModel);
      }
      // usersList.shuffle();
      return usersList;
    } catch (e) {
      print(e);
    }
  }

  Future<List<UserModel>> getUsersWithFilters(var filters) async {
    String filterUsersUrl = url + '/showOnly';
    List<UserModel> usersList = [];
    try {
      token = await getTokenFromSP();
      var body = json.encode(filters);
      print('body to parse : $body');
      http.Response response = await http.put(filterUsersUrl,
          headers: <String, String>{
            'Authorization': 'jwt ' + token,
            "Content-Type": "application/json"
          },
          body: body);
      print('response : ${response.body}');
      var data = await json.decode(response.body);
      print('message : ${data['message']}');
      print('data : $data');
      var users = data['users'];
      print('users : $users');
      userId = await getUserIdFromSP();
      for (var u in users) {
        // print('adding $u');
        UserModel userModel = UserModel(
            id: u['_id'],
            phoneNumber: u['phoneNumber'],
            name: u['name'],
            age: u['age'],
            bio: u['bio'],
            profession: u['profession'],
            company: u['company'],
            institute: u['institute'],
            graduationYear: u['graduationYear'],
            currentCity: u['currentCity'],
            homeCity: u['homeCity']);
        if (userModel.id != userId) {
          usersList.add(userModel);
        }
        // usersList.add(userModel);
        return usersList;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<bool> sendConnectionRequest(String receivingId) async {
    String sendReuestUrl = url + '/sendConnectionRequest';
    try {
      String sendingId = await getUserIdFromSP();
      var body =
          json.encode({'sendingId': sendingId, 'receivingId': receivingId});
      token = await getTokenFromSP();
      http.Response response = await http.put(sendReuestUrl,
          headers: <String, String>{
            'Authorization': 'jwt ' + token,
            "Content-Type": "application/json"
          },
          body: body);
      print(response.body);
      var data = json.decode(response.body);
      print(data['message']);
      if (data['status']) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> respondConnectionRequest(
      String receivingId, bool connectResponse) async {
    String respondRequestUrl = url + '/respondConnectionRequest';
    try {
      String respondingId = await getUserIdFromSP();
      var body = json.encode({
        'respondingId': respondingId,
        'receivingId': receivingId,
        'connectResponse': connectResponse
      });
      print('sending body : $body');
      token = await getTokenFromSP();
      http.Response response = await http.put(respondRequestUrl,
          headers: <String, String>{
            'Authorization': 'jwt ' + token,
            "Content-Type": "application/json"
          },
          body: body);
      print(response.body);
      var data = json.decode(response.body);
      print(data['message']);
      if (data['status']) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> signOut() async {
    try {
      if (sharedPreferences == null) {
        sharedPreferences = await SharedPreferences.getInstance();
      }
      sharedPreferences.remove('token');
      sharedPreferences.remove('userId');
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
