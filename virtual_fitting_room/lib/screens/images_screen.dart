import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:virtual_fitting_room/models/measurements.dart';
import 'package:virtual_fitting_room/screens/body_measurements.dart';
import 'package:virtual_fitting_room/screens/login.dart';
import 'package:image_picker/image_picker.dart';
import 'package:virtual_fitting_room/services/measurement_service.dart';
import 'dart:io' as Io;
import 'package:virtual_fitting_room/widgets/loading_indicator.dart';
import 'package:virtual_fitting_room/widgets/message_widget.dart';

class ImagesScreen extends StatefulWidget {
  ImagesScreen({Key key}) : super(key: key);

  @override
  ImagesScreenState createState() => ImagesScreenState();
}

class ImagesScreenState extends State<ImagesScreen> {
  Io.File frontimage = null;
  Io.File sideimage = null;
  ImagePicker imagePicker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  TextEditingController bodyHeightController = new TextEditingController(text: '185');

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
          sideimage = Io.File(pickedFile.path);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => login()));
            },
          ),
          centerTitle: true,
          title: Text("Virtual Fitting Room"),
          backgroundColor: Color(0xFF9F140B),
        ),
        body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);

              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: ListView(children: <Widget>[
              SizedBox(height: _height * 0.025),
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                Container(child: Text("Front View")),
                                Container(
                                    child: frontimage == null
                                        ? Image.asset(
                                            'assets/frontView.png',
                                            height: _height * 0.2,
                                          )
                                        : Image.file(frontimage),
                                  height: _height * 0.2,
                                ),
                                new Container(
                                    height: _height * 0.05,
                                    child: RaisedButton(
                                      onPressed: () async {
                                        await _imgFromGallery(context, true);
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                Container(child: Text("Side View")),
                                Container(
                                    child: sideimage == null
                                        ? Image.asset(
                                            'assets/sideView.png',
                                            height: _height * 0.2,
                                          )
                                        : Image.file(sideimage),
                                  height: _height * 0.2,
                                ),
                                new Container(
                                    height: _height * 0.05,
                                    child: RaisedButton(
                                      onPressed: () async {
                                        await _imgFromGallery(context, false);
                                      },
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          side: BorderSide(
                                              color: Color(0xFF9F140B))),
                                      color: Color(0xFF9F140B),
                                      child: Text(
                                        "Upload side",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                    )),
                              ])),
                        ])),
                    SizedBox(
                      height: _height * 0.07,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: _width * 0.5,
                              child: Row(
                                children: [
                                  Text(
                                    'Height',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  SizedBox(
                                    width: _width * 0.02,
                                  ),
                                  Container(
                                      width: _width * 0.2,
                                      height: _height * 0.06,
                                      child: TextFormField(
                                        textInputAction: TextInputAction.next,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        keyboardType: TextInputType.number,
                                        controller: bodyHeightController,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return '';
                                          }
                                          return null;
                                        },
                                        decoration: new InputDecoration(
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(width: 0.2),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(width: 0.2),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(width: 0.2),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(width: 0.2),
                                          ),
                                        ),
                                        autofocus: false,
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('cm')
                                ],
                              ),
                            ),
                            SizedBox(
                              height: _height * 0.05,
                            ),
                            new Container(
                                height: _height * 0.05,
                                width: _width * 0.80,
                                child: RaisedButton(
                                  onPressed: () async {
                                    if (frontimage != null &&
                                        sideimage != null &&
                                        _formKey.currentState.validate()) {
                                      DialogBuilder(context)
                                          .showLoadingIndicator('Loading');
                                      MeasurementService measurementService =
                                          new MeasurementService();
                                      Measurements measurements;
                                        measurements=await measurementService.getmeasurements(
                                        frontimage, sideimage,int.parse(bodyHeightController.text));
                                      DialogBuilder(context).hideOpenDialog();
                                      measurements.height=double.parse(bodyHeightController.text);
                                      print(measurements.height);
                                      print(measurements.hip);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  bodyMeasurements(measurements:measurements)));
                                    } else if (frontimage == null) {
                                      MessageBoxModal(context)
                                          .showMessageBoxModal(
                                              'please upload front image');
                                    } else if (sideimage == null) {
                                      MessageBoxModal(context)
                                          .showMessageBoxModal(
                                              'please upload side image');
                                    } else if (!_formKey.currentState.validate()) {
                                      MessageBoxModal(context)
                                          .showMessageBoxModal(
                                              'please add your height');
                                    }
                                    else {
                                      MessageBoxModal(context)
                                          .showMessageBoxModal(
                                              'An error has occured');
                                    }
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      side:
                                          BorderSide(color: Color(0xFF9F140B))),
                                  color: Color(0xFF9F140B),
                                  child: Text(
                                    "Next",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                )),
                            SizedBox(height: _height*0.03,),
                            new Container(
                                height: _height * 0.05,
                                width: _width * 0.80,
                                child: RaisedButton(
                                  onPressed: () async {

                                    Measurements measurements=new Measurements();
                                    Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  bodyMeasurements(measurements:measurements)));
                                    },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      side:
                                          BorderSide(color: Color(0xFF9F140B))),
                                  color: Colors.white24,
                                  child: Text(
                                    "Skip",
                                    style: TextStyle(
                                      color: Color(0xFF9F140B),
                                      fontSize: 20,
                                    ),
                                  ),
                                )),
                          ]),
                    ),
                    SizedBox(
                      height: _height * 0.07,
                    ),
                  ]))
            ])));
  }
}
