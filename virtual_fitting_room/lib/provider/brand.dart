import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Brand {
  Brand({this.id, this.name, this.address, this.mobile, this.image, this.uid});
  String id;
  String name;
  String address;
  String mobile;
  String image;
  String uid;
}

class brand with ChangeNotifier {
  List<Brand> brandlist = [];

  Future<void> fetchBrand() async {
    const url =
        "https://virtualfittingroom-853d3-default-rtdb.firebaseio.com/brands.json";
    try {
      final http.Response res = await http.get(url);
      //print(json.decode(res.body));
      final extractedBrand = json.decode(res.body) as Map<String, dynamic>;
      extractedBrand.forEach((brandId, brandData) {
        var extractdata = brandlist
            .firstWhere((element) => element.id == brandId, orElse: () => null);
        if (extractdata == null) {
          brandlist.add(Brand(
              address: brandData["address"],
              id: brandId,
              mobile: brandData["mobile"],
              image: brandData["image"],
              name: brandData["name"]));
        }
      });
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addBrand(
      {String id,
      String name,
      String address,
      String mobile,
      String image,
      String uid}) {
    final String url =
        "https://virtualfittingroom-853d3-default-rtdb.firebaseio.com/brands.json";
    return http
        .post(url,
            body: json.encode({
              "id": id,
              "name": name,
              "address": address,
              "mobile": mobile,
              "image": image,
              "uid": uid
            }))
        .then((res) {
      brandlist.add(Brand(
          id: json.decode(res.body)['name'],
          name: name,
          address: address,
          mobile: mobile,
          image: image,
          uid: uid));

      notifyListeners();
    });
  }
}
