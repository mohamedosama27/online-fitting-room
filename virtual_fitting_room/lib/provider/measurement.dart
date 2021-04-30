import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Measurement {
  Measurement(
      {this.id, this.weight, this.height, this.chest, this.hip, this.uid});
  String id;
  double weight;
  double height;
  double chest;
  double hip;
  String uid;
}

class measurement with ChangeNotifier {
  List<Measurement> measurmentlist = [];

  Future<void> add(
      {String id,
      double weight,
      double height,
      double chest,
      double hip,
      String uid}) {
    final String url =
        "https://virtualfittingroom-853d3-default-rtdb.firebaseio.com/measurments.json";
    return http
        .post(url,
            body: json.encode({
              "id": id,
              "weight": weight,
              "height": height,
              "chest": chest,
              "hip": hip,
              "uid": uid
            }))
        .then((res) {
      measurmentlist.add(Measurement(
          id: json.decode(res.body)['name'],
          chest: chest,
          height: height,
          hip: hip,
          weight: weight,
          uid: uid));

      notifyListeners();
    });
  }
}
