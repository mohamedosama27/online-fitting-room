import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:virtual_fitting_room/screens/sign_up.dart';

class forgetPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return forgetPasswordStatefulWidget();
  }
}

class forgetPasswordStatefulWidget extends StatefulWidget {
  forgetPasswordStatefulWidget({Key key}) : super(key: key);

  @override
  forgetPasswordStatefulWidgetState createState() => forgetPasswordStatefulWidgetState();
}
class forgetPasswordStatefulWidgetState extends State<forgetPasswordStatefulWidget>{
  final _forgetPformKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  @override
  void dispose() {
  emailController.dispose();
  super.dispose();
  }
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
        body: Builder(
        builder: (BuildContext context) {
           return ListView(children: <Widget>[
              Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                    SizedBox(height: _height*0.1,),
                    new Container(
                    margin:
                    EdgeInsets.only(
                    top: _height * 0.03, bottom: _height * 0.01),
                        child: Center(
                        child: Icon(
                        Icons.lock,
                        size: _width * 0.25,
                        )),
            ),
            SizedBox(height: _height*0.03,),
                      new Container(
                          margin:
                          EdgeInsets.only(
                              top: _height * 0.01, bottom: _height * 0.01),
                          child: Center(
                              child: Text(
                                "Forgot your password?",
                                style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
                              ))),
                      SizedBox(height: _height*0.01,),
                      new Container(
                          child: Center(
                              child: Text(
                                "Confirm your email and we'll send the instructions",
                                style: TextStyle(fontSize: 13,fontWeight: FontWeight.normal),
                              ))),
                      SizedBox(height: _height*0.02,),
                      new Container(
                         width: _width * 0.8,
                         margin: EdgeInsets.only(top: _height * 0.05),
                         child: Form(
                             key: _forgetPformKey,
                              child: new Container(
                                  child: TextFormField(

                                    controller: emailController,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "* Please enter your Email";
                                      }
                                      else if(!EmailValidator.validate(value))
                                      {
                                        return "* Please enter a valid Email";
                                      }
                                      return null;
                                    },
                                    decoration: new InputDecoration(
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(width: 0.2),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(width: 0.2),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(width: 0.2),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide( width: 0.2),
                                      ),
                                      prefixIcon: Icon(Icons.email),
                                      hintText: 'Email',
                                    ),
                                    autofocus: false,
                                  )),
                         )
                      ),
                      SizedBox(height: _height*0.05,),
                      new Container(
                          height:_height*0.07,
                          child: RaisedButton(

                            onPressed: () async {

                              if (_forgetPformKey.currentState
                                  .validate()) {

                              }

                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius
                                    .circular(5.0),
                                side:
                                BorderSide(color: Color(
                                    0xFF9F140B))),
                            color: Color(0xFF9F140B),
                            child: Text(
                              "Reset Password",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                            ),
                          )
                      ),
                      SizedBox(height: _height*0.02,),
                      new Container(
                        margin: EdgeInsets.only(bottom: _height*0.03),
                        child: Center(
                            child: RichText(

                                text: TextSpan(
                                  children:<InlineSpan>[
                                    TextSpan(
                                      text: "Don't have an account? ",
                                      style: TextStyle(
                                          color: Colors.black),
                                    ),
                                    TextSpan(
                                        text: "Sign Up",
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
                                                      signUp()),
                                            );
                                          }
                                    )
                                  ],


                                )
                            )
                        ),
                      ),
                    ]))
    ]);}
    ));
  }

}