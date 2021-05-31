import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:virtual_fitting_room/provider/auth.dart';
import 'package:virtual_fitting_room/provider/brand.dart';
import 'package:virtual_fitting_room/screens/vendor_screens/vender_brands.dart';
import 'dart:io';

class AddBrandScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return addBrandStatefulWidget();
  }
}

class addBrandStatefulWidget extends StatefulWidget {
  addBrandStatefulWidget({Key key}) : super(key: key);

  @override
  addBrandStatefulWidgetState createState() => addBrandStatefulWidgetState();
}

class addBrandStatefulWidgetState extends State<addBrandStatefulWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final mobileController = TextEditingController();
  File _image;
  String imgUrl;
  String _name, _mobile, _address;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    mobileController.dispose();
    super.dispose();
  }

  void open_gallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
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
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'BrandName',
                        prefixIcon: Icon(Icons.perm_identity),
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
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter Brand name ';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _name = value;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Address',
                        prefixIcon: Icon(Icons.home),
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
                        _address = value;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Mobile',
                        prefixIcon: Icon(Icons.mobile_friendly),
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
                      validator: (value) {
                        String pattern = r'^(?:[+0][1-9])?[0-9]{10,12}$';
                        RegExp regExp = new RegExp(pattern);

                        if (value.isEmpty || !regExp.hasMatch(value)) {
                          return 'Please enter valid  phone';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _mobile = value;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () => open_gallery(),
                      child: CircleAvatar(
                        radius: 100,
                        backgroundImage: _image != null
                            ? FileImage(_image)
                            : NetworkImage("null"),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    new Container(
                      width: _width * 0.8,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          new Container(
                            height: _height * 0.07,
                            child: Consumer2<brand, Auth>(
                              builder: (ctx, value, auth, _) => FlatButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                textColor: Colors.white,
                                color: Theme.of(context).primaryColor,
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    var storageimage = FirebaseStorage.instance
                                        .ref()
                                        .child(_image.path);
                                    var task = storageimage.putFile(_image);
                                    imgUrl = await (await task.onComplete)
                                        .ref
                                        .getDownloadURL();
                                    _formKey.currentState.save();
                                    value.addBrand(
                                        id: DateTime.now().toString(),
                                        name: _name,
                                        address: _address,
                                        mobile: _mobile,
                                        image: imgUrl,
                                        uid: auth.userId);
                                  }
                                },
                                child: Text('Add Brand',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    )),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ])
            ]));
      }),
    );
  }
}
