import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';
import 'package:virtual_fitting_room/services/file_service.dart';

class HumanModel extends StatefulWidget {
  HumanModel({Key key}) : super(key: key);

  @override
  HumanModelState createState() => HumanModelState();
}

class HumanModelState extends State<HumanModel> {
  String path;
  Future<bool> isDataFetched;

  Future<bool> getUserModel() async {
    try {
      FileService fileService = new FileService(path: "human.obj");
      this.path = await fileService.localPath;
      if(!await File(this.path+"/human.obj").exists()){
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }
  Object cloth;

  @override
  initState() {
    isDataFetched = getUserModel();
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
        body: Column(children: [
          Container(
            height: _height*0.75,
            color: Colors.black,
            alignment: Alignment.center,
            child: FutureBuilder<bool>(
                future: isDataFetched,
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return CircularProgressIndicator();
                    default:
                      if (snapshot.data == true) {
                        return new Center(child: Cube(
                          onSceneCreated: (Scene scene) {
                            cloth = Object(
                                fileName: path + "/human.obj",
                                isAsset: false);
                            cloth.backfaceCulling = false;
                            scene.world.add(cloth);
                            scene.camera.viewportHeight=350;
                            scene.camera.zoom=7;

                          },
                        ));
                      } else {
                        return CircularProgressIndicator();
                      }
                  }
                }),
          ),

        ]));
  }
}
