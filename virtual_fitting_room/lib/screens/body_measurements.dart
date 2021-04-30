import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:virtual_fitting_room/provider/measurement.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:virtual_fitting_room/models/measurements.dart';
import 'package:virtual_fitting_room/screens/home.dart';
import 'package:virtual_fitting_room/services/file_service.dart';
import 'package:virtual_fitting_room/widgets/loading_indicator.dart';
import 'package:virtual_fitting_room/widgets/body_measurements_background.dart';
import 'package:virtual_fitting_room/screens/human_model.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class bodyMeasurements extends StatefulWidget {
  Measurements measurements;

  bodyMeasurements({Key key, this.measurements}) : super(key: key);

  @override
  bodyMeasurementsStatefulWidgetState createState() =>
      bodyMeasurementsStatefulWidgetState();
}

class bodyMeasurementsStatefulWidgetState extends State<bodyMeasurements> {
  final _formKey = GlobalKey<FormState>();
  String height = "";
  String weight = "";
  String hip = "";
  String chest = "";
  final List<String> images = [
    'weight.jpg',
    'height.jpg',
    'chest.jpg',
    'hip.png',
  ];
  final List<String> items = [
    '*Body Weight:',
    'Body Height:',
    'Chest',
    'Hip',
  ];
  final List<TextEditingController> controllers = [];
  final List<String> measurementsUnits = ['Kg', 'Cm', 'Cm', 'Cm'];
  AppBar appBar = AppBar(
    title: Text("Virtual Fitting Room"),
    backgroundColor: Color(0xFF9F140B),
    centerTitle: true,
    automaticallyImplyLeading: true,
  );
  @override
  void initState() {
    String height = widget.measurements.height == null
        ? ''
        : widget.measurements.height.toInt().toString();
    String chest = widget.measurements.chest == null
        ? ''
        : widget.measurements.chest.toInt().toString();
    String hip = widget.measurements.hip == null
        ? ''
        : widget.measurements.hip.toInt().toString();
    TextEditingController bodyWeightController = new TextEditingController();
    TextEditingController bodyHeightController =
        new TextEditingController(text: height);
    TextEditingController bodyChestController =
        new TextEditingController(text: chest);
    TextEditingController bodyHipController =
        new TextEditingController(text: hip);
//    TextEditingController bodyWaistController = new TextEditingController();
//    TextEditingController bodyArmController = new TextEditingController();
    controllers.add(bodyWeightController);
    controllers.add(bodyHeightController);
    controllers.add(bodyChestController);
    controllers.add(bodyHipController);
//    controllers.add(bodyWaistController);
//    controllers.add(bodyArmController);
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: appBar,
        body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);

              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: Container(
                child: CustomPaint(
                    size: Size(_width, _height),
                    painter: backGroundCurve(),
                    child: Form(
                        key: _formKey,
                        child: Stack(children: <Widget>[
                          ListView.builder(
                              itemCount: items.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    ListTile(
                                      leading: Text(
                                        '${items[index]}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      title: Row(
                                        children: [
                                          Container(
                                              width: _width * 0.2,
                                              height: _height * 0.06,
                                              child: TextFormField(
                                                textInputAction:
                                                    TextInputAction.next,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .digitsOnly
                                                ],
                                                keyboardType:
                                                    TextInputType.number,
                                                controller: controllers[index],
                                                onChanged: (val) => setState(
                                                    () => weight = val),
                                                validator: (value) {
                                                  if (value.isEmpty) {
                                                    return "* Please enter your " +
                                                        items[index];
                                                  }
                                                  return null;
                                                },
                                                decoration: new InputDecoration(
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        BorderSide(width: 0.2),
                                                  ),
                                                  focusedErrorBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        BorderSide(width: 0.2),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        BorderSide(width: 0.2),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        BorderSide(width: 0.2),
                                                  ),
                                                ),
                                                autofocus: false,
                                              )),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(measurementsUnits[index])
                                        ],
                                      ),
                                      trailing: ClipOval(
                                        child: Material(
                                          color: Color(0x4071A411),
                                          // button color
                                          child: SizedBox(
                                            width: _height * 0.2 / 2,
                                            height: _height * 0.2 / 2,
                                            child: Image.asset(
                                              'assets/${images[index]}',
                                              width: _width * 0.2,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    new Divider(
                                      color: Colors.black12,
                                      thickness: 1,
                                    ),
                                  ],
                                );
                              }),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                                width: _width * 0.5,
                                height: _height * 0.07,
                                margin: EdgeInsets.only(bottom: 10),
                                child: Consumer<measurement>(
                                  builder: (ctx, value, _) => RaisedButton(
                                    child: Text('Confirm',
                                        style: TextStyle(fontSize: 24)),
                                    onPressed: () {
                                      if (_formKey.currentState.validate()) {
                                        /*    getObject(
                                              controllers[0].text,
                                              controllers[1].text,
                                              controllers[2].text,
                                              controllers[3].text,
                                              '99',
                                              '31',
                                              context),*/
                                        value.add(
                                          id: DateTime.now().toString(),
                                          weight:
                                              double.parse(controllers[0].text),
                                          height:
                                              double.parse(controllers[1].text),
                                          chest:
                                              double.parse(controllers[2].text),
                                          hip:
                                              double.parse(controllers[3].text),
                                        );
                                      }
                                    },
                                    color: Color(0xFF9F140B),
                                    textColor: Colors.white,
                                  ),
                                )),
                          )
                        ]))))));
  }

  Future sleep() {
    return new Future.delayed(const Duration(seconds: 1));
  }

  void getObject(
      weight, height, chest, hip, waist, arm, BuildContext context) async {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    var data = {
      "measurement": {
        "weight": "${weight}",
        "height": "${height}",
        "chest": "${chest}",
        "hip": "${hip}",
        "waist": "${waist}",
        "arm": "${arm}"
      },
      "uniqueId": "1"
    };
    var response = await http.post(
        Uri.parse("https://human-modelling.herokuapp.com/create-model"),
        body: jsonEncode(data),
        headers: {"content-type": "application/json"});
    var wait = {"waited": "1", "uniqueId": "1"};
    bool completed = false;
    DialogBuilder(context).showLoadingIndicator('Loading');
    while (!completed) {
      await sleep();
      var response2 = await http.post(
          Uri.parse("https://human-modelling.herokuapp.com/create-model"),
          body: jsonEncode(wait),
          headers: {"content-type": "application/json"});
      var jsonResponse = jsonDecode(response2.body);
      var processing = jsonResponse['completed'];
      if (processing == 'False') {
        completed = true;
        var object = jsonResponse["object"];
        Uint8List objectUtf = base64.decode(object);
        String objectString = utf8.decode(objectUtf);
        FileService fileService = new FileService(path: "human.obj");
        await fileService.writeObject(objectString);
      }
    }
    DialogBuilder(context).hideOpenDialog();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Home()),
    );
  }
}
