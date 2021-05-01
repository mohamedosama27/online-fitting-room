import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class User {
  User({this.uid, this.name, this.gender});
  String uid;
  String name;
  String gender;
}

class Users with ChangeNotifier {
  List<User> userlist = [];

  Future<void> addUser({
    String uid,
    String name,
    String gender,
  }) {
    final String url =
        "https://virtualfittingroom-853d3-default-rtdb.firebaseio.com/User.json";
    return http
        .post(url,
            body: json.encode({
              "uid": uid,
              "name": name,
              "gender": gender,
            }))
        .then((res) {
      userlist.add(User(
        uid: uid,
        name: name,
        gender: gender,
      ));

      notifyListeners();
    });
  }
}
