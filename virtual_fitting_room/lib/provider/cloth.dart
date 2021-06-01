import 'dart:convert';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Cloth {
  Cloth(
      {this.id,
      this.type,
      this.price,
      this.backimage,
      this.frontimage,
      this.uid});
  String id;
  String type;
  var price;
  String backimage;
  String frontimage;
  String uid;
}

class cloth with ChangeNotifier {
  List<Cloth> clothlist = [];

  Future<void> fetchCloth() async {
    const url =
        "https://virtualfittingroom-853d3-default-rtdb.firebaseio.com/clothes.json";
    try {
      final http.Response res = await http.get(url);
      //print(json.decode(res.body));
      final extractedCloth = json.decode(res.body) as Map<String, dynamic>;
      extractedCloth.forEach((clothId, clothData) {
        var extractdata = clothlist
            .firstWhere((element) => element.id == clothId, orElse: () => null);
        if (extractdata == null) {
          clothlist.add(Cloth(
              type: clothData["type"],
              id: clothId,
              price: clothData["price"],
              backimage: clothData["backimage"],
              frontimage: clothData["frontimage"]));
        }
      });
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addCloth({
    String id,
    String type,
    var price,
    String backimage,
    String frontimage,
    String uid,
  }) {
    final String url =
        "https://virtualfittingroom-853d3-default-rtdb.firebaseio.com/clothes.json";
    return http
        .post(url,
            body: json.encode({
              "id": id,
              "type": type,
              "price": price,
              "backimage": backimage,
              "frontimage": frontimage,
              "uid": uid
            }))
        .then((res) {
      clothlist.add(Cloth(
          id: json.decode(res.body)['name'],
          price: price,
          backimage: backimage,
          frontimage: frontimage,
          type: type,
          uid: uid));

      notifyListeners();
    });
  }
}
