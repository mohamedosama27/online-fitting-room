import 'dart:convert';
import 'dart:io' as Io;
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:virtual_fitting_room/models/measurements.dart';
import 'package:virtual_fitting_room/services/file_service.dart';
class MeasurementService {
  Future<Measurements> getmeasurements(Io.File frontImageFile,Io.File sideImageFile,int height) async{
    List<int> frontImageBytes = await Io.File(frontImageFile.path).readAsBytes();
    String frontBase64Encode = base64.encode(frontImageBytes);
    List<int> sideimageBytes = await Io.File(sideImageFile.path).readAsBytes();
    String sidebase64Encode = base64.encode(sideimageBytes);
    var image = {
      "frontImage": "${frontBase64Encode}",
      "sideImage": "${sidebase64Encode}",
      "height": "${height}",
      "uniqueId": "1"};
    var JsonBody = image;
    var response = await http.post(
        Uri.parse("http://10.0.2.2:6000/get_measurement"),
        body: jsonEncode(JsonBody),
        headers: {"content-type": "application/json"});
    bool completed = false;
    var wait = {"waiting": "1", "uniqueId": "1"};
    while (!completed) {
      await _sleep(4);
      var response2 =await http.post(
          Uri.parse(
              "http://10.0.2.2:6000/get_measurement"),
          body: jsonEncode(wait),
          headers: {"content-type": "application/json"});

      var jsonResponse2 = jsonDecode(response2.body);
      var status = jsonResponse2['Status'];
      if (status == 'Done') {
        completed = true;
        var measurements=Measurements(chest:jsonResponse2["measurements"]['chest'],hip:   jsonResponse2['measurements']["hip"]);
        return measurements;
      }
    }
  }
  Future _sleep(duration) {
    return new Future.delayed(Duration(seconds: duration));
  }
}