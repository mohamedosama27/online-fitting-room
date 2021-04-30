import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';
import 'package:virtual_fitting_room/provider/auth.dart';
import 'package:virtual_fitting_room/screens/cart.dart';
import 'package:virtual_fitting_room/screens/home.dart';
import 'package:virtual_fitting_room/screens/home_page.dart';
import 'package:virtual_fitting_room/widgets/home_item.dart';
import 'package:virtual_fitting_room/widgets/loading_indicator.dart';
import 'package:virtual_fitting_room/screens/sign_up.dart';
import 'package:virtual_fitting_room/screens/images_screen.dart';
import 'package:virtual_fitting_room/screens/forget_password.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:virtual_fitting_room/screens/vendor_screens/vendor_home.dart';
import 'package:virtual_fitting_room/widgets/message_widget.dart';

class login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoginStatefulWidget();
  }
}

class LoginStatefulWidget extends StatefulWidget {
  LoginStatefulWidget({Key key}) : super(key: key);

  @override
  LoginStatefulWidgetState createState() => LoginStatefulWidgetState();
}

class LoginStatefulWidgetState extends State<LoginStatefulWidget> {
  bool _passwordVisible;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passowrdController = TextEditingController();

  String email;
  String password;
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
        SizedBox(height: _height * 0.025),
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
              SizedBox(height: _height * 0.03),
              new Container(
                  margin: EdgeInsets.only(
                      top: _height * 0.01, bottom: _height * 0.01),
                  child: Center(
                      child: Text(
                    "Virtual Fitting Room",
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
                  "Please log in to continue using our app",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
                )),
              ),
              new Container(
                  width: _width * 0.8,
                  margin: EdgeInsets.only(top: _height * 0.05),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
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
                            prefixIcon: Icon(Icons.email),
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
                            prefixIcon: Icon(Icons.security),
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
                        SizedBox(height: _height * 0.01),
                        new Container(
                          alignment: Alignment.centerRight,
                          child: RichText(
                            text: TextSpan(
                                text: "Forgot Password?",
                                style: TextStyle(color: Colors.grey),
                                recognizer: new TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              forgetPassword()),
                                    );
                                  }),
                          ),
                        ),
                        SizedBox(height: _height * 0.025),
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
                                          if (_formKey.currentState
                                              .validate()) {
                                            try {
                                              await Provider.of<Auth>(context,
                                                      listen: false)
                                                  .signIn(email, password);
                                              //   print("3adyt");
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) => Home()));
                                            } catch (error) {
                                              _showErrorDialog(error);
                                            }
                                          }

                                          /*   DialogBuilder(context)
                                                .showLoadingIndicator(
                                                    'Loading');
                                            await Future.delayed(
                                                Duration(seconds: 2), () {
                                              DialogBuilder(context)
                                                  .hideOpenDialog();
                                                      if (emailController.text ==
                                                      'client@miu.com' &&
                                                  passowrdController.text ==
                                                      'client') {
                                                Navigator.pop(context);
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ImagesScreen()));
                                              } else if (emailController.text ==
                                                      'admin@miu.com' &&
                                                  passowrdController.text ==
                                                      'admin') {
                                                Navigator.pop(context);
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            vendorHome()));
                                              } else {
                                                MessageBoxModal(context)
                                                    .showMessageBoxModal(
                                                        'wrong email or password');
                                              }
                                            });*/
                                        },
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            side: BorderSide(
                                                color: Color(0xFF9F140B))),
                                        color: Color(0xFF9F140B),
                                        child: Text(
                                          "Log In",
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
                                          text: "Don't have an account? ",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        TextSpan(
                                            text: "Sign Up",
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
                                                              signUp()),
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
                                          //        padding: EdgeInsets.all(10),
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
