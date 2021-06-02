import 'package:flutter/material.dart';
import 'package:virtual_fitting_room/widgets/painted_line.dart';

class ClothDetails extends StatelessWidget {
  String itemName;
  String itemImage;
  String itemPrice;
  String itemSize = "Medium";
  String itemType = "Jacket";
  ClothDetails({this.itemName, this.itemImage, this.itemPrice});

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
                      "Cloth Details",
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
                        CurvePainter(Color(0xFF9F140B), Color(0x269F140B), 2),
                  ),
                  SizedBox(
                    height: _height * 0.025,
                  ),
                  Container(
                    child: Text(
                      this.itemName,
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: _height * 0.015,
                  ),
                  new Container(
                      height: _height * 0.2,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(this.itemImage),
                          fit: BoxFit.fill,
                        ),
                      )),
                  SizedBox(
                    height: _height * 0.015,
                  ),
                  new Divider(
                    color: Colors.black12,
                    thickness: _height * 0.002,
                  ),
                  SizedBox(
                    height: _height * 0.015,
                  ),
                  Row(children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: Container(
                        child: Text(
                          "Price: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: Container(
                          child: Center(
                        child: Text(
                          this.itemPrice + " L.E",
                          style: TextStyle(fontSize: 15),
                        ),
                      )),
                    ),
                  ]),
                  SizedBox(
                    height: _height * 0.015,
                  ),
                  new Divider(
                    color: Colors.black12,
                    thickness: _height * 0.002,
                  ),
                  SizedBox(
                    height: _height * 0.015,
                  ),
                  Row(children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: Container(
                        child: Text(
                          "Type: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: Container(
                        child: Center(
                            child: Text(
                          this.itemName,
                          style: TextStyle(fontSize: 15),
                        )),
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: _height * 0.015,
                  ),
                  new Divider(
                    color: Colors.black12,
                    thickness: _height * 0.002,
                  ),
                  SizedBox(
                    height: _height * 0.015,
                  ),
                  Row(children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: Container(
                        child: Text(
                          "Size: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: Container(
                        child: Center(
                            child: Text(
                          this.itemSize,
                          style: TextStyle(fontSize: 15),
                        )),
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: _height * 0.015,
                  ),
                  new Divider(
                    color: Colors.black12,
                    thickness: _height * 0.002,
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        children: [
                          Expanded(
                            child: RaisedButton(
                              child: Text('Try now',
                                  style: TextStyle(fontSize: 24)),
                              onPressed: () async => {},
                              color: Color(0xFF9F140B),
                              textColor: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: _width * 0.02,
                          ),
                          Expanded(
                            child: RaisedButton(
                              child: Text('Add to cart',
                                  style: TextStyle(fontSize: 24)),
                              onPressed: () async => {},
                              color: Color(0xFF9F140B),
                              textColor: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ]))));
  }
}
