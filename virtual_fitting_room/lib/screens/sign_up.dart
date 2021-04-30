import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:virtual_fitting_room/provider/auth.dart';
import 'package:virtual_fitting_room/screens/home.dart';
import 'package:virtual_fitting_room/screens/login.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class signUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return signUpStatefulWidget();
  }
}

class signUpStatefulWidget extends StatefulWidget {
  signUpStatefulWidget({Key key}) : super(key: key);

  @override
  signUpStatefulWidgetState createState() => signUpStatefulWidgetState();
}

class signUpStatefulWidgetState extends State<signUpStatefulWidget> {
  bool _passwordVisible;
  final _signUpFormKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passowrdController = TextEditingController();
  String email = "";
  String password = "";

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("An Error occured"),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
              child: Text("Okay"),
              onPressed: () {
                Navigator.of(ctx).pop();
              })
        ],
      ),
    );
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passowrdController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Builder(builder: (BuildContext context) {
      double _height = MediaQuery.of(context).size.height;
      double _width = MediaQuery.of(context).size.width;
      return ListView(children: <Widget>[
        SizedBox(height: _height * 0.015),
        Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
              new Container(
                margin: EdgeInsets.only(
                    top: _height * 0.03, bottom: _height * 0.01),
                child: Center(
                    child: Image.asset(
                  'assets/logo.jpg',
                  width: _width * 0.15,
                )),
              ),
              SizedBox(height: _height * 0.02),
              new Container(
                  margin: EdgeInsets.only(
                      top: _height * 0.01, bottom: _height * 0.01),
                  child: Center(
                      child: Text(
                    "Sign Up Now",
                    style: TextStyle(
                        color: Color(0xFF9F140B),
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ))),
              SizedBox(height: _height * 0.01),
              new Container(
                width: _width * 0.8,
                child: Center(
                    child: Text(
                  "Please fill the details and create account",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
                )),
              ),
              new Container(
                  width: _width * 0.8,
                  margin: EdgeInsets.only(top: _height * 0.05),
                  child: Form(
                    key: _signUpFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        new Container(
                            child: TextFormField(
                          controller: fullNameController,
                          inputFormatters: [
                            new FilteringTextInputFormatter.allow(
                                RegExp("[a-zA-Z]"))
                          ],
                          validator: (value) {
                            if (value.isEmpty) {
                              return "* Please enter your Name";
                            } else if (value.length < 2) {
                              return "* Please enter valid Name";
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
                              borderSide: BorderSide(width: 0.2),
                            ),
                            hintText: 'Full Name',
                          ),
                          autofocus: false,
                        )),
                        SizedBox(height: _height * 0.02),
                        new Container(
                            child: TextFormField(
                          controller: emailController,
                          onChanged: (val) => setState(() => email = val),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "* Please enter your Email";
                            } else if (!EmailValidator.validate(value)) {
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
                              borderSide: BorderSide(width: 0.2),
                            ),
                            hintText: 'Email',
                          ),
                          autofocus: false,
                        )),
                        SizedBox(height: _height * 0.02),
                        new Container(
                            child: TextFormField(
                          controller: passowrdController,
                          onChanged: (val) => setState(() => password = val),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "* Please enter your Password";
                            } else if (value.length < 5) {
                              return "* Password must contain at least 5 characters";
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
                              borderSide: BorderSide(width: 0.2),
                            ),
                            hintText: 'Password',
                            suffixIcon: IconButton(
                              icon: Icon(
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                          ),
                          autofocus: false,
                          obscureText: _passwordVisible,
                          enableSuggestions: false,
                          autocorrect: false,
                        )),
                        SizedBox(height: _height * 0.02),
                        new Container(
                            width: _width * 0.8,
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  new Container(
                                      height: _height * 0.07,
                                      child: RaisedButton(
                                        onPressed: () async {
                                          if (_signUpFormKey.currentState
                                              .validate()) {
                                            try {
                                              Provider.of<Auth>(context,
                                                      listen: false)
                                                  .signUp(email, password);
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) => login()));
                                            } catch (error) {
                                              _showErrorDialog(error);
                                            }
                                          }
                                        },
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            side: BorderSide(
                                                color: Color(0xFF9F140B))),
                                        color: Color(0xFF9F140B),
                                        child: Text(
                                          "Sign Up",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25,
                                          ),
                                        ),
                                      )),
                                  SizedBox(height: _height * 0.02),
                                  new Container(
                                    margin:
                                        EdgeInsets.only(bottom: _height * 0.03),
                                    child: Center(
                                        child: RichText(
                                            text: TextSpan(
                                      children: <InlineSpan>[
                                        TextSpan(
                                          text: "Already have an account? ",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        TextSpan(
                                            text: "Log In",
                                            style: TextStyle(
                                                color: Color(0xFF9F140B)),
                                            recognizer:
                                                new TapGestureRecognizer()
                                                  ..onTap = () {
                                                    Navigator.pop(context);
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              login()),
                                                    );
                                                  })
                                      ],
                                    ))),
                                  ),
                                  new Container(
                                    child: Center(
                                        child: Text(
                                      "Or connect with",
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.normal),
                                    )),
                                  ),
                                  SizedBox(height: _height * 0.02),
                                  new Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        new Container(
                                          child: SignInButton(
                                            Buttons.Facebook,
                                            mini: true,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                            onPressed: () {},
                                          ),
                                        ),
                                        new Container(
                                          child: SignInButton(
                                            Buttons.Twitter,
                                            mini: true,
                                            onPressed: () {},
                                          ),
                                        ),
                                        new Container(
                                          child: SignInButton(
                                            Buttons.Google,
                                            onPressed: () {},
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ]))
                      ],
                    ),
                  ))
            ]))
      ]);
    }));
  }
}
