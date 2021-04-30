import 'package:flutter/material.dart';
import 'package:virtual_fitting_room/widgets/painted_line.dart';

class myAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Container(
        alignment: Alignment.topCenter,
        width: _width * 0.87,
        margin: EdgeInsets.only(top: _height * 0.04, bottom: _height * 0.03),
        child: SingleChildScrollView(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
              new Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "My Account",
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
                painter: CurvePainter(Color(0xFF9F140B), Color(0x269F140B), 2),
              ),
              SizedBox(
                height: _height * 0.025,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Container(
                      child: ClipOval(
                          child: Image.asset("assets/profile.png")),
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Container(
                      child: Text(
                        "Mohamed",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      margin: EdgeInsets.only(left: _width * 0.03),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: _height * 0.05,
              ),
              Row(children: <Widget>[
                Expanded(
                  flex: 4,
                  child: Container(
                    child: Text(
                      "Email: ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Container(
                    child: Center(
                        child: Text(
                      'email@google.com',
                      style: TextStyle(fontSize: 15),
                    )),
                  ),
                ),
              ]),
              SizedBox(
                height: _height * 0.03,
              ),
              Row(children: <Widget>[
                Expanded(
                  flex: 4,
                  child: Container(
                    child: Text(
                      "Password: ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Container(
                    child: Center(
                        child: Text(
                      "******",
                      style: TextStyle(fontSize: 15),
                    )),
                  ),
                ),
              ]),
              SizedBox(
                height: _height * 0.03,
              ),
              new Divider(
                color: Colors.black12,
                thickness: 1,
              ),
              InkWell(
                  onTap: () {},
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Center(
                        child: Text(
                          "Edit Profile",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ))),
              new Divider(
                color: Colors.black12,
                thickness: 1,
              ),
              InkWell(
                  onTap: () {},
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Center(
                        child: Text(
                          "Change Password",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ))),

              new Divider(
                color: Colors.black12,
                thickness: 1,
              ),
            ])));
  }
}
