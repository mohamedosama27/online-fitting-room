import 'package:flutter/cupertino.dart';
import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:virtual_fitting_room/screens/human_model.dart';
import 'package:virtual_fitting_room/services/file_service.dart';
import 'package:flutter_cube/flutter_cube.dart';
import 'dart:ui' as ui;

class TextureScreen extends StatefulWidget {
  TextureScreen({Key key}) : super(key: key);

  @override
  TextureState createState() => TextureState();
}

class TextureState extends State<TextureScreen> {
  String path;
  Future<bool> isDataFetched;
  Object cloth;

  Future<bool> getImagePath() async {
    try {
      FileService fileService = new FileService(path: "texture.jpg");
      this.path = await fileService.localPath;
      if (!await io.File(this.path + "/texture.jpg").exists()) {
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  initState() {
    isDataFetched = getImagePath();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: Color(0xFF9F140B),
          title: Text(
            "Virtual Fitting Room",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Column(
          children: [
            Container(
              height: _height * 0.75,
              alignment: Alignment.center,
              child: FutureBuilder<bool>(
                  future: isDataFetched,
                  builder:
                      (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return CircularProgressIndicator();
                      default:
                        if (snapshot.data == true) {
                          return Center(child: Cube(
                            onSceneCreated: (Scene scene) {
                              cloth = Object(
                                  fileName: this.path + '/output_filename.obj',
                                  isAsset: false,
                                  position: Vector3(0, 1, 0));
                              cloth.backfaceCulling = false;
                              scene.world.add(cloth);
                              scene.camera.viewportHeight = 500;
                              scene.camera.zoom = 4;
                            },
                          ));
                        } else {
                          return CircularProgressIndicator();
                        }
                    }
                  }),
            ),
          ],
        ));
  }
}
