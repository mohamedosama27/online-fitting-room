import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_fitting_room/provider/cloth.dart';
import 'package:virtual_fitting_room/screens/texture.dart';
import 'package:virtual_fitting_room/screens/login.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as Io;

import 'package:virtual_fitting_room/services/modelling_service.dart';
import 'package:virtual_fitting_room/widgets/loading_indicator.dart';
import 'package:virtual_fitting_room/widgets/message_widget.dart';

class addCloth extends StatefulWidget {
  addCloth({Key key}) : super(key: key);

  @override
  addClothState createState() => addClothState();
}

class addClothState extends State<addCloth> {
  Io.File frontimage = null;
  Io.File backimage = null;
  ImagePicker imagePicker = ImagePicker();
  String clothType = null;
  String dropdownValue = 'shirts';
  String frontImgUrl, backImgUrl;
  String _type;
  var _price;
  @override
  void initState() {
    super.initState();
  }

  _imgFromGallery(BuildContext context, bool isFront) async {
    PickedFile pickedFile =
        await imagePicker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      if (isFront) {
        setState(() {
          frontimage = Io.File(pickedFile.path);
        });
      } else {
        setState(() {
          backimage = Io.File(pickedFile.path);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey();
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Virtual Fitting Room"),
          backgroundColor: Color(0xFF9F140B),
        ),
        body: Builder(builder: (BuildContext context) {
          double _height = MediaQuery.of(context).size.height;
          double _width = MediaQuery.of(context).size.width;
          return Form(
              key: _formKey,
              child: ListView(children: <Widget>[
                Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: _height * 0.15,
                        ),
                        Container(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                              Container(
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                    Container(child: Text("cloth front")),
                                    Container(
                                        child: frontimage == null
                                            ? Image.asset(
                                                'assets/front.png',
                                                height: _height * 0.2,
                                              )
                                            : Image.file(
                                                frontimage,
                                                height: _height * 0.2,
                                              )),
                                    new Container(
                                        height: _height * 0.05,
                                        child: RaisedButton(
                                          onPressed: () async {
                                            await _imgFromGallery(
                                                context, true);
                                          },
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              side: BorderSide(
                                                  color: Color(0xFF9F140B))),
                                          color: Color(0xFF9F140B),
                                          child: Text(
                                            "Upload front",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                          ),
                                        )),
                                  ])),
                              SizedBox(
                                width: _width * 0.15,
                              ),
                              Container(
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                    Container(child: Text("cloth back")),
                                    Container(
                                        child: backimage == null
                                            ? Image.asset(
                                                'assets/back.png',
                                                height: _height * 0.2,
                                              )
                                            : Image.file(
                                                backimage,
                                                height: _height * 0.2,
                                              )),
                                    new Container(
                                        height: _height * 0.05,
                                        child: RaisedButton(
                                          onPressed: () async {
                                            await _imgFromGallery(
                                                context, false);
                                          },
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              side: BorderSide(
                                                  color: Color(0xFF9F140B))),
                                          color: Color(0xFF9F140B),
                                          child: Text(
                                            "Upload back",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                          ),
                                        )),
                                  ])),
                            ])),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Price',
                            prefixIcon: Icon(Icons.money),
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.white)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.white)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.white)),
                          ),
                          onSaved: (value) {
                            _price = value;
                          },
                        ),
                        SizedBox(
                          height: _height * 0.10,
                        ),
                        Container(
                          width: _width * 0.43,
                          decoration: new BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: new Border.all(color: Color(0xFF9F140B)),
                          ),
                          child: DropdownButton<String>(
                            value: dropdownValue,
                            icon: const Icon(Icons.arrow_downward),
                            iconSize: 24,
                            elevation: 16,
                            style: const TextStyle(color: Color(0xFF9F140B)),
                            onChanged: (String value) {
                              setState(() {
                                dropdownValue = value;
                              });
                            },
                            items: <String>['shirts', 'pants', 'shorts']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Center(
                                  child: Text(value),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(
                          height: _height * 0.10,
                        ),
                        new Container(
                          height: _height * 0.05,
                          child: Consumer<cloth>(
                              builder: (ctx, value, _) => RaisedButton(
                                    onPressed: () async {
                                      if (frontimage != null &&
                                          backimage != null &&
                                          _formKey.currentState.validate()) {
                                        /*         DialogBuilder(context)
                                            .showLoadingIndicator('Loading');
                                        ModellingService modellingService =
                                            new ModellingService();
                                        await Future.wait([
                                          modellingService.getTextureImg(
                                              frontimage,
                                              backimage,
                                              dropdownValue)
                                        ]);*/
                                        var storagefrontimage = FirebaseStorage
                                            .instance
                                            .ref()
                                            .child(frontimage.path);
                                        var task = storagefrontimage
                                            .putFile(frontimage);
                                        var storagebackimage = FirebaseStorage
                                            .instance
                                            .ref()
                                            .child(frontimage.path);
                                        var task2 =
                                            storagebackimage.putFile(backimage);
                                        frontImgUrl =
                                            await (await task.onComplete)
                                                .ref
                                                .getDownloadURL();
                                        _formKey.currentState.save();

                                        backImgUrl =
                                            await (await task2.onComplete)
                                                .ref
                                                .getDownloadURL();
                                        _formKey.currentState.save();

                                        value.addCloth(
                                          id: DateTime.now().toString(),
                                          frontimage: frontImgUrl,
                                          backimage: backImgUrl,
                                          price: _price,
                                          type: dropdownValue,
                                        );

                                        DialogBuilder(context).hideOpenDialog();
                                        Navigator.pop(context);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    TextureScreen()));
                                      } else if (frontimage == null) {
                                        MessageBoxModal(context)
                                            .showMessageBoxModal(
                                                'please upload front image');
                                      } else if (backimage == null) {
                                        MessageBoxModal(context)
                                            .showMessageBoxModal(
                                                'please upload back image');
                                      }
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        side: BorderSide(
                                            color: Color(0xFF9F140B))),
                                    color: Color(0xFF9F140B),
                                    child: Text(
                                      "show model",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                  )),
                        )
                      ]),
                ),
              ]));
        }));
  }
}
