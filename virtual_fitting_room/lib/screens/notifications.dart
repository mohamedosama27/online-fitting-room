import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:virtual_fitting_room/widgets/notification_widget.dart';
import 'package:virtual_fitting_room/widgets/painted_line.dart';

class Notifications extends StatelessWidget {
  List<String> notificationTitle = ['Order is delivered','Order review','Order delivery','Order is delivered','Order review','Order delivery','Order is delivered','Order review','Order delivery'];
  List<String> notificationMessege = ['Your order has been delivered to you','Your order has been reviewed by the shop and will deliver it soon','Your order is being delivered to you','Your order has been delivered to you','Your order has been reviewed by the shop and will deliver it soon','Your order is being delivered to you','Your order has been delivered to you','Your order has been reviewed by the shop and will deliver it soon','Your order is being delivered to you',];

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
            alignment: Alignment.centerLeft,
            child: Text(
              "Notifications",
              style: TextStyle(
                  fontSize: 25,
                  color:Color(0xFF9F140B),
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
            height: _height * 0.015,
          ),
          new Flexible(
              child: ListView.builder(
                  itemCount: notificationTitle.length,
                  itemBuilder: (context, index) {
                    return notificationsList(
                        title: notificationTitle[index],
                        messege: notificationMessege[index],
                    seen: false,);
                  }))
        ]));
  }
}




