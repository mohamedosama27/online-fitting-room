import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:virtual_fitting_room/screens/sign_up.dart';
import 'package:virtual_fitting_room/screens/login.dart';

class welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery
        .of(context)
        .size
        .height;
    double _width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
        backgroundColor: Colors.white,
        body: ListView(children: <Widget>[
      Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: _height*0.04,),
                new Container(
              margin:
                  EdgeInsets.only(top: _height * 0.03, bottom: _height * 0.01),
              child: Center(
                  child:Image.asset('assets/logo.jpg',width: _width*0.15,)
              )),
                SizedBox(height: _height*0.07,),
                new Container(
              child: Center(
                  child:Image.asset('assets/welcome.jpg',height: _height*0.2,)
              )),
                SizedBox(height: _height*0.06,),

                new Container(
                  child: Text(
                    "Welcome",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: _height*0.01),
                new Container(
                  width: _width*0.8,
                  child: Center(
                    child:Text(
                    "Create an account and access thousand",
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.normal),
                  )),
                ),
                new Container(
                  width: _width*0.8,
                  child: Center(
                    child:Text(
                    " of cool clothes",
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.normal),
                  )),
                ),
                SizedBox(height: _height*0.07),
                new Container(
                  width: _width*0.8,
                    height:_height*0.07,

                    child: RaisedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context, MaterialPageRoute(
                            builder: (context) =>
                                signUp()));
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius
                              .circular(5.0),
                          side:
                          BorderSide(
                              color: Color(0xFF9F140B))),
                      color: Color(0xFF9F140B),
                      child: Text(
                        "Getting Started",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                    )),
                SizedBox(height: _height*0.02),
                new Container(
                  margin: EdgeInsets.only(bottom: _height*0.03),
                  child: Center(
                      child: RichText(

                          text: TextSpan(
                            children:<InlineSpan>[
                              TextSpan(
                                text: "Already have an account? ",
                                style: TextStyle(
                                    color: Colors.black),
                              ),
                              TextSpan(
                                  text: "Log In",
                                  style: TextStyle(
                                      color: Color(0xFF9F140B)),
                                  recognizer: new TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pop(context);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (
                                                context) =>
                                                login()),
                                      );
                                    }
                              )
                            ],


                          )
                      )
                  ),
                ),
          ]))
    ]));
  }
}
