import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:virtual_fitting_room/screens/vendor_screens/add_cloth.dart';
import 'package:virtual_fitting_room/widgets/notification_widget.dart';
import 'package:virtual_fitting_room/widgets/painted_line.dart';

class Brands extends StatelessWidget {
  var data = [
    ['H&M', 'assets/HM.png'],
    ['Paul&Bear', 'assets/paul.jpg'],
    ['Zara', 'assets/zara.jpg'],
    ['H&M', 'assets/HM.png'],
    ['Paul&Bear', 'assets/paul.jpg'],
    ['Zara', 'assets/zara.jpg']
  ];

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Container(
        margin: EdgeInsets.only(
            top: _height * 0.04,
            bottom: _height * 0.03,
            left: _width * 0.07,
            right: _width * 0.07),
        child: Column(children: <Widget>[
          new Container(
              height: _height * 0.07,
              width: _width*0.87,
              child: RaisedButton(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => addCloth()),
                  );

                    },
                shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(5.0),
                    side: BorderSide(
                        color: Color(0xFF9F140B))),
                color: Color(0xFF9F140B),
                child: Text(
                  "Add cloth",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              )),
          new Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "Brands",
              style: TextStyle(
                  fontSize: 25,
                  color: Color(0xFF9F140B),
                  fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
              child: GridView.builder(
            itemCount: data.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (BuildContext context, int index) {
              return new Card(
                child: new GridTile(
                  footer: new Container(child:Center(child:Text(data[index][0],style:TextStyle(color: Colors.white),)),height: _height*0.04,color: Colors.black,),
                  child: new Image.asset(data[index]
                      [1],                fit: BoxFit.cover,
                  ),),
              );
            },
          )),
        ]));
  }
}
