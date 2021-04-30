import 'dart:convert';
import 'dart:io' as Io;
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:virtual_fitting_room/services/file_service.dart';

class ModellingService {
  Future<void> getBody(Io.File imageFile) async {
    List<int> imageBytes = await Io.File(imageFile.path).readAsBytes();
    String base64Encode = base64.encode(imageBytes);
    var image = {"image": "${base64Encode}", "uniqueId": "1"};
    var body = image;
    var response = await http.post(
        Uri.parse("https://virtual--fitting--room.herokuapp.com/upload-image"),
        body: jsonEncode(body),
        headers: {"content-type": "application/json"});
    var jsonResponse = jsonDecode(response.body);
    var processing = jsonResponse["processing"];
    bool completed = false;
    var wait = {"wait": "1", "uniqueId": "1"};
    while (!completed) {
      await _sleep(4);
      var response2 =await http.post(
          Uri.parse(
              "https://virtual--fitting--room.herokuapp.com/upload-image"),
          body: jsonEncode(wait),
          headers: {"content-type": "application/json"});

        var jsonResponse2 = jsonDecode(response2.body);
        var processing = jsonResponse2['processing'];
        if (processing == 'False') {
          completed = true;
          var image64 = jsonResponse2["image"];
          Uint8List bytes = base64.decode(image64);
          FileService fileService = new FileService(path: "body.jpg");
          fileService.writeImage(bytes);
        }
    }
  }

  Future _sleep(duration) {
    return new Future.delayed(Duration(seconds: duration));
  }

  Future<void> getTextureImg(Io.File frontImageFile,Io.File backImageFile,String clothType) async{
    List<int> frontImageBytes = await Io.File(frontImageFile.path).readAsBytes();
    String frontBase64Encode = base64.encode(frontImageBytes);
    List<int> backimageBytes = await Io.File(backImageFile.path).readAsBytes();
    String backbase64Encode = base64.encode(backimageBytes);
    var image = {
      "frontImage": "${frontBase64Encode}",
      "backImage": "${backbase64Encode}",
      "clothType": clothType,
      "id": "1"};
    var JsonBody = image;
    var response = await http.post(
        Uri.parse("http://10.0.2.2:5000/get_Seg"),
        body: jsonEncode(JsonBody),
        headers: {"content-type": "application/json"});
    var jsonResponse = jsonDecode(response.body);
    var object = jsonResponse["object"];
    Uint8List objectBytes = base64.decode(object);
    FileService fileService = new FileService(path: "output_filename.obj");
    fileService.writeImage(objectBytes);
    var mtl = jsonResponse["mtl"];
    Uint8List mtlbytes = base64.decode(mtl);
    FileService fileService2 = new FileService(path: "output_filename.mtl");
    fileService2.writeImage(mtlbytes);
    bool completed = false;
    var wait = {"waiting": "1", "id": "1"};
    while (!completed) {
      await _sleep(4);
      var response2 =await http.post(
          Uri.parse(
              "http://10.0.2.2:5000/get_Seg"),
          body: jsonEncode(wait),
          headers: {"content-type": "application/json"});

      var jsonResponse2 = jsonDecode(response2.body);
      var status = jsonResponse2['Status'];
      if (status == 'Done') {
        completed = true;
        var image64 = jsonResponse2["texture"];
        Uint8List bytes = base64.decode(image64);
        FileService fileService3 = new FileService(path: "texture.jpg");
        fileService3.writeImage(bytes);
      }
    }
  }
}
