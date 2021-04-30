import 'package:flutter/material.dart';
import 'package:virtual_fitting_room/widgets/painted_line.dart';

class Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF9F140B),
          centerTitle: true,
          title: Center(
              child: Text("Virtual Fitting Room",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 25))),
        ),
        body: Center(
            child: Container(
                width: _width * 0.87,
                margin: EdgeInsets.only(
                    top: _height * 0.04, bottom: _height * 0.02),
                child: Column(children: <Widget>[
                  new Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Cart",
                      style: TextStyle(
                          fontSize: 25,
                          color: Color(0xFF9F140B),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: _height * 0.025,
                  ),
                  CustomPaint(
                    size: Size(_width * 0.87, _height * 0.006),
                    painter:
                        CurvePainter(Color(0xFF9F140B), Color(0x269F140B), 3),
                  ),
                ]))));
  }
}
